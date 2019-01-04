#**************************************************************************
#       Implementation of the v2f model
#       Reference,
#       Medic, G. and Durbin, P.A., "Towards improved prediction of heat 
#       transfer on turbine blades", ASME, J. Turbomach. 2012.
#**************************************************************************
#
# Conventional models without compressible modifications:
#    k-eq:  0 = Pk - rho e + ddy[(mu+mut/sigma_k) dkdy]
#    e-eq:  0 = (C_e1 Pk - C_e2 rho e)/T  + ddy[(mu+mut/sigma_e)dedy] 
#    v2-eq: 0 = rho k f - 6 rho v2 e/k + ddy[(mu+mut/sigma_k) dv2dy]
#    f-eq:  L^2 d2fdy2 - f = [C1 -6v2/k -2/3(C1-1)]/T -C2 Pk/(rho k)  
#                
# Otero et.al compressibility modifications:
#    k-eq:  0 = Pk - rho e
#               + 1/sqrt(rho) ddy[1/sqrt(rho) (mu+mut/sigma_k) d(rho k)dy]
#    e-eq:  0 = (C_e1 Pk - C_e2 rho e)/T 
#               + 1/rho ddy[1/sqrt(rho) (mu+mut/sigma_e) d(rho^1.5 e)dy] 
#    v2-eq: 0 = rho k f - 6 rho v2 e/k 
#               + ddy[1/sqrt(rho) (mu+mut/sigma_k) d(rho v2)dy]
#    f-eq:  L^2 d2fdy2 - f = [C1 -6v2/k -2/3(C1-1)]/T -C2 Pk/(rho k) 
#
# Catris, S. and Aupoix, B., "Density corrections for turbulence
#       models", Aerosp. Sci. Techn., 2000.
#    k-eq:  0 = Pk - rho e 
#               + ddy[1/rho (mu+mut/sigma_k) d(rho k)dy]
#    e-eq:  0 = (C_e1 Pk - C_e2 rho e)/T 
#               + 1/rho ddy[1/sqrt(rho) (mu+mut/sigma_e) d(rho^1.5 e)dy]
#    v2-eq: 0 = rho k f - 6 rho v2 e/k 
#               + ddy[1/rho (mu+mut/sigma_k) d(rho v2)dy]
#    f-eq:  L^2 d2fdy2 - f = [C1 -6v2/k -2/3(C1-1)]/T -C2 Pk/(rho k) 
#
# Input:
#   u           velocity
#   k           turbulent kinetic energy, from previous time step
#   e           turbulent kinetic energy dissipation rate per unit volume,  
#               from previous time step
#   v2          wall normal velocity fluctuation, from previos time step
#   r           density
#   mu          molecular viscosity
#   mesh        mesh structure
#   compFlag    flag to solve the model with compressible modifications
#
# Output:
#   mut         eddy viscosity  (turbulent viscosity)
#   k           turbulent kinetic energy
#   e           turbulent kinetic energy dissipation rate
#   v2          wall normal velocity fluctuation

def V2F(u,k,e,v2,r,mu,mesh,compFlag):
    
    import numpy as np
    from solveEqn import solveEqn


    n = np.size(r)    
    f = np.zeros(n)

    # Model constants
    cmu  = 0.22 
    sigk = 1.0 
    sige = 1.3 
    Ce2  = 1.9
    Ct   = 6 
    Cl   = 0.23 
    Ceta = 70 
    C1   = 1.4 
    C2   = 0.3

    # Relaxation factors
    underrelaxK  = 0.8
    underrelaxE  = 0.8
    underrelaxV2 = 0.8

    # Time and length scales, eddy viscosity and turbulent production
    Tt  = np.maximum(k/e, Ct*np.power(mu/(r*e), 0.5))
    Lt  = Cl*np.maximum(np.power(k, 1.5)/e, Ceta*np.power(np.power(mu/r, 3)/e, 0.25))
    mut = np.maximum(cmu*r*v2*Tt, 0.0)
    Pk  = mut*np.power(mesh.ddy@u, 2.0)

    # pre-factors to implement compressiblity modifications for diffusion term
    # fs  ... prefactor to multiply scalar in the diffusion term
    # fd  ... prefactor for the diffusion term 
    # if conventional model is used, these factors are 1
    fs = np.ones(n)
    fd = np.ones(n)
    
    # ---------------------------------------------------------------------
    # f-equation 
    #    L^2 d2fdy2 - f = [C1 -6v2/k -2/3(C1-1)]/T -C2 Pk/(rho k)
    
    # implicitly treated source term
    A = np.einsum('i,ij->ij',Lt*Lt, mesh.d2dy2)
    np.fill_diagonal(A, A.diagonal() - 1.0)
    
    # Right-hand-side
    vok  = v2[1:n-1]/k[1:n-1]
    rhsf = ((C1-6)*vok - 2/3*(C1-1))/Tt[1:n-1] - C2*Pk[1:n-1]/(r[1:n-1]*k[1:n-1])
    
    # Solve
    f = solveEqn(f,A,rhsf,1)
    f[1:n-1] = np.maximum(f[1:n-1], 1.e-12)

    
    # ---------------------------------------------------------------------
    # v2-equation: 
    #   0 = rho*k*f - 6*rho*v2*e/k + fd*ddy[mueff*d(fs*v2dy)]
    
    # effective viscosity and pre-factors for compressibility implementation
    if compFlag == 1:
        mueff = (mu + mut)/np.sqrt(r)   
        fs = r   
        fd = 1/np.sqrt(r)
    elif compFlag == 2:
        mueff = (mu + mut)/r         
        fs = r   
        fd = np.ones(n)
    else: 
        mueff = mu + mut      
        fs = np.ones(n)   
        fd = np.ones(n)
    
    # diffusion matrix: mueff*d2()/dy2 + dmueff/dy d()/dy
    A = np.einsum('i,ij->ij',mueff*fd, mesh.d2dy2) + np.einsum('i,ij->ij', (mesh.ddy@mueff)*fd, mesh.ddy)

    # implicitly treated source term
    for i in range(1,n-1):
        A[i,i] = A[i,i] - 6.0*r[i]*e[i]/k[i]/fs[i]
    
    # Right-hand-side
    b = -r[1:n-1]*k[1:n-1]*f[1:n-1]
    
    # Solve
    v2 = solveEqn(v2*fs,A,b,underrelaxV2)/fs
    v2[1:n-1] = np.maximum(v2[1:n-1], 1.e-12)
    

    # ---------------------------------------------------------------------
    # e-equation
    #   0 = (C_e1 Pk - C_e2 rho e)/T  + fd*ddy[mueff*d(fs*edy)] 
        
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
    
    # implicitly treated source term
    for i in range(1,n-1):
        A[i,i] = A[i,i] - Ce2/Tt[i]*r[i]/fs[i]
    
    # Right-hand-side
    Ce1 = 1.4*(1 + 0.045*np.sqrt(k[1:n-1]/v2[1:n-1]))
    b = -1/Tt[1:n-1]*Ce1*Pk[1:n-1]
    
    # Wall boundary conditions
    e[0]   = mu[0  ]*k[1  ]/r[0  ]/np.power(mesh.y[1  ]-mesh.y[0  ], 2)
    e[n-1] = mu[n-1]*k[n-2]/r[n-1]/np.power(mesh.y[n-1]-mesh.y[n-2], 2)

    # Solve
    e = solveEqn(e*fs, A, b, underrelaxE)/fs
    e[1:n-1] = np.maximum(e[1:n-1], 1.e-12)

    
    # ---------------------------------------------------------------------
	# k-equation
    #    0 = Pk - rho e + fd*ddy[mueff*d(fs*kdy)]
    
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
    b = -Pk[1:n-1]
    
    # Solve
    k = solveEqn(k*fs, A, b, underrelaxK)/fs
    k[1:n-1] = np.maximum(k[1:n-1], 1.e-12)
    
    return k,e,v2,mut



