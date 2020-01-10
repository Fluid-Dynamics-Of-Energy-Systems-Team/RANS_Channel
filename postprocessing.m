%%  POSTPROCESSING


clear all
close all
clc

addpath('postprocessing');                % functions for postprocessing
addpath('results');                       % folder with results

% ------------- load variables

load('b.mat');
load('br.mat');
load('t01.mat');
load('t1.mat');
load('t5.mat');
load('t10.mat');
load('t20.mat');
load('t01r.mat');
load('t1r.mat');
load('t10r.mat');
load('H2O.mat');
load('CO2.mat');
load('H2OP.mat');

% --------------- start calculating differences

b.diff    = calcNus(b);
br.diff   = calcNus(br);
t01.diff  = calcNus(t01);
t1.diff   = calcNus(t1);
t5.diff   = calcNus(t5);
t10.diff  = calcNus(t10);
t20.diff  = calcNus(t20);
t01r.diff = calcNus(t01r);
t1r.diff  = calcNus(t1r);
t10r.diff = calcNus(t10r);
H2O.diff  = calcNus(H2O);
CO2.diff  = calcNus(CO2);
H2OP.diff = calcNus(H2OP);

b.diff2    = calcNus2(b);
br.diff2   = calcNus2(br);
t01.diff2  = calcNus2(t01);
t1.diff2   = calcNus2(t1);
t5.diff2   = calcNus2(t5);
t10.diff2  = calcNus2(t10);
t20.diff2  = calcNus2(t20);
t01r.diff2 = calcNus2(t01r);
t1r.diff2  = calcNus2(t1r);
t10r.diff2 = calcNus2(t10r);
H2O.diff2  = calcNus2(H2O);
CO2.diff2  = calcNus2(CO2);
H2OP.diff2 = calcNus2(H2OP);
% ---------------- draw bar plots
pathfig = '../../pres_apsdfd/Figures/';

% namefile  = 'grey';
% title{1} = 'G1';
% title{2} = 'G5';
% title{3} = 'G20';
% fig2 = plot_bar(t1.diff.A,t5.diff.A,t20.diff.A,t1.diff2 ,t5.diff2 ,t20.diff2,'NU',title,namefile);
% % 
% title{1} = 'R01';
% title{2} = 'R1';
% title{3} = 'R10';
% namefile  = 'var';
% fig4 = plot_bar(t01r.diff.A,t1r.diff.A,t10r.diff.A,t01r.diff2 ,t1r.diff2 ,t10r.diff2,'NU',title,namefile);
% % 
% title{1} = 'H';
% title{2} = 'C';
% title{3} = 'P';
% namefile  = 'spec';
% fig6 = plot_bar(H2O.diff.A,CO2.diff.A,H2OP.diff.A,H2O.diff2,CO2.diff2,H2OP.diff2,'NU',title,namefile);
% print(fig2,strcat(pathfig,'greyB.eps'),'-depsc')
% print(fig4,strcat(pathfig,'varB.eps'),'-depsc')
% print(fig6,strcat(pathfig,'specB.eps'),'-depsc')


title{1} = 'G1,$\ \ \ \tau=1$';
title{2} = 'G5,$\ \ \ \tau=5$';
title{3} = 'G20,$\ \ \ \tau=20$';
[fig13, fig11, fig12] = plotcase3(t1,t5,t20,title);
% title{1} = 'R01,$\ \ \ \tau=0.1$';
% title{2} = 'R1,$\ \ \ \tau=1$';
% title{3} = 'R10,$\ \ \ \tau=10$';
% [fig33, fig31, fig32] = plotcase3(t01r,t1r,t10r,title);
% title{1} = 'H,$\ \ \ \tau=8.03$';
% title{2} = 'C,$\ \ \ \tau=2.99$';
% title{3} = 'P,$\ \ \ \tau=2.79$';
% [fig54, fig51, fig52, fig53]  = plotcase4(H2O,CO2,H2OP,title);


print(fig11,strcat(pathfig,'greyT1.eps'),'-depsc')
print(fig12,strcat(pathfig,'greyT2.eps'),'-depsc')
print(fig13,strcat(pathfig,'greyT3.eps'),'-depsc')
% print(fig31,strcat(pathfig,'varT1.eps'),'-depsc')
% print(fig32,strcat(pathfig,'varT2.eps'),'-depsc')
% print(fig33,strcat(pathfig,'varT3.eps'),'-depsc')
% print(fig51,strcat(pathfig,'specT1.eps'),'-depsc')
% print(fig52,strcat(pathfig,'specT2.eps'),'-depsc')
% print(fig53,strcat(pathfig,'specT3.eps'),'-depsc')
% print(fig54,strcat(pathfig,'specT4.eps'),'-depsc')
% 
% 





