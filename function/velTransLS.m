%**************************************************************************
%       function, transform dimensional u to wall units uplus
%**************************************************************************
%   uplus = u/utau;   utau= sqrt(tau_wall/rho_wall)
%
% Inputs:
%   u       velocity, dimensional
%   r       density
%   mu      molecular viscosity
%   mesh    mesh structure
%
% Output:
%   uplus   velocity with transformation using wall values (utau)
%   utau    friction velocity
%
function [upls,utau] = velTransLS(u,r,mu,mesh)

    dudy  = mesh.ddy*u;
    utau = sqrt(mu(1)*dudy(1)/r(1));
    upls = u/utau;
end


