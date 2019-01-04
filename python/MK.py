#**************************************************************************
#       Implementation of k-epsilon MK model
#       Reference,
#       Myong, H.K. and Kasagi, N., "A new approach to the improvement of
#       k-epsilon turbulence models for wall bounded shear flow", JSME 
#       Internationla Journal, 1990. 
#**************************************************************************
# An improved near-wall k-epsilon turbulence model that considers two 
# characteristics lenght scale for dissipation rate.
#
# Conventional models without compressible modifications:
#    k-eq:  0 = Pk - rho e + ddy[(mu+mut/sigma_k) dkdy]
#    e-eq:  0 = C_e1 f1 e/k Pk - C_e2 f2 e^2/k + ddy[(mu+mut/sigma_e)dedy] 
#
# Otero et.al model:
#    k-eq:  0 = Pk - rho e
#               + 1/sqrt(rho) ddy[1/sqrt(rho) (mu+mut/sigma_k) d(rho k)dy]
#    e-eq:  0 = C_e1 f1 e/k Pk - C_e2 f2 e^2/k 
#               + 1/rho ddy[1/sqrt(rho) (mu+mut/sigma_e) d(rho^1.5 e)dy] 
# This models uses "yplus". It must be replace by its semi-locally scaled
# counter part "ystar"
#
# Catris, S. and Aupoix, B., "Density corrections for turbulence
#       models", Aerosp. Sci. Techn., 2000.
#    k-eq:  0 = Pk - rho e 
#               + ddy[1/rho (mu+mut/sigma_k) d(rho k)dy]
#    e-eq:  0 = C_e1 f1 e/k Pk - C_e2 f2 e^2/k 
#               + 1/rho ddy[1/sqrt(rho) (mu+mut/sigma_e) d(rho^1.5 e)dy]
#
# For simplicty, the extra density factors of the Otero et.al and Catris/Aupoix  
# models were implmeneted as extra source terms. Therefore what is solved is:
#    k-eq:  0 = Pk -  rho e + ddy[(mu+mut/sigma_k) dkdy] + Source
#    e-eq:  0 = C_e1 f1 e/k Pk - C_e2 f2 e^2/k + ddy[(mu+mut/sigma_e)dedy] 
#               + Source
#
# Input:
#   u           velocity
#   k           turbulent kinetic energy, from previous time step
#   e           turbulent kinetic energy dissipation rate per unit volume,  
#               from previous time step
#   r           density
#   mu          molecular viscosity
#   ReT         friction Reynolds number ReT=utau r_wall h/ mu_wall
#   mesh        mesh structure
#   compFlag    flag to solve the model with compressible modifications
#
# Output:
#   mut         eddy viscosity or turbulent viscosity
#   k           solved turbulent kinetic energy
#   e           solved turbulent kinetic energy dissipation rate per unit
#               volume

def MK(u,k,e,r,mu,ReT,mesh,compFlag):

    import numpy as np
    from solveEqn import solveEqn

    n        = np.size(r)
    y        = mesh.y
    wallDist = np.minimum(y, 2-y)

    if compFlag == 1:
        yplus = wallDist*ReT*np.sqrt(r/r[0])/(mu/mu[0])
    else:
        yplus = wallDist*ReT


    # Model constants
    cmu  = 0.09 
    sigk = 1.4 
    sige = 1.3 
    Ce1  = 1.4 
    Ce2  = 1.8
    
    # Relaxation factor
    underrelaxK  = 0.8
    underrelaxE  = 0.7

    # ---------------------------------------------------------------------
    # eddy viscosity
    ReTurb = r*np.power(k, 2)/(mu*e)
    f2     = (1-2/9*np.exp(-np.power(ReTurb/6, 2)))*np.power(1-np.exp(-yplus/5), 2)
    fmue   = (1-np.exp(-yplus/70))*(1.0+3.45/np.power(ReTurb, 0.5))
    fmue[0]   = 0.0
    fmue[n-1] = 0.0
    
    mut  = cmu*fmue*r/e*np.power(k,2)
    mut[1:n-1] = np.minimum(np.maximum(mut[1:n-1],1.0e-10),100.0)

    
    # ---------------------------------------------------------------------
    # Turbulent production
    dudy = mesh.ddy@u
    Pk   = mut*np.power(dudy, 2)


    # ---------------------------------------------------------------------
    # e-equation
    #    0 = C_e1 f1 e/k Pk - C_e2 f2 e^2/k + fd*ddy[mueff*d(fs*e)dy] 
    
    # effective viscosity
    if compFlag >= 1:
        mueff = (mu + mut/sige)/np.sqrt(r)   
        fs = np.power(r, 1.5)
        fd = 1/r
    else: 
        mueff = mu + mut/sige           
        fs = np.ones(n)   
        fd = np.ones(n)


    # diffusion matrix: mueff*d2()/dy2 + dmueff/dy d()/dy
    A = np.einsum('i,ij->ij',mueff*fd, mesh.d2dy2) + np.einsum('i,ij->ij', (mesh.ddy@mueff)*fd, mesh.ddy)

    # Left-hand-side, implicitly treated source term
    for i in range(1,n-1):
        A[i,i] = A[i,i] - Ce2*f2[i]*r[i]*e[i]/k[i]/fs[i]

    # Right-hand-side
    b = -e[1:n-1]/k[1:n-1]*Ce1*Pk[1:n-1]
    
    # Wall boundary conditions
    e[0  ] = mu[0  ]/r[0  ]*k[1  ]/np.power(wallDist[1  ], 2)
    e[n-1] = mu[n-1]/r[n-1]*k[n-2]/np.power(wallDist[n-2], 2)

    # Solve eps equation
    e = solveEqn(e*fs, A, b, underrelaxE)/fs
    e[1:n-1] = np.maximum(e[1:n-1], 1.e-12)
    

    # ---------------------------------------------------------------------
    # k-equation
    #    0 = Pk - rho e + fd*ddy[mueff*d(fs*k)dy]

    # effective viscosity
    if compFlag == 1:
        mueff = (mu + mut/sigk)/np.sqrt(r)   
        fs = r   
        fd = 1/np.sqrt(r)
    elif compFlag == 2:
        mueff = (mu + mut/sigk)/r         
        fs = r   
        fd = np.ones(n)
    else: 
        mueff = mu + mut/sigk      
        fs = np.ones(n)   
        fd = np.ones(n)

    # diffusion matrix: mueff*d2()/dy2 + dmueff/dy d()/dy
    A = np.einsum('i,ij->ij',mueff*fd, mesh.d2dy2) + np.einsum('i,ij->ij', (mesh.ddy@mueff)*fd, mesh.ddy)
    
    # implicitly treated source term
    for i in range(1,n-1):
        A[i,i] = A[i,i] - r[i]*e[i]/k[i]/fs[i]
    
    # Right-hand-side
    b  = -Pk[1:n-1]
    
    # Solve TKE
    k = solveEqn(k*fs, A, b, underrelaxK)/fs
    k[1:n-1] = np.maximum(k[1:n-1], 1.e-12)

    return k,e,mut


