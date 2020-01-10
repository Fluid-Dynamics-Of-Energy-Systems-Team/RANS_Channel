function [optim] = wrap(CV)
% % RANS(radCase,turbulence,flux,varDens,kPMod,RadMod,Pr,compMod,solveRad);

    sol = RANS('t01r',1,1,1,1,1,1,1,2,CV(1),2.0,CV(2)); % DO AGAIN!!
%    sol = RANS('br',1,1,1,0,0,1,1,0,CV(1),2.0,CV(2));
    
    optim = norm(sol.T - sol.Tdns) + norm(sol.at-sol.atdns) + norm(sol.THF-sol.THFdns); 
    
    close all
end

