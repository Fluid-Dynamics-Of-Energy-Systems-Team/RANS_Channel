%**************************************************************************
%       function, transform dimensional T to wall units Tplus
%**************************************************************************
%   Tplus = T/Ttau;   Ttau= q_wall/(rho_wall Cp_wall utau)
%
% Inputs:
%   T       temperature, dimensional
%   Tw      wall temperature
%   r       density
%   lambda  thermal conductivity
%   utau    friction velocity
%   mesh    mesh structure
%
% Output:
%   Tplus   temperature with transformation using wall values (Ttau)
%   Ttay    friction temperature 
%   qw      heat flux in the wall
%
function [Tplus,Ttau, qw] = tempTransLS(T,Tw,r,lambda,utau,mesh)

    dTdy  = mesh.ddy*T;

    qw   = lambda(1)*dTdy(2);
    Ttau = qw/(r(1)*1.0*utau);      % Note, Cp=1
    
    if (Ttau ~= 0.0)  
        Tplus = (T-Tw)/Ttau;
    else
        Tplus = 0.0*r;
    end
    
end

