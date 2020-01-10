%**************************************************************************
%       function, solving the energy (temperature in this case) equation
%**************************************************************************
%
% Energy equation:
%    T-eq:  0 = QTe + ddy[(lambda+Cp mut/Prt) dTdy]
%
% Cp     (heat capacity at constant pressure) is assumed as 1
% lambda (thermal conductivity) is assumed as constant with value at the
% wall.
%
% Input:
%   T       temperature, from previous time step
%   ReT     friction Reynolds number ReT=utau r_wall h/ mu_wall
%   mu      molecular viscosity
%   mut     eddy viscosity or turbulent viscosity
%   Qt   	volumetric heat source
%   mesh    mesh structure
%   turbPrT flag to solve the model for varying turbulent Prandlt 
%
% Output:
%   T       solved temperature 
%


function [T,Prt] = solveTemp(T,ReT,mu,mut,Prt,Qt,mesh,turbPrT)

    n = size(T,1);
    
    % Prandlt number (molecular and turbulent)
    Pr  = 1.0;
    % turbulent Prandtl number based on XYZ
    if strcmp(turbPrT,'calcPrT')
        C = 3.0; 
        PeT = mut./mu.*Pr;
        gam = 1.0./(Prt + 0.1*Pr.^0.83);
        A = sqrt(2*(1./Prt-gam));
        Prt = 1./(gam + C*PeT.*A - ((C*PeT).^2).*(1-exp(-A./(C*PeT))));
    elseif strcmp(turbPrT,'zhangPrT')
            Prt   = 
    else
        Prt = ones(n,1)*1.0; 
    end

  
    
end