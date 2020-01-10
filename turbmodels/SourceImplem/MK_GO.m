%**************************************************************************
%       Implementation of k-epsilon MK model
%       Reference,
%       Myong, H.K. and Kasagi, N., "A new approach to the improvement of
%       k-epsilon turbulence models for wall bounded shear flow", JSME 
%       Internationla Journal, 1990. 
%**************************************************************************
% An improved near-wall k-epsilon turbulence model that considers two 
% characteristics lenght scale for dissipation rate.
%
% Conventional models without compressible modifications:
%    k-eq:  0 = Pk - rho e + ddy[(mu+mut/sigma_k) dkdy]
%    e-eq:  0 = C_e1 f1 e/k Pk - C_e2 f2 e^2/k + ddy[(mu+mut/sigma_e)dedy] 
%
% Otero et.al model:
%    k-eq:  0 = Pk - rho e
%               + 1/sqrt(rho) ddy[1/sqrt(rho) (mu+mut/sigma_k) d(rho k)dy]
%    e-eq:  0 = C_e1 f1 e/k Pk - C_e2 f2 e^2/k 
%               + 1/rho ddy[1/sqrt(rho) (mu+mut/sigma_e) d(rho^1.5 e)dy] 
% This models uses "yplus". It must be replace by its semi-locally scaled
% counter part "ystar"
%
% Catris, S. and Aupoix, B., "Density corrections for turbulence
%       models", Aerosp. Sci. Techn., 2000.
%    k-eq:  0 = Pk - rho e 
%               + ddy[1/rho (mu+mut/sigma_k) d(rho k)dy]
%    e-eq:  0 = C_e1 f1 e/k Pk - C_e2 f2 e^2/k 
%               + 1/rho ddy[1/sqrt(rho) (mu+mut/sigma_e) d(rho^1.5 e)dy]
%
% For simplicty, the extra density factors of the Otero et.al and Catris/Aupoix  
% models were implmeneted as extra source terms. Therefore what is solved is:
%    k-eq:  0 = Pk -  rho e + ddy[(mu+mut/sigma_k) dkdy] + Source
%    e-eq:  0 = C_e1 f1 e/k Pk - C_e2 f2 e^2/k + ddy[(mu+mut/sigma_e)dedy] 
%               + Source
%
% Input:
%   u           velocity
%   k           turbulent kinetic energy, from previous time step
%   e           turbulent kinetic energy dissipation rate per unit volume,  
%               from previous time step
%   r           density
%   mu          molecular viscosity
%   ReT         friction Reynolds number ReT=utau r_wall h/ mu_wall
%   mesh        mesh structure
%   compFlag    flag to solve the model with compressible modifications
%
% Output:
%   mut         eddy viscosity or turbulent viscosity
%   k           solved turbulent kinetic energy
%   e           solved turbulent kinetic energy dissipation rate per unit
%               volume

function [k,e,mut] = MK(u,k,e,r,mu,ReT,mesh,compFlag)

    n        = size(r,1);
    y        = mesh.y;
   	wallDist = min(y, 2-y);

    if(compFlag==1)
        yplus = wallDist*ReT.*sqrt(r/r(1))./(mu/mu(1));
    else
        yplus = wallDist*ReT;
    end

    % Model constants
    cmu  = 0.09; 
    sigk = 1.4; 
    sige = 1.3; 
    Ce1  = 1.4; 
    Ce2  = 1.8;
    
    % Relaxation factor
    underrelaxK  = 0.8;
    underrelaxE  = 0.8;

    % ---------------------------------------------------------------------
    % eddy viscosity
    ReTurb = r.*(k.^2)./(mu.*e);
    f2     = (1-2/9*exp(-(ReTurb/6).^2)).*(1-exp(-yplus/5)).^2;
    fmue   = (1-exp(-yplus/70)).*(1.0+3.45./(ReTurb.^0.5));   
    fmue(1:n-1:n) = 0.0;
    
    mut  = cmu*fmue.*r./e.*k.^2;
    mut(2:n-1) = min(max(mut(2:n-1),1.0e-10),100.0);

    
    % ---------------------------------------------------------------------
    % Turbulent production
    dudy = mesh.ddy*u;
    Pk   = mut.*dudy.^2;

    
    if (compFlag > 1)
        drdy = mesh.ddy*r;
        dkdy = mesh.ddy*k;
        dedy = mesh.ddy*e;
    end




    % ---------------------------------------------------------------------
    % e-equation
    mueff = mu + mut/sige;
    
    % extra source terms for the modified models
    Source = zeros(n,1);
    if  (compFlag > 0)        % Otero et.Al and Catris/Aupoix
        term1 = 1./r .*mueff .* drdy .* dedy;
        Di = mueff.*e.*drdy;
        dDidy = mesh.ddy*Di;
        term2 = 1.5*dDidy./r;
        Source = term1 + term2; 
    end

    % Left-hand-side, implicit matrix
    A =   bsxfun(@times, mueff, mesh.d2dy2) ... 
        + bsxfun(@times, (mesh.ddy*mueff), mesh.ddy);

    % Left-hand-side, implicitly treated source term
    for i=2:n-1
        A(i,i) = A(i,i) - Ce2*f2(i)*r(i)*e(i)/k(i);
    end

    % Right-hand-side
    b = -e(2:n-1)./k(2:n-1).*Ce1.*Pk(2:n-1)- Source(2:n-1);
    
    % Wall boundary conditions
    e(1) = mu(1)/r(1)*k(2  )/wallDist(2  )^2;
    e(n) = mu(n)/r(n)*k(n-1)/wallDist(n-1)^2;

    % Solve eps equation
    e = solveEq(e,A,b,underrelaxE);
    e(2:n-1) = max(e(2:n-1), 1.e-12);
    

    % ---------------------------------------------------------------------
    % k-equation
    mueff = mu + mut/sigk;
    
    % extra source terms for the modified models
    Source = zeros(n,1);
    
    if (compFlag==1)        % Otero et.Al
        
        term1 = 0.5./r .*mueff .*drdy .* dkdy;
        Di = mueff.*k.*drdy./sqrt_r;
        [dDidy] = mesh.ddy*Di;
        term2 = dDidy./sqrt_r;
        Source = term1 + term2;
        
    elseif (compFlag==2)    % Catris/Aupoix  
        
        Di = mueff.*k.*drdy./r;
        dDidy = mesh.ddy*Di;
        Source = dDidy;
        
    end
    
    % diffusion matrix: mueff*d2()/dy2 + dmueff/dy d()/dy
    A =   bsxfun(@times, mueff, mesh.d2dy2) ... 
        + bsxfun(@times, (mesh.ddy*mueff), mesh.ddy);
    
    % implicitly treated source term
    for i=2:n-1
        A(i,i) = A(i,i) - r(i).*e(i)./k(i);
    end
    
    % Right-hand-side
    b  = -Pk(2:n-1) - Source(2:n-1);
    
    % Solve TKE
    k = solveEq(k,A,b,underrelaxK);
    k(2:n-1) = max(k(2:n-1), 1.e-12);

end

