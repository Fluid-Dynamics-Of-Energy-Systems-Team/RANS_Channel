%**************************************************************************
%       Implementation of the v2f model
%       Reference,
%       Medic, G. and Durbin, P.A., "Towards improved prediction of heat 
%       transfer on turbine blades", ASME, J. Turbomach. 2012.
%**************************************************************************
% A four equation k-epsilon turbulence model (extra equation for v'2 and f) 
% that incorporates the near-wall turbulence anisotropy as well as the
% non-local pressure strain effects.
%
% Conventional models without compressible modifications:
%    k-eq:  0 = Pk - rho e + ddy[(mu+mut/sigma_k) dkdy]
%    e-eq:  0 = (C_e1 Pk - C_e2 rho e)/T  + ddy[(mu+mut/sigma_e)dedy] 
%    v2-eq: 0 = rho k f - 6 rho v2 e/k + ddy[(mu+mut/sigma_k) dv2dy]
%    f-eq:  L^2 d2fdy2 - f = [C1 -6v2/k -2/3(C1-1)]/T -C2 Pk/(rho k)  
%                
% Otero et.al model:
%    k-eq:  0 = Pk - rho e
%               + 1/sqrt(rho) ddy[1/sqrt(rho) (mu+mut/sigma_k) d(rho k)dy]
%    e-eq:  0 = (C_e1 Pk - C_e2 rho e)/T 
%               + 1/rho ddy[1/sqrt(rho) (mu+mut/sigma_e) d(rho^1.5 e)dy] 
%    v2-eq: 0 = rho k f - 6 rho v2 e/k 
%               + ddy[1/sqrt(rho) (mu+mut/sigma_k) d(rho v2)dy]
%    f-eq:  L^2 d2fdy2 - f = [C1 -6v2/k -2/3(C1-1)]/T -C2 Pk/(rho k) 
%
% Catris, S. and Aupoix, B., "Density corrections for turbulence
%       models", Aerosp. Sci. Techn., 2000.
%    k-eq:  0 = Pk - rho e 
%               + ddy[1/rho (mu+mut/sigma_k) d(rho k)dy]
%    e-eq:  0 = (C_e1 Pk - C_e2 rho e)/T 
%               + 1/rho ddy[1/sqrt(rho) (mu+mut/sigma_e) d(rho^1.5 e)dy]
%    v2-eq: 0 = rho k f - 6 rho v2 e/k 
%               + ddy[1/rho (mu+mut/sigma_k) d(rho v2)dy]
%    f-eq:  L^2 d2fdy2 - f = [C1 -6v2/k -2/3(C1-1)]/T -C2 Pk/(rho k) 
%
% For simplicty, the extra density factors of the Otero et.al and Catris/Aupoix  
% models were implmeneted as extra source terms. Therefore what is solved is:
%    k-eq:  0 = Pk -  rho e + ddy[(mu+mut/sigma_k) dkdy] + Source
%    e-eq:  0 = (C_e1 Pk - C_e2 rho e)/T  + ddy[(mu+mut/sigma_e)dedy] 
%               + Source
%    v2-eq: 0 = rho k f - 6 rho v2 e/k + ddy[(mu+mut/sigma_k) dv2dy]
%               + Source 
%    f-eq:  L^2 d2fdy2 - f = [C1 -6v2/k -2/3(C1-1)]/T -C2 Pk/(rho k)  
%
% Input:
%   u           velocity
%   k           turbulent kinetic energy, from previous time step
%   e           turbulent kinetic energy dissipation rate per unit volume,  
%               from previous time step
%   v2          wall normal velocity fluctuation, from previos time step
%   r           density
%   mu          molecular viscosity
%   mesh        mesh structure
%   compFlag    flag to solve the model with compressible modifications
%
% Output:
%   mut         eddy viscosity or turbulent viscosity
%   k           solved turbulent kinetic energy
%   e           solved turbulent kinetic energy dissipation rate per unit
%               volume
%   v2          solved wall normal velocity fluctuation

function [k,e,v2,mut] = V2F(u,k,e,v2,r,mu,mesh,compFlag)

    n = size(r,1);    
    f = zeros(n,1);
    sqrt_r = sqrt(r);
    
    % Model constants
    cmu = 0.22; 
    sigk = 1.0; 
    sige = 1.3; 
    Ce2 = 1.9;
    Ct = 6; 
    Cl = 0.23; 
    Ceta = 70; 
    C1 = 1.4; 
    C2 = 0.3;

    % Relaxation factors
    underrelaxK  = 0.8;
    underrelaxE  = 0.8;
    underrelaxV2 = 0.8;
    
    % Calculating gradients
    dudy  = mesh.ddy*u;
    dkdy  = mesh.ddy*k;
    drdy  = mesh.ddy*r;
    dedy  = mesh.ddy*e;
    dv2dy  = mesh.ddy*v2;

    
    % Estimating the eddy viscosity
    Tt = max(k./e, Ct*(mu./(r.*e)).^0.5);
    Lt = Cl*max((k.^1.5)./e, Ceta*(((mu./r).^3)./e).^0.25);
    mut = cmu*r.*v2.*Tt;
    
    % ---------------------------------------------------------------------
	% k-equation
    mueff = mu + mut/sigk;
    
    %*****************************************
    %extra source term for the modified models
    Source = zeros(n,1);
    if      (compFlag==1) % Otero et.Al
        term1 = 0.5./r .*mueff .*drdy .* dkdy;
        Di = mueff.*k.*drdy./sqrt_r;
        [dDidy] = calcGrad(Di,mesh);
        term2 = dDidy./sqrt_r;
        
        Source = term1 + term2;
    elseif (compFlag==2) % Catris/Aupoix  
        Di = mueff.*k.*drdy./r;
        [dDidy] = calcGrad(Di,mesh);
        
        Source = dDidy;
    end
    
    % diffusion matrix: mueff*d2()/dy2 + dmueff/dy d()/dy
    A =   bsxfun(@times, mueff, mesh.d2dy2) ... 
        + bsxfun(@times, (mesh.ddy*mueff), mesh.ddy);
    
    % implicitly treated source term
    for i=2:n-1
        A(i,i) = A(i,i) - r(i)*e(i)/k(i);
    end
    
    % Right hand side
    strMag = dudy(2:n-1);
    Pk = mut(2:n-1).*(strMag).^2;
    b = - Pk - Source(2:n-1);
    
    % Solve
    k = solveEq(k,A,b,underrelaxK);
    k(2:n-1) = max(k(2:n-1), 1.e-12);

    % ---------------------------------------------------------------------
    % e-equation
    mueff = mu + mut/sige;
    
    %*****************************************
    % extra source term for the modified models
    Source = zeros(n,1);
    if      (compFlag>0) % Otero et.Al and Catris/Aupoix
        term1 = 1./r .*mueff .*drdy .* dedy;
        Di = mueff.*e.*drdy;
        [dDidy] = calcGrad(Di,mesh);
        term2 = 1.5*dDidy./r;
        
        Source = term1 + term2;
    end
    
    % diffusion matrix: mueff*d2()/dy2 + dmueff/dy d()/dy
    A =   bsxfun(@times, mueff, mesh.d2dy2) ... 
        + bsxfun(@times, (mesh.ddy*mueff), mesh.ddy);
    
    % implicitly treated source term
    for i=2:n-1
        A(i,i) = A(i,i) - Ce2/Tt(i)*r(i);
    end
    
    % Right hand side
    Ce1 = 1.4*(1 + 0.045*(k(2:n-1)./v2(2:n-1)).^0.5);
    b = -1./Tt(2:n-1).*Ce1.*Pk - Source(2:n-1); 
    
    % Wall boundary conditions
    e(1) = mu(1)*k(2  )/r(1)/(mesh.y(2)-mesh.y(1  ))^2;
    e(n) = mu(n)*k(n-1)/r(n)/(mesh.y(n)-mesh.y(n-1))^2;

    % Solve
    e = solveEq(e,A,b,underrelaxE);
    e(2:n-1) = max(e(2:n-1), 1.e-12);

    % ---------------------------------------------------------------------
    % f-equation 
    
    % Implicit matrix
    A = ddymddy2(ones(n,1),mesh);
    A = bsxfun(@times, Lt(2:n-1).^2, A);
    A(logical(eye(size(A)))) = diag(A) - 1;
    
     % Right hand side
    vok = v2(2:n-1)./k(2:n-1);
    rhsf = ((C1-6)*vok - 2/3*(C1-1))./Tt(2:n-1) - C2*Pk./(r(2:n-1).*k(2:n-1));
    
    % Solve
    f = solveEq(f,A,rhsf,1);
    f(2:n-1) = max(f(2:n-1), 1.e-12);

    % ---------------------------------------------------------------------
    % v2-equation 
    mueff = mu + mut;
    
    %*****************************************
    % extra source term for the modified models
    Source = zeros(n,1);
    if      (compFlag==1) % Otero et.Al
        term1 = 0.5./r .*mueff .*drdy .* dv2dy;
        Di = mueff.*v2.*drdy./sqrt_r;
        [dDidy] = calcGrad(Di,mesh);
        term2 = dDidy./sqrt_r;
        
        Source = term1 + term2;
    elseif  (compFlag==2) % Catris/Aupoix
        Di = mueff.*v2.*drdy./r;
        [dDidy] = calcGrad(Di,mesh);
        
        Source = dDidy;
    end
    
    % diffusion matrix: mueff*d2()/dy2 + dmueff/dy d()/dy
    A =   bsxfun(@times, mueff, mesh.d2dy2) ... 
        + bsxfun(@times, (mesh.ddy*mueff), mesh.ddy);

    % implicitly treated source term
    for i=2:n-1
        A(i,i) = A(i,i) - 6.0*r(i)*e(i)/k(i);
    end
    
    % Right hand side
    b = - r(2:n-1).*k(2:n-1).*f(2:n-1) - Source(2:n-1); 
    
    % Solve
    v2 = solveEq(v2,A,b,underrelaxV2);
    v2(2:n-1) = max(v2(2:n-1), 1.e-12);

    
end








