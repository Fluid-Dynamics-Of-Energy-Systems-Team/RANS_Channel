

#**************************************************************************
#
# RANS solver for fully developed turbulent channel with varying properties
# 
#       Created on: Nov 22, 2017
#          Authors: Rene Pecnik         (R.Pecnik@tudelft.nl)
#                   Gustavo J. Otero R. (G.J.OteroRodriguez@tudelft.nl)
#                   Process & Energy Department, Faculty of 3mE
#                   Delft University of Technology, the Netherlands.
#       Literature: Otero et al., 2017. Heat and fluid flow
# Last modified on: Jan 07, 2018
#               By: Rene Pecnik 
#**************************************************************************



import matplotlib.pyplot as plt
import numpy as np


from mesh import Mesh
from solveEqn import solveEqn

from Cess import Cess
from SA import SA
from MK import MK
from KOmSST import KOmSST
from V2F import V2F





## ------------------------------------------------------------------------
#
# User defined inputs
#

# -----  choose test case   -----
# constProperty  ... constant properties: rho = 1; mu = 1/ReT
# constReTauStar ... constant semi-local Reynolds number, rho and mu variable
# gasLike        ... gas-like fluid behaviour
# liquidLike     ... liquid-like fluid behaviour
casename = 'liquidLike'

# -----  choose turbulence model  -----
# 'Cess'... Cess, R.D., "A survery of the literature on heat transfer in 
#           turbulent tube flow", Tech. Rep. 8-0529-R24, Westinghouse, 1958.
# 'SA'  ... Spalart, A. and Allmaras, S., "One equation turbulence model for 
#           aerodynamic flows", Recherche Aerospatiale-French edition, 1994.
# 'MK'  ... Myong, H.K. and Kasagi, N., "A new approach to the improvement of
#           k-epsilon turbulence models for wall bounded shear flow", JSME 
#           Internationla Journal, 1990.
# 'SST' ... Menter, F.R., "Zonal Two equation k-omega turbulence models for 
#           aerodynamic flows", AIAA 93-2906, 1993.
# 'V2F' ... Medic, G. and Durbin, P.A., "Towards improved prediction of heat 
#           transfer on turbine blades", ASME, J. Turbomach. 2012.
# 'no'  ... without turbulence model; laminar
turbMod = 'V2F'

# -----  compressible modification  -----
# 0 ... Conventional models without compressible modifications
# 1 ... Otero et al.
# 2 ... Catris, S. and Aupoix, B., "Density corrections for turbulence
#       models", Aerosp. Sci. Techn., 2000.  
compMod = 0

# -----  solve energy equation  ----- 
# 0 ... energy eq not solved, density and viscosity taken from DNS
# 1 ... energy eq solved
solveEnergy = 0


## ------------------------------------------------------------------------
#
# Generate mesh
#
height = 2      # channel height
n = 100          # number of mesh points
fact = 6        # streching factor and stencil for finite difference discretization
mesh = Mesh(n, height, fact, 1) 



ReTau = 500



## ------------------------------------------------------------------------
#
#  Solve RANS 
#
# initialize vectors
u    = np.zeros(n)
r    = np.ones(n)
mu   = np.ones(n)/ReTau
T    = np.ones(n)

# turbulent scalars
k    = 0.1*np.ones(n)
k[0] = 0.0
k[n-1] = 0.0

e    = 0.001*np.ones(n)
v2   = 1/3*k
om   = np.ones(n)
mut  = np.zeros(n)
nuSA = np.ones(n)/ReTau
nuSA[0] = 0.0
nuSA[n-1] = 0.0

#--------------------------------------------------------------------------
#
#       Iterate RANS equations
#
nmax   = 4000
tol    = 1.0e-8      # iteration limits
nResid = 50       # interval to print residuals

residual = 1.0e20
iter = 0

while residual > tol and iter<nmax:
#while iter<nmax:
    
    # solve temperature:  d/dy[(lam+mut/PrT)dTdy] = -VolQ/ReTau/Pr
#    if (solveEnergy == 1)
#
#        Prt = ones(n,1);    # simply set turbulent Prandtl number to 1
#
#        # effective conductivity: lambda_laminar + mut/PrT
#        lam = (T.^expLam)/(ReTau*Pr);
#        lamEff = lam + (mut./Prt);
#
#        # diffusion matrix: lamEff*d2phi/dy2 + dlamEff/dy dphi/dy
#        A =   bsxfun(@times,          lamEff, MESH.d2dy2) ... 
#            + bsxfun(@times, MESH.ddy*lamEff, MESH.ddy);
#
#        # Isothermal BC
#        T(1) = 1;
#        T(n) = 1;
#
#        # source term
#        b = -VolQ*ones(n-2,1)/(ReTau*Pr);
#
#        # Solve
#        T = solveEq(T,A,b,0.95);
#        
#        # calculate density and viscosity from temperature
#         r =  T.^expRho;
#        mu = (T.^expMu)/ReTau;
    

    # Solve turbulence model to calculate eddy viscosity 
    if   turbMod == 'V2F':       k,e,v2,mut = V2F(u,k,e,v2,r,mu,mesh,compMod)
    elif turbMod == 'MK':        k,e,mut    = MK(u,k,e,r,mu,ReTau,mesh,compMod)
    elif turbMod == 'SST':       k,om,mut   = KOmSST(u,k,om,r,mu,mesh,compMod)
    elif turbMod == 'SA':        nuSA,mut   = SA(u,nuSA,r,mu,mesh,compMod)
    elif turbMod == 'Cess':      mut        = Cess(r, mu, ReTau, mesh, compMod)
    else:	                        mut        = np.zeros(n)


    # Solve momentum equation:  0 = d/dy[(mu+mut)dudy] - rho fx
    mueff = mu + mut
       
    # diffusion matrix: mueff*d2phi/dy2 + dmueff/dy dphi/dy    
    A = np.einsum('i,ij->ij',mueff, mesh.d2dy2) + np.einsum('i,ij->ij', mesh.ddy@mueff, mesh.ddy)
    
    # Right hand side
    b = -np.ones(n-2)
        
    # Solve
    u_old = u.copy()
    u = solveEqn(u,A,b,1)
    residual = np.linalg.norm(u-u_old)
    
    # Printing residuals
    if (iter % nResid == 0):
        print(iter, residual)

    iter = iter + 1
    
    
print(iter, residual)



    
## ------------------------------------------------------------------------
# plotting the velocity profiles

# first calculate uplus (not really necessary, since utau = 1.0 already)

y      = mesh.y
dudy   = mesh.ddy@u
utau   = np.sqrt(mu[0]*dudy[0]/r[0])
upl    = u/utau



#ReTst  = ReTau*sqrt(r/r(1))./(mu/mu(1));      # semi-local Reynolds number
ypl    = y*ReTau                              # yplus (based on wall units)
#yst    = y.*ReTst                            # ystar (based on semi-local scales)

# analytic results for viscous sub-layer
yp = np.linspace(0.1,13,100)
plt.semilogx(yp,yp,'k-.')
    
# semi-empirical result for log-layer
yp = np.linspace(0.9,3,20)
plt.semilogx(np.power(10, yp), 1/0.41*np.log(np.power(10, yp))+5.0,'k-.')


# calculate van Driest velocity, uvd = int_0^upl (sqrt(r) dupl)
#uvd = velTransVD(upl,r)
    
# calculate semi-locally scaled velocity, ustar (see Patel et al. JFM 2017)
#[ust] = velTransSLS(uvd, ReTst, MESH); 

plt.semilogx(ypl[1:n//2],upl[1:n//2],linewidth=3) 

plt.xlabel('$y^+$')
plt.ylabel('$u^+$')


## DNS results 
#h2 = semilogx(DNSdata(:,3),DNSdata(:,13),'ko','LineWidth', 1, 'MarkerSize', 8);
#
#legend([h2,h1],{'DNS', 'Model'}, 'Location','northwest');
#xlabel( '$y^\star$');
#ylabel( '$u^\star$');
#set(gca,'fontsize', 18)
#
#    
    
    