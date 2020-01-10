function [ lam, alphat ] = PRT( mu,mut,alpha,T,r,qy,ReT,Pr,Pl,MESH,RadMod)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    % model constants
    C1 = 0.5882; 
    C2 = 0.228;
    C3 = 0.0441;
    C4 = 5.165;
    
    gam = mut./mu;
    
    Prt0 = 1./(C1 + C2.*gam - C3.*gam.^2.*(1-exp(-C4./gam)));
    
    
    if RadMod == 1 && max(mut)<0.008
        Prt = 1./ReT.*abs(MESH.ddy*T)./abs(qy).*(Prt0+mut*ReT);
    else
        Prt = Prt0;
    end
    alphat = mut./Prt;
    
    lam    = alpha + alphat;
    
    
end

