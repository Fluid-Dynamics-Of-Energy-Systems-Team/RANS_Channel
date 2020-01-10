
%% Plotting figures from solutions

close all
clear all

%% IMPORT DATA

path = 'Figures_V2T/';
TickLength = [0.02 0.05];

t01_VDR = importdata('V2F-V2T/t01_rad');
t01_VDP = importdata('V2F-V2T/t01_rad_P');
t01_VDN = importdata('V2F-V2T/t01');
t01_DNS = importdata('DNS/t01m');
f01_DNS = importdata('DNS/t01f');
c01_DNS = importdata('DNS/t01c');

t1_VDR = importdata('V2F-V2T/t1_rad');
t1_VDP = importdata('V2F-V2T/t1_rad_P');
t1_VDN = importdata('V2F-V2T/t1');
t1_DNS = importdata('DNS/t1m');
f1_DNS = importdata('DNS/t1f');
c1_DNS = importdata('DNS/t1c');

t5_VDR = importdata('V2F-V2T/t5_rad');
t5_VDP = importdata('V2F-V2T/t5_rad_P');
t5_VDN = importdata('V2F-V2T/t5');
t5_DNS = importdata('DNS/t5m');
f5_DNS = importdata('DNS/t5f');
c5_DNS = importdata('DNS/t5c');

t10_VDR = importdata('V2F-V2T/t10_rad');
t10_VDP = importdata('V2F-V2T/t10_rad_P');
t10_VDN = importdata('V2F-V2T/t10');
t10_DNS = importdata('DNS/t10m');
f10_DNS = importdata('DNS/t10f');
c10_DNS = importdata('DNS/t10c');

t20_VDR = importdata('V2F-V2T/t20_rad');
t20_VDP = importdata('V2F-V2T/t20_rad_P');
t20_VDN = importdata('V2F-V2T/t20');
t20_DNS = importdata('DNS/t20m');
f20_DNS = importdata('DNS/t20f');
c20_DNS = importdata('DNS/t20c');

y = t01_VDN(:,1);
yd = t01_DNS(1:2:end,1);

%% PLOTTING ONE FIGURE tau = 0.1

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.08],[0.15 0.1],[0.07 0.07]);

axes(ha1(1))
pos1 = get(gca,'Position');
plot(yd,t01_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,t01_VDN(:,3),'k--');
plot(y,t01_VDR(:,3),'b-');
plot(y,t01_VDP(:,3),'-','Color',[0.5 0.5 0.5]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{\theta}$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
str1 = 'DNS';
str4 = 'V2F-UT';
str5 = 'V2F-UTR';
legend({str1,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,f01_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,t01_VDN(:,9),'k--');
plot(y,t01_VDR(:,9),'b-');
plot(y,t01_VDP(:,9),'-','Color',[0.5 0.5 0.5]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{v^\prime \theta^\prime}$$');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
str1 = 'DNS';
str4 = 'V2F-UT';
str5 = 'V2F-UTR';
legend({str1,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'tau01.eps'),'-depsc')


%% PLOTTING ONE FIGURE tau = 1.0

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.08],[0.15 0.1],[0.07 0.07]);

axes(ha1(1))
pos1 = get(gca,'Position');
plot(yd,t1_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,t1_VDN(:,3),'k--');
plot(t1_VDR(:,1),t1_VDR(:,3),'b-');
plot(y,t1_VDP(:,3),'-','Color',[0.5 0.5 0.5]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{\theta}$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
str1 = 'DNS';
str4 = 'V2F-UT';
str5 = 'V2F-UTR';
legend({str1,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,f1_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,t1_VDN(:,9),'k--');
plot(t1_VDR(:,1),t1_VDR(:,9),'b-');
plot(y,t1_VDP(:,9),'-','Color',[0.5 0.5 0.5]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{v^\prime \theta^\prime}$$');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
str1 = 'DNS';
str4 = 'V2F-UT';
str5 = 'V2F-UTR';
legend({str1,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'tau1.eps'),'-depsc')


%% PLOTTING ONE FIGURE tau = 5.0

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.08],[0.15 0.1],[0.07 0.07]);

axes(ha1(1))
pos1 = get(gca,'Position');
plot(yd,t5_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,t5_VDN(:,3),'k--');
plot(y,t5_VDR(:,3),'b-');
plot(y,t5_VDP(:,3),'-','Color',[0.5 0.5 0.5]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{\theta}$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
str1 = 'DNS';
str4 = 'V2F-UT';
str5 = 'V2F-UTR';
legend({str1,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

yl = max(t5_VDN(:,9))*1.05;

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,f5_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,t5_VDN(:,9),'k--');
plot(y,t5_VDR(:,9),'b-');
plot(y,t5_VDP(:,9),'-','Color',[0.5 0.5 0.5]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{v^\prime \theta^\prime}$$');
axis([0 2 0 yl]);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
str1 = 'DNS';
str4 = 'V2F-UT';
str5 = 'V2F-UTR';
legend({str1,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'tau5.eps'),'-depsc')

%% PLOTTING ONE FIGURE tau = 10.0

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.08],[0.15 0.1],[0.07 0.07]);

axes(ha1(1))
pos1 = get(gca,'Position');
plot(yd,t10_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,t10_VDN(:,3),'k--');
plot(y,t10_VDR(:,3),'b-');
plot(y,t10_VDP(:,3),'-','Color',[0.5 0.5 0.5]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{\theta}$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
str1 = 'DNS';
str4 = 'V2F-UT';
str5 = 'V2F-UTR';
legend({str1,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

yl = max(t10_VDN(:,9))*1.05;

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,f10_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,t10_VDN(:,9),'k--');
plot(y,t10_VDR(:,9),'b-');
plot(y,t10_VDP(:,9),'-','Color',[0.5 0.5 0.5]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{v^\prime \theta^\prime}$$');
axis([0 2 0 yl]);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
str1 = 'DNS';
str4 = 'V2F-UT';
str5 = 'V2F-UTR';
legend({str1,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'tau10.eps'),'-depsc')

%% PLOTTING ONE FIGURE tau = 20.0

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.08],[0.15 0.1],[0.07 0.07]);

axes(ha1(1))
pos1 = get(gca,'Position');
plot(yd,t20_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,t20_VDN(:,3),'k--');
plot(y,t20_VDR(:,3),'b-');
plot(y,t20_VDP(:,3),'-','Color',[0.5 0.5 0.5]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{\theta}$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
str1 = 'DNS';
str4 = 'V2F-UT';
str5 = 'V2F-UTR';
legend({str1,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

yl = max(t20_VDN(:,9))*1.05;

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,f20_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,t20_VDN(:,9),'k--');
plot(y,t20_VDR(:,9),'b-');
plot(y,t20_VDP(:,9),'-','Color',[0.5 0.5 0.5]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{v^\prime \theta^\prime}$$');
axis([0 2 0 yl]);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
str1 = 'DNS';
str4 = 'V2F-UT';
str5 = 'V2F-UTR';
legend({str1,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'tau20.eps'),'-depsc')
