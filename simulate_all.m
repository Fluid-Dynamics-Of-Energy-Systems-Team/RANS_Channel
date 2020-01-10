%start with all the simulations
clear all
close all
clc

addpath('postprocessing');                % functions for postprocessing

tot.SA.T=0; tot.V2F.NO.T=0; tot.V2F.DWX.T=0; tot.V2F.RAD.T=0;
tot.SA.A=0; tot.V2F.NO.A=0; tot.V2F.DWX.A=0; tot.V2F.RAD.A=0;
tot.SA.F=0; tot.V2F.NO.F=0; tot.V2F.DWX.F=0; tot.V2F.RAD.F=0;

%% BENCHMARKS

Par1 = 2.34;
Par2 = 1.5;
Par3 = 0.1;
% 
% 
% b.SA      = RANS('b',0,0,0,0,0,1,0,0,Par1,Par2,Par3,'P');
% close all
% b.V2F.NO  = RANS('b',1,0,0,0,0,1,0,0,Par1,Par2,Par3,'P');
% close all
% b.V2F.DWX = RANS('b',1,1,0,0,0,1,0,0,Par1,Par2,Par3,'P');
% close all
% b.V2F.RAD = b.V2F.DWX;
% b.V2F.RAD = b.V2F.DWX;
% 
% br.SA      = RANS('br',0,0,1,0,0,1,1,0,Par1,Par2,Par3,'P');
% close all
% br.V2F.NO  = RANS('br',1,0,1,0,0,1,1,0,Par1,Par2,Par3,'P');
% close all
% br.V2F.DWX = RANS('br',1,1,1,0,0,1,1,0,Par1,Par2,Par3,'P');
% close all
% br.V2F.RAD = br.V2F.DWX;
% br.V2F.RAD = br.V2F.DWX;
% 
% [b  ,tot] =  calcdiff(b  ,tot);
% [br ,tot] =  calcdiff(br ,tot);
% 
% 
% %% GREY simulations 
% % 
% % % RANS(radCase,turbulence,flux,varDens,kPMod,RadMod,Pr,compMod,solveRad);
% % 
% t01.SA      = RANS('t01',0,0,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t01.V2F.NO  = RANS('t01',1,0,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t01.V2F.DWX = RANS('t01',1,1,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t01.V2F.RAD = RANS('t01',1,1,0,0,1,1,0,2,Par1,Par2,Par3,'P');
% close all
% 
% t1.SA      = RANS('t1',0,0,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t1.V2F.NO  = RANS('t1',1,0,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t1.V2F.DWX = RANS('t1',1,1,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t1.V2F.RAD = RANS('t1',1,1,0,0,1,1,0,2,Par1,Par2,Par3,'P');
% close all
% 
% t5.SA      = RANS('t5',0,0,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t5.V2F.NO  = RANS('t5',1,0,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t5.V2F.DWX = RANS('t5',1,1,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t5.V2F.RAD = RANS('t5',1,1,0,0,1,1,0,2,Par1,Par2,Par3,'P');
% close all
% 
% t10.SA      = RANS('t10',0,0,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t10.V2F.NO  = RANS('t10',1,0,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t10.V2F.DWX = RANS('t10',1,1,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t10.V2F.RAD = RANS('t10',1,1,0,0,1,1,0,2,Par1,Par2,Par3,'P');
% close all
% 
% t20.SA      = RANS('t20',0,0,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t20.V2F.NO  = RANS('t20',1,0,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t20.V2F.DWX = RANS('t20',1,1,0,0,0,1,0,2,Par1,Par2,Par3,'P');
% close all
% t20.V2F.RAD = RANS('t20',1,1,0,0,1,1,0,2,Par1,Par2,Par3,'P');
% close all
% 
% [t01 ,tot] =  calcdiff(t01 ,tot);
% [t1  ,tot] =  calcdiff(t1  ,tot);
% [t5  ,tot] =  calcdiff(t5 ,tot);
% [t10 ,tot] =  calcdiff(t10 ,tot);
% [t20 ,tot] =  calcdiff(t20 ,tot);
% 
% %% GREY VARIABLE kappa
% 
% % RANS(radCase,turbulence,flux,varDens,kPMod,RadMod,Pr,compMod,solveRad);
% 
% t01r.SA      = RANS('t01r',0,0,1,1,0,1,1,2,Par1,Par2,Par3,'P');
% close all
% t01r.V2F.NO  = RANS('t01r',1,0,1,1,0,1,1,2,Par1,Par2,Par3,'P');
% close all
% t01r.V2F.DWX = RANS('t01r',1,1,1,1,0,1,1,2,Par1,Par2,Par3,'P');
% close all
% t01r.V2F.RAD = RANS('t01r',1,1,1,1,1,1,1,2,Par1,Par2,Par3,'P');
% close all
% 
% t1r.SA      = RANS('t1r',0,0,1,1,0,1,1,2,Par1,Par2,Par3,'P');
% close all
% t1r.V2F.NO  = RANS('t1r',1,0,1,1,0,1,1,2,Par1,Par2,Par3,'P');
% close all
% t1r.V2F.DWX = RANS('t1r',1,1,1,1,0,1,1,2,Par1,Par2,Par3,'P');
% close all
% t1r.V2F.RAD = RANS('t1r',1,1,1,1,1,1,1,2,Par1,Par2,Par3,'P');
% close all
% 
% t10r.SA      = RANS('t10r',0,0,1,1,0,1,1,2,Par1,Par2,Par3,'P');
% close all
% t10r.V2F.NO  = RANS('t10r',1,0,1,1,0,1,1,2,Par1,Par2,Par3,'P');
% close all
% t10r.V2F.DWX = RANS('t10r',1,1,1,1,0,1,1,2,Par1,Par2,Par3,'P');
% close all
% t10r.V2F.RAD = RANS('t10r',1,1,1,1,1,1,1,2,Par1,Par2,Par3,'P'); % DO AGAIN!!
% close all
% 
% [t01r,tot] =  calcdiff(t01r,tot);
% [t1r ,tot] =  calcdiff(t1r ,tot);
% [t10r,tot] =  calcdiff(t10r,tot);

%% NON-GREY simulations
% 
H2O.SA      = RANS('H2O',0,0,1,2,0,1,1,2,Par1,Par2,Par3,'P');
close all
H2O.V2F.NO  = RANS('H2O',1,0,1,2,0,1,1,2,Par1,Par2,Par3,'P');
close all
H2O.V2F.DWX = RANS('H2O',1,1,1,2,0,1,1,2,Par1,Par2,Par3,'P');
close all
H2O.V2F.RAD = RANS('H2O',1,1,1,2,1,1,1,2,Par1,Par2,Par3,'G');
close all
H2O.V2F.RAD.P = RANS('H2O',1,1,1,2,1,1,1,2,Par1,Par2,Par3,'P');
close all

% 
CO2.SA      = RANS('CO2',0,0,1,2,0,1,1,2,Par1,Par2,Par3,'P');
close all
CO2.V2F.NO  = RANS('CO2',1,0,1,2,0,1,1,2,Par1,Par2,Par3,'P');
close all
CO2.V2F.DWX = RANS('CO2',1,1,1,2,0,1,1,2,Par1,Par2,Par3,'P');
close all
CO2.V2F.RAD = RANS('CO2',1,1,1,2,1,1,1,2,Par1,Par2,Par3,'G');
close all
CO2.V2F.RAD.P = RANS('CO2',1,1,1,2,1,1,1,2,Par1,Par2,Par3,'P');
close all

H2OP.SA      = RANS('H2OP',0,0,1,2,0,1,1,2,Par1,Par2,Par3,'P');
close all
H2OP.V2F.NO  = RANS('H2OP',1,0,1,2,0,1,1,2,Par1,Par2,Par3,'P');
close all
H2OP.V2F.DWX = RANS('H2OP',1,1,1,2,0,1,1,2,Par1,Par2,Par3,'P');
close all
H2OP.V2F.RAD = RANS('H2OP',1,1,1,2,1,1,1,2,Par1,Par2,Par3,'G');
close all
H2OP.V2F.RAD.P = RANS('H2OP',1,1,1,2,1,1,1,2,Par1,Par2,Par3,'P');
close all

[H2O ,tot] =  calcdiff(H2O ,tot);
[CO2 ,tot] =  calcdiff(CO2 ,tot);
[H2OP,tot] =  calcdiff(H2OP,tot);

%% saving variables to files

% save('results/b'   ,'b');
% save('results/br'  ,'br');
% save('results/t01' ,'t01');
% save('results/t1'  ,'t1');
% save('results/t5'  ,'t5');
% save('results/t10' ,'t10');
% save('results/t20' ,'t20');
% save('results/t01r','t01r');
% save('results/t1r' ,'t1r');
% save('results/t10r','t10r');
save('results/H2O' ,'H2O');
save('results/CO2' ,'CO2');
save('results/H2OP','H2OP');
save('results/tot' ,'tot');


