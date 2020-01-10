%**************************************************************************
%       Implementation of k-omega SST
%       Reference,
%       Menter, F.R., "Zonal Two equation k-omega turbulence models for 
%       aerodynamic flows", AIAA 93-2906, 1993.
%**************************************************************************
% Two equation turbulence model, which combines Wilcox k-omega model
% and k-epsilon mode through a blending funcion
%
% Conventional models without compressible modifications:
%    k-eq:  0 = Pk - (beta_star rho k om) + ddy[(mu+mut*sigma_k) dkdy]
%    om-eq: 0 = alpha rho/mut Pk - (betar rho om^2) 
%               + ddy[(mu+mut*sigma_om)domdy] + (1-BF1) CDkom
%
% Otero et.al model:
%    k-eq:  0 = Pk - (beta_star rho k om) 
%               + 1/sqrt(rho) ddy[1/sqrt(rho) (mu+mut*sigma_k) d(rho k)dy]
%    om-eq: 0 = alpha rho/mut Pk - (betar rho om^2) 
%               + ddy[1/sqrt(rho) (mu+mut*sigma_om)d(sqrt(rho) om)dy] 
%               + (1-BF1) CDkom_mod
%
% Catris, S. and Aupoix, B., "Density corrections for turbulence
%       models", Aerosp. Sci. Techn., 2000.
%    k-eq:  0 = Pk - (beta_star rho k om) 
%               + ddy[1/rho (mu+mut*sigma_k) d(rho k)dy]
%    om-eq: 0 = alpha rho/mut Pk - (betar rho om^2) 
%               + ddy[1/sqrt(rho) (mu+mut*sigma_om)d(sqrt(rho) om)dy] 
%               + (1-BF1) CDkom
%
% For simplicty, the extra density factors of the Otero et.al and Catris/Aupoix  
% models were implmeneted as extra source terms. Therefore what is solved is:
%    k-eq:  0 = Pk - (beta_star rho k om) + ddy[(mu+mut*sigma_k) dkdy]
%               + Source
%    om-eq: 0 = alpha rho/mut Pk - (betar rho om^2) 
%               + ddy[(mu+mut*sigma_om)domdy] + (1-BF1) CDkom + Source
%
% Input:
%   u           velocity
%   k           turbulent kinetic energy, from previous time step
%   om          turbulent kinetic energy dissipation rate, from previous 
%               time step
%   r           density
%   mu          molecular viscosity
%   mesh        mesh structure
%   compFlag    flag to solve the model with compressible modifications
%
% Output:
%   mut         eddy viscosity or turbulent viscosity
%   k           solved turbulent kinetic energy
%   om          solved turbulent kinetic energy dissipation rate
%   CDkom       cross diffusion of k and omega 
%               CDkom = (2.0 sigma_om2 rho/om) dk/dy dom/dy);
%   bf1         blending function factor 1
%   bf2         blending function factor 2

function [k,om,mut,CDkom,bF1,bF2] = KOmSST(u,k,om,r,mu,mesh,compFlag)

    n = size(r,1);

    % model constants
    sigma_k1  = 0.85;
    sigma_k2  = 1.0;
    sigma_om1 = 0.5;
    sigma_om2 = 0.856;
    beta_1    = 0.075;
    beta_2    = 0.0828;
    betaStar  = 0.09;
    a1        = 0.31;
    alfa_1    = beta_1/betaStar - sigma_om1*0.41^2.0/betaStar^0.5;
    alfa_2    = beta_2/betaStar - sigma_om2*0.41^2.0/betaStar^0.5;    
    
    % Relaxation factors
    underrelaxK  = 0.6;
    underrelaxOm = 0.4;
        
    % required gradients
    drdy  = mesh.ddy*r;
    dkdy  = mesh.ddy*k;
    domdy = mesh.ddy*om;
    
    wallDist = min(mesh.y, 2-mesh.y);
    sqrt_r = sqrt(r);

    % VortRate = StrainRate in fully developed channel
    strMag = abs(mesh.ddy*u); 
    
    % Blending functions 
    CDkom  = 2.0*sigma_om2*r./om.*dkdy.*domdy;
    gamma1 = 500.0*mu./(r.*om.*wallDist.^2.0);
    gamma2 = 4.0*sigma_om2*r.*k./(wallDist.^2.*max(CDkom,1.0e-20));
    gamma3 = sqrt(k)./(betaStar*om.*wallDist);
    gamma  = min(max(gamma1, gamma3), gamma2);
    bF1    = tanh(gamma.^4.0); 
    gamma  = max(2.0*gamma3, gamma1);
	bF2    = tanh(gamma.^2.0); 

    % more model constants
    alfa     = alfa_1*bF1    + (1-bF1)*alfa_2;
    beta     = beta_1*bF1    + (1-bF1)*beta_2;
    sigma_k  = sigma_k1*bF1  + (1-bF1)*sigma_k2;
    sigma_om = sigma_om1*bF1 + (1-bF1)*sigma_om2;
    
    % Eddy viscosity
    zeta = min(1.0./om, a1./(strMag.*bF2));
	mut = r.*k.*zeta;
    mut = min(max(mut,0.0),100.0);

    % ---------------------------------------------------------------------
    % om-equation
    mueff = mu + sigma_om.*mut; 
    
    %extra source term for the modified models
    Source = zeros(n-2,1);
    if (compFlag==1) % Otero et.Al
        
        Di = 0.5*mueff.*om.*drdy./r;        
        dDidy = mesh.ddy*Di;
        Bfs1 = 0.5*om./r.*dkdy.*drdy;
        Bfs2 =      k./r.*domdy.*drdy;
        Bfs3 = 0.5*om.*k./(r.^2).*drdy.*drdy;
        Bfs = 2*sigma_om2*r(2:n-1).*(1-bF1)./om(2:n-1).*(Bfs1(2:n-1) + Bfs2(2:n-1)+ Bfs3(2:n-1));
        Source = dDidy(2:n-1) + Bfs;
        
    elseif (compFlag==2) % Catris/Aupoix
        
        Di = 0.5*mueff.*om.*drdy./r; 
        dDidy = mesh.ddy*Di;       
        Source = dDidy(2:n-1);
        
    end
    
    % diffusion matrix: mueff*d2()/dy2 + dmueff/dy d()/dy
    A =   bsxfun(@times, mueff, mesh.d2dy2) ... 
        + bsxfun(@times, mesh.ddy*mueff, mesh.ddy);
    
    % implicitly treated source term
    for i=2:n-1
        A(i,i) = A(i,i) - beta(i)*r(i)*om(i);
    end
    
    % Right-hand-side
    b = -alfa.*r.*strMag.^2 - (1-bF1).*CDkom - Source;
    b = b(2:n-1);
    
    % Wall boundary conditions
    om(1) = 60.0*mu(1)/beta_1/r(1)/wallDist(2  )^2;
    om(n) = 60.0*mu(n)/beta_1/r(n)/wallDist(n-1)^2;

    % Solve
    om = solveEq(om,A,b,underrelaxOm);
    om(2:n-1) = max(om(2:n-1), 1.e-12);
    
    
    
    % ---------------------------------------------------------------------
    % k-equation
    mueff = mu + sigma_k.*mut;
    
    %extra source term for the modified models
    Source = zeros(n,1);
    if (compFlag==1) % Otero et.Al
        
        term1 = 0.5./r .*mueff .*drdy .* dkdy;
        Di = mueff.*k.*drdy./sqrt_r;
        [dDidy] = mesh.ddy*Di;
        term2 = dDidy./sqrt_r;
        Source = term1 + term2;
       
    elseif (compFlag==2) % Catris/Aupoix
        
       Di = mueff.*k.*drdy./r;
       [dDidy] = mesh.ddy*Di;
       Source = dDidy;
        
    end
   
    % diffusion matrix: mueff*d2()/dy2 + dmueff/dy d()/dy
    A =   bsxfun(@times, mueff, mesh.d2dy2) ... 
        + bsxfun(@times, (mesh.ddy*mueff), mesh.ddy);

    % implicitly treated source term
    for i=2:n-1
        A(i,i) = A(i,i) - betaStar*r(i)*om(i);
    end
    
    % Right-hand-side
    Pk = min(mut.*strMag.^2, 20*betaStar*k.*r.*om);
    b  = -Pk(2:n-1) - Source(2:n-1); 
    
    % Solve
    k = solveEq(k,A,b,underrelaxK);
    k(2:n-1) = max(k(2:n-1), 1.e-12);

end





