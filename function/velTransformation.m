%**************************************************************************
%       function, transform dimensional u to scaling forms: local scaled,
%       van Driest and semi-locally scaled
%**************************************************************************
% Inputs:
%   u       velocity, dimensional
%   r       density
%   mu      molecular viscosity
%   mesh    mesh structure
%
% Output:
%   ustar   velocity with the extended van Driest transformation
%   uvd     velocity with van Driest transformation
%   uplus   velocity with transformation using wall values (utau)
%   ystar   non-dimensional wall distance using semi-local scaling
%   yplus   non-dimensional wall distance using local scaling
%   utau    friction velocity
%
function [ustar,ystar,uplus,yplus,uvd,utau] = velTransformation(u,r,mu,mesh)

    %% Velocity transformations
    
    % Local scaling transformation
    [uplus,utau]  = velTransLS(u,r,mu,mesh);
    
    % van Driest transformation
    [uvd] = velTransVD(uplus,r);
    
    
    Rets = sqrt(r)./mu;
    
    % Extended van Driest transformation 
    [ustar] = velTransSLS(uvd,Rets,mesh);

    % Wall distance transformations
    
    ReT  = Rets(1);
    yplus   = mesh.y*ReT;
    ystar  = mesh.y.*Rets;

    
end