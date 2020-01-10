%start with all the simulations
clear all
close all
clc

addpath('postprocessing');                % functions for postprocessing

tot.SA = 0; tot.V2F.NO=0; tot.V2F.DWX=0; tot.V2F.RAD=0;

%% BENCHMARKS



%% GREY simulations 
% 
% % RANS(radCase,turbulence,flux,varDens,kPMod,RadMod,Pr,compMod,solveRad);
% 
% t01.SA      = RANS('t01',0,0,0,0,0,1,0,2,2.223,1.5,0.11);
% close all
% t01.V2F.NO  = RANS('t01',1,0,0,0,0,1,0,2);
% close all
% t01.V2F.DWX = RANS('t01',1,1,0,0,0,1,0,2);
% close all
% t01.V2F.RAD = RANS('t01',1,1,0,0,1,1,0,2,2.23,1.5,0.11);
% close all
% [S1, S2] = calcRp(2.23,0.11,t01.V2F.RAD);
% 
% t1.SA      = RANS('t1',0,0,0,0,0,1,0,2);
% close all
% t1.V2F.NO  = RANS('t1',1,0,0,0,0,1,0,2);
% close all
% t1.V2F.DWX = RANS('t1',1,1,0,0,0,1,0,2);
% close all
% t1.V2F.RAD = RANS('t1',1,1,0,0,1,1,0,2,2.247,1.5,0.116);
% close all
% [S1, S2] = calcRp(2.247,0.116,t1.V2F.RAD);
%
% t10.SA      = RANS('t10',0,0,0,0,0,1,0,2);
% close all
% t10.V2F.NO  = RANS('t10',1,0,0,0,0,1,0,2);
% close all
% t10.V2F.DWX = RANS('t10',1,1,0,0,0,1,0,2);
% close all
% t10.V2F.RAD = RANS('t10',1,1,0,0,1,1,0,2,2.547,1.5,0.129);
% close all
% [S1, S2] = calcRp(2.547,0.129,t10.V2F.RAD);

% [t01 ,tot] =  calcdiff(t01 ,tot);
% [t1  ,tot] =  calcdiff(t1  ,tot);
% [t10 ,tot] =  calcdiff(t10 ,tot);
% 
% %% GREY VARIABLE kappa
% 
% % RANS(radCase,turbulence,flux,varDens,kPMod,RadMod,Pr,compMod,solveRad);
% 
% t01r.SA      = RANS('t01r',0,0,1,1,0,1,1,2);
% close all
% t01r.V2F.NO  = RANS('t01r',1,0,1,1,0,1,1,2);
% close all
% t01r.V2F.DWX = RANS('t01r',1,1,1,1,0,1,1,2);
%close all
% t01r.V2F.RAD = RANS('t01r',1,1,1,1,1,1,1,2,2.256,1.5,0.106);
% close all
% [S1, S2] = calcRp(2.256,0.106,t01r.V2F.RAD);
% 
% t1r.SA      = RANS('t1r',0,0,1,1,0,1,1,2);
% close all
% t1r.V2F.NO  = RANS('t1r',1,0,1,1,0,1,1,2);
% close all
% t1r.V2F.DWX = RANS('t1r',1,1,1,1,0,1,1,2);
% close all
% t1r.V2F.RAD = RANS('t1r',1,1,1,1,1,1,1,2,1.86,1.5,0.108);
% close all
% [S1, S2] = calcRp(1.86,0.108,t1r.V2F.RAD);
% 
% t10r.SA      = RANS('t10r',0,0,1,1,0,1,1,2);
% close all
% t10r.V2F.NO  = RANS('t10r',1,0,1,1,0,1,1,2);
% close all
% t10r.V2F.DWX = RANS('t10r',1,1,1,1,0,1,1,2);
% close all
% t10r.V2F.RAD = RANS('t10r',1,1,1,1,1,1,1,2,2.836,1.5,0.151); % DO AGAIN!!
% close all
% [S1, S2] = calcRp(2.836,0.151,t10r.V2F.RAD);

% [t01r,tot] =  calcdiff(t01r,tot);
% [t1r ,tot] =  calcdiff(t1r ,tot);
% [t10r,tot] =  calcdiff(t10r,tot);
% 
% %% NON-GREY simulations
% 
% H2O.SA      = RANS('H2O',0,0,1,2,0,1,1,2);
% close all
% H2O.V2F.NO  = RANS('H2O',1,0,1,2,0,1,1,2);
% close all
% H2O.V2F.DWX = RANS('H2O',1,1,1,2,0,1,1,2);
% close all
H2O.V2F.RAD = RANS('H2O',1,1,1,2,1,1,1,2,3,1.5,0.16);
close all
[S1, S2] = calcRp(3,0.16,H2O.V2F.RAD);

% CO2.SA      = RANS('CO2',0,0,1,2,0,1,1,2);
% close all
% CO2.V2F.NO  = RANS('CO2',1,0,1,2,0,1,1,2);
% close all
% CO2.V2F.DWX = RANS('CO2',1,1,1,2,0,1,1,2);
% close all
% CO2.V2F.RAD = RANS('CO2',1,1,1,2,1,1,1,2,2.716,1.5,0.137);
% close all
% [S1, S2] = calcRp(2.716,0.137,CO2.V2F.RAD);
% 
% H2OP.SA      = RANS('H2OP',0,0,1,2,0,1,1,2);
% close all
% H2OP.V2F.NO  = RANS('H2OP',1,0,1,2,0,1,1,2);
% close all
% H2OP.V2F.DWX = RANS('H2OP',1,1,1,2,0,1,1,2);
% close all
% H2OP.V2F.RAD = RANS('H2OP',1,1,1,2,1,1,1,2,1.886,1.5,0.11);
% close all
% [S1, S2] = calcRp(1.886,0.11,H2OP.V2F.RAD);
% 
% [H2O ,tot] =  calcdiff(H2O ,tot);
% [CO2 ,tot] =  calcdiff(CO2 ,tot);
% [H2OP,tot] =  calcdiff(H2OP,tot);
% 
% %% calculating differences
% 
% [fig1g,fig2g] = plotcase(t01 ,t5 ,t20);
% [fig1r,fig2r] = plotcase(t01r,t1r,t10r);
% [fig1s,fig2s] = plotcase(H2O ,CO2,H2OP);


