
%% Plotting figures from solutions

close all
clear all

%% IMPORT DATA

path = 'Figures_r/';
TickLength = [0.02 0.05];

b_VDN = importdata('V2F-DWX/br');
b_VN  = importdata('V2F-NO/br');
b_SN  = importdata('SA-NO/br');
b_DNS = importdata('DNS/brm');
f_DNS = importdata('DNS/brf');
c_DNS = importdata('DNS/brc');

t01_VDR = importdata('V2F-DWX/t01r_rad');
t01_VDN = importdata('V2F-DWX/t01r');
t01_VN  = importdata('V2F-NO/t01r');
t01_SN  = importdata('SA-NO/t01r');
t01_DNS = importdata('DNS/t01rm');
f01_DNS = importdata('DNS/t01rf');
c01_DNS = importdata('DNS/t01rc');

t1_VDR = importdata('V2F-DWX/t1r_rad');
t1_VDN = importdata('V2F-DWX/t1r');
t1_VN  = importdata('V2F-NO/t1r');
t1_SN  = importdata('SA-NO/t1r');
t1_DNS = importdata('DNS/t1rm');
f1_DNS = importdata('DNS/t1rf');
c1_DNS = importdata('DNS/t1rc');

t10_VDR = importdata('V2F-DWX/t10r_rad');
t10_VDN = importdata('V2F-DWX/t10r');
t10_VN  = importdata('V2F-NO/t10r');
t10_SN  = importdata('SA-NO/t10r');
t10_DNS = importdata('DNS/t10rm');
f10_DNS = importdata('DNS/t10rf');
c10_DNS = importdata('DNS/t10rc');

H2O_VDR = importdata('V2F-DWX/H2O_rad');
H2O_VDRP= importdata('V2F-DWX/H2O_rad_kP');
H2O_VDRG= importdata('V2F-DWX/H2O_rad_kG');
H2O_VDN = importdata('V2F-DWX/H2O');
H2O_VN  = importdata('V2F-NO/H2O');
H2O_SN  = importdata('SA-NO/H2O');
H2Om_DNS = importdata('DNS/H2Om');
H2Of_DNS = importdata('DNS/H2Of');
H2Oc_DNS = importdata('DNS/H2Oc');

y = t01_SN(:,1);
yd = t01_DNS(1:2:end,1);

%% PLOTTING ONE FIGURE Temperature

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.015],[0.15 0.1],[0.07 0.07]);

axes(ha1(1))
pos1 = get(gca,'Position');
plot(yd,b_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,b_SN(:,3),'k:');
plot(y,b_VN(:,3),'k-.');
plot(y,b_VDN(:,3),'k--');
set(gca,'FontSize',14);
xlabel('');
set(gca,'XTickLabel','');
ylabel('$$T$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,0.9,'$$\tau=0.0$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
legend({str1,str2,str3,str4},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,t01_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,t01_SN(:,3),'k:');
plot(y,t01_VN(:,3),'k-.');
plot(y,t01_VDN(:,3),'k--');
plot(y,t01_VDR(:,3),'b-');
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('');
set(gca,'YTickLabel','')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,0.9,'$$\tau=0.1$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
str5 = 'V2F-DWR';
legend({str1,str2,str3,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'Tempvar_b_01.eps'),'-depsc')

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.015],[0.15 0.1],[0.07 0.07]);

axes(ha1(1))
pos1 = get(gca,'Position');
plot(yd,t1_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,t1_SN(:,3),'k:');
plot(y,t1_VN(:,3),'k-.');
plot(y,t1_VDN(:,3),'k--');
plot(y,t1_VDR(:,3),'b-');
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$T$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,0.9,'$$\tau=1$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
str5 = 'V2F-DWR';
legend({str1,str2,str3,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,t10_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,t10_SN(:,3),'k:');
plot(y,t10_VN(:,3),'k-.');
plot(y,t10_VDN(:,3),'k--');
plot(y,t10_VDR(:,3),'b-');
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('');
set(gca,'YTickLabel','')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,0.9,'$$\tau=10$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
str5 = 'V2F-DWR';
legend({str1,str2,str3,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'Tempvar_1_10.eps'),'-depsc')


fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.015],[0.15 0.1],[0.07 0.07]);

axes(ha1(1))
pos1 = get(gca,'Position');
plot(H2Om_DNS(1:2:end,1),H2Om_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,H2O_SN(:,3),'k:');
plot(y,H2O_VN(:,3),'k-.');
plot(y,H2O_VDN(:,3),'k--');
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$T$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,0.9,'$$\tau=8.023$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
legend({str1,str2,str3,str4},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

yl  = max(H2Of_DNS(:,2))*1.1;

axes(ha1(2))
plot(H2Om_DNS(1:2:end,1),H2Om_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,H2O_VDRP(:,3),'g-');
plot(y,H2O_VDRG(:,3),'r-');
plot(y,H2O_VDR(:,3),'b-');
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('');
set(gca,'YTickLabel','');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,0.9,'$$\tau=8.023$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = '$$\kappa_c = \kappa_P$$';
str3 = '$$\kappa_c = \kappa_G$$';
str4 = '$$\kappa_c = 0.5(\kappa_P+\kappa_G)$$';
legend({str1,str2,str3,str4},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'Tempvar_H2O.eps'),'-depsc')

%% PLOTTING ONE FIGURE flux

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.015],[0.15 0.1],[0.07 0.07]);

yl  = max(f01_DNS(:,2))*1.1;

axes(ha1(1))
pos1 = get(gca,'Position');
plot(yd,f_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,b_SN(:,9),'k:');
plot(y,b_VN(:,9),'k-.');
plot(y,b_VDN(:,9),'k--');
axis([0 2 0 yl]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{v^\prime T^\prime }$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,(yl + max(f_DNS(:,2)))*0.5,'$$\tau=0.0$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
legend({str1,str2,str3,str4},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,f01_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,t01_SN(:,9),'k:');
plot(y,t01_VN(:,9),'k-.');
plot(y,t01_VDN(:,9),'k--');
plot(y,t01_VDR(:,9),'b-');
axis([0 2 0 yl]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('');
set(gca,'YTickLabel','')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,(yl + max(f_DNS(:,2)))*0.5,'$$\tau=0.1$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
str5 = 'V2F-DWR';
legend({str1,str2,str3,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'Fluxvar_b_01.eps'),'-depsc')

%%

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.015],[0.15 0.1],[0.07 0.07]);

yl  = max(t10_VDN(:,9))*1.01;

axes(ha1(1))
pos1 = get(gca,'Position');
plot(yd,f1_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,t1_SN(:,9),'k:');
plot(y,t1_VN(:,9),'k-.');
plot(y,t1_VDN(:,9),'k--');
plot(y,t1_VDR(:,9),'b-');
axis([0 2 0 yl]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{v^\prime T^\prime }$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,2.5e-04,'$$\tau=1$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
legend({str1,str2,str3,str4},'Interpreter','latex','FontSize',12,'location','northwest');
legend boxoff

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,f10_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,t10_SN(:,9),'k:');
plot(y,t10_VN(:,9),'k-.');
plot(y,t10_VDN(:,9),'k--');
plot(y,t10_VDR(:,9),'b-');
axis([0 2 0 yl]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('');
set(gca,'YTickLabel','')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,2.5e-04,'$$\tau=10$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
str5 = 'V2F-DWR';
legend({str1,str2,str3,str4,str5},'Interpreter','latex','FontSize',12,'location','northwest');
legend boxoff

print(fig,strcat(path,'Fluxvar_1_10.eps'),'-depsc')

%%

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.015],[0.15 0.1],[0.07 0.07]);

yl  = max(H2O_VDN(:,9))*1.05;

axes(ha1(1))
pos1 = get(gca,'Position');
plot(H2Of_DNS(1:2:end,1),H2Of_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,H2O_SN(:,9),'k:');
plot(y,H2O_VN(:,9),'k-.');
plot(y,H2O_VDN(:,9),'k--');
axis([0 2 0 yl]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{v^\prime T^\prime }$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,yl*0.92,'$$\tau=8.023$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
legend({str1,str2,str3,str4},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

axes(ha1(2))
pos1 = get(gca,'Position');
plot(H2Of_DNS(1:2:end,1),H2Of_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,H2O_VDRP(:,9),'r-');
plot(y,H2O_VDRG(:,9),'g-');
plot(y,H2O_VDR(:,9),'b-');
axis([0 2 0 yl]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('');
set(gca,'YTickLabel','')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,yl*0.92,'$$\tau=8.023$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = '$$\kappa_c = \kappa_P$$';
str3 = '$$\kappa_c = \kappa_G$$';
str4 = '$$\kappa_c = 0.5(\kappa_P+\kappa_G)$$';
legend({str1,str2,str3,str4},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'Fluxvar_H2O.eps'),'-depsc')


