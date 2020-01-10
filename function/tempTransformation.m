%**************************************************************************
%       function, transform dimensional T to scaling forms: local scaled,
%       van Driest and semi-locally scaled
%**************************************************************************
% Inputs:
%   T       temperature, dimensional
%   Tw      wall temperature
%   r       density
%   mu      molecular viscosity
%   lambda  thermal conductivity
%   utau    friction velocity
%   mesh    mesh structure
%
% Output:
%   Tstar   temperature with the extended van Driest transformation
%   Tvd     temperature with van Driest transformation
%   Tplus   temperature with transformation using wall values (Ttau)
%
function [Tstar,Tplus,Tvd] = tempTransformation(T,Tw,r,mu,lambda,utau,mesh)

    %% Temperature transformations
    
    % Local scaling transformation
%     [Tplus,Ttau, qw] = tempTransLS(T,Tw,r,lambda,utau,mesh);
    
    dTdy  = mesh.ddy*T;

    qw   = lambda(1)*dTdy(1);
    Ttau = qw/(r(1)*1.0*utau);      % Note, Cp=1
    
%     if (Ttau ~= 0.0)  
        Tplus = (T-Tw)/Ttau;
%     else
%         Tplus = 0.0*r;
%     end
    
    
    % van Driest transformation (same as velocity)
%     [Tvd]    = velTransVD(Tplus,r);
    
    n = size(Tplus,1);
    Tvd = zeros(n,1);
    Tvd(1) = 0.0;
    
    for i=2:n
        Tvd(i) = Tvd(i-1) + sqrt(0.5*(r(i)+r(i-1))/r(1))*(Tplus(i)-Tplus(i-1));
    end
    
    % Extended van Driest transformation (same as velocity)
    ReTst = sqrt(r)./mu;
    [Tstar]  = velTransSLS(Tvd,ReTst,mesh);  
        Tplus = Tplus/mu(1);

end



