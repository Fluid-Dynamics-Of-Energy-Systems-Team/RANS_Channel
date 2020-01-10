
%% Plotting figures from solutions

close all
clear all

%% IMPORT DATA

path = 'Figures/';
TickLength = [0.02 0.05];

b_VDN = importdata('V2F-DWX/b');
b_VN  = importdata('V2F-NO/b');
b_SN  = importdata('SA-NO/b');
b_DNS = importdata('DNS/bm');
f_DNS = importdata('DNS/bf');
c_DNS = importdata('DNS/bc');

t01_VDR = importdata('V2F-DWX/t01_rad');
t01_VDN = importdata('V2F-DWX/t01');
t01_VN  = importdata('V2F-NO/t01');
t01_SN  = importdata('SA-NO/t01');
t01_DNS = importdata('DNS/t01m');
f01_DNS = importdata('DNS/t01f');
c01_DNS = importdata('DNS/t01c');

t1_VDR = importdata('V2F-DWX/t1_rad');
t1_VDN = importdata('V2F-DWX/t1');
t1_VN  = importdata('V2F-NO/t1');
t1_SN  = importdata('SA-NO/t1');
t1_DNS = importdata('DNS/t1m');
f1_DNS = importdata('DNS/t1f');
c1_DNS = importdata('DNS/t1c');

t1p_VDR = importdata('V2F-DWX/t107_rad');
t1p_VDN = importdata('V2F-DWX/t107');
t1p_VN  = importdata('V2F-NO/t107');
t1p_SN  = importdata('SA-NO/t107');
t1p_DNS = importdata('../pref_temp_1');

t5_VDR = importdata('V2F-DWX/t5_rad');
t5_VDN = importdata('V2F-DWX/t5');
t5_VN  = importdata('V2F-NO/t5');
t5_SN  = importdata('SA-NO/t5');
t5_DNS = importdata('DNS/t5m');
f5_DNS = importdata('DNS/t5f');
c5_DNS = importdata('DNS/t5c');

t10_VDR = importdata('V2F-DWX/t10_rad');
t10_VDN = importdata('V2F-DWX/t10');
t10_VN  = importdata('V2F-NO/t10');
t10_SN  = importdata('SA-NO/t10');
t10_DNS = importdata('DNS/t10m');
f10_DNS = importdata('DNS/t10f');
c10_DNS = importdata('DNS/t10c');

t10p_VDR = importdata('V2F-DWX/t1007_rad');
t10p_VDN = importdata('V2F-DWX/t1007');
t10p_VN  = importdata('V2F-NO/t1007');
t10p_SN  = importdata('SA-NO/t1007');
t10p_DNS = importdata('../pref_temp_10');

t20_VDR = importdata('V2F-DWX/t20_rad');
t20_VDN = importdata('V2F-DWX/t20');
t20_VN  = importdata('V2F-NO/t20');
t20_SN  = importdata('SA-NO/t20');
t20_DNS = importdata('DNS/t20m');
f20_DNS = importdata('DNS/t20f');
c20_DNS = importdata('DNS/t20c');

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

print(fig,strcat(path,'Tempgrey_b_01.eps'),'-depsc')

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
plot(yd,t5_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,t5_SN(:,3),'k:');
plot(y,t5_VN(:,3),'k-.');
plot(y,t5_VDN(:,3),'k--');
plot(y,t5_VDR(:,3),'b-');
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('');
set(gca,'YTickLabel','')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,0.9,'$$\tau=5$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
str5 = 'V2F-DWR';
legend({str1,str2,str3,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'Tempgrey_1_5.eps'),'-depsc')

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.015],[0.15 0.1],[0.07 0.07]);

axes(ha1(1))
pos1 = get(gca,'Position');
plot(yd,t10_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,t10_SN(:,3),'k:');
plot(y,t10_VN(:,3),'k-.');
plot(y,t10_VDN(:,3),'k--');
plot(y,t10_VDR(:,3),'b-');
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$T$$','Interpreter','latex','FontSize',18);
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

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,t20_DNS(1:2:end,5),'ko','MarkerSize',4);
hold on
plot(y,t20_SN(:,3),'k:');
plot(y,t20_VN(:,3),'k-.');
plot(y,t20_VDN(:,3),'k--');
plot(y,t20_VDR(:,3),'b-');
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('');
set(gca,'YTickLabel','')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,0.9,'$$\tau=20$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
str5 = 'V2F-DWR';
legend({str1,str2,str3,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'Tempgrey_10_20.eps'),'-depsc')

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.015],[0.15 0.1],[0.07 0.07]);

axes(ha1(1))
pos1 = get(gca,'Position');
plot(yd,t1p_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,t1p_SN(:,3),'k:');
plot(y,t1p_VN(:,3),'k-.');
plot(y,t1p_VDN(:,3),'k--');
plot(y,t1p_VDR(:,3),'b-');
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$T$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,0.9,'$$\tau=1, \ Pr = 0.7 $$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
str5 = 'V2F-DWR';
legend({str1,str2,str3,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,t10p_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,t10p_SN(:,3),'k:');
plot(y,t10p_VN(:,3),'k-.');
plot(y,t10p_VDN(:,3),'k--');
plot(y,t10p_VDR(:,3),'b-');
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('');
set(gca,'YTickLabel','')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,0.9,'$$\tau=10, \ Pr = 0.7 $$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
str5 = 'V2F-DWR';
legend({str1,str2,str3,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'Tempgrey_1_10p.eps'),'-depsc')

%% PLOTTING ONE FIGURE Temperature

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

print(fig,strcat(path,'Fluxgrey_b_01.eps'),'-depsc')

%%

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.015],[0.15 0.1],[0.07 0.07]);

yl  = max(t5_VDN(:,9))*1.01;

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
text(1,(yl + max(f_DNS(:,2)))*0.56,'$$\tau=1$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
legend({str1,str2,str3,str4},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,f5_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,t5_SN(:,9),'k:');
plot(y,t5_VN(:,9),'k-.');
plot(y,t5_VDN(:,9),'k--');
plot(y,t5_VDR(:,9),'b-');
axis([0 2 0 yl]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('');
set(gca,'YTickLabel','')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,(yl + max(f_DNS(:,2)))*0.56,'$$\tau=5$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
str5 = 'V2F-DWR';
legend({str1,str2,str3,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'Fluxgrey_1_5.eps'),'-depsc')

%%

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.015],[0.15 0.1],[0.07 0.07]);

yl  = max(t20_VDN(:,9))*1.1;

axes(ha1(1))
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
ylabel('$$\overline{v^\prime T^\prime }$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,(yl + max(f_DNS(:,2)))*0.58,'$$\tau=10$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
legend({str1,str2,str3,str4},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,f20_DNS(1:2:end,2),'ko','MarkerSize',4);
hold on
plot(y,t20_SN(:,9),'k:');
plot(y,t20_VN(:,9),'k-.');
plot(y,t20_VDN(:,9),'k--');
plot(y,t20_VDR(:,9),'b-');
axis([0 2 0 yl]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('');
set(gca,'YTickLabel','')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,(yl + max(f_DNS(:,2)))*0.58,'$$\tau=20$$','Interpreter','latex','FontSize',18,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
str5 = 'V2F-DWR';
legend({str1,str2,str3,str4,str5},'Interpreter','latex','FontSize',12,'location','south');
legend boxoff

print(fig,strcat(path,'Fluxgrey_10_20.eps'),'-depsc')

%%

fig=figure('Position',[0 0 1000 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha1,pos1] = tight_subplot(1,2,[0.03 0.015],[0.15 0.1],[0.07 0.07]);

yl  = max(t10p_VDN(:,9))*1.01;

axes(ha1(1))
pos1 = get(gca,'Position');
plot(yd,t1p_DNS(1:2:end,4),'ko','MarkerSize',4);
hold on
plot(y,t1p_SN(:,9),'k:');
plot(y,t1p_VN(:,9),'k-.');
plot(y,t1p_VDN(:,9),'k--');
plot(y,t1p_VDR(:,9),'b-');
axis([0 2 0 yl]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('$$\overline{v^\prime T^\prime }$$','Interpreter','latex','FontSize',18);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,(yl + max(f_DNS(:,2)))*0.6,'$$\tau=1,\ Pr=0.7$$','Interpreter','latex','FontSize',15,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
legend({str1,str2,str3,str4},'Interpreter','latex','FontSize',10,'location','south');
legend boxoff

axes(ha1(2))
pos1 = get(gca,'Position');
plot(yd,t10p_DNS(1:2:end,4),'ko','MarkerSize',4);
hold on
plot(y,t10p_SN(:,9),'k:');
plot(y,t10p_VN(:,9),'k-.');
plot(y,t10p_VDN(:,9),'k--');
plot(y,t10p_VDR(:,9),'b-');
axis([0 2 0 yl]);
set(gca,'FontSize',14);
xlabel('$$y$$','Interpreter','latex','FontSize',18);
ylabel('');
set(gca,'YTickLabel','')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(1,(yl + max(f_DNS(:,2)))*0.6,'$$\tau=10, \ Pr = 0.7$$','Interpreter','latex','FontSize',15,'HorizontalAlignment','center');
str1 = 'DNS';
str2 = 'SA';
str3 = 'V2F-NO';
str4 = 'V2F-DW';
str5 = 'V2F-DWR';
legend({str1,str2,str3,str4,str5},'Interpreter','latex','FontSize',10,'location','south');
legend boxoff

print(fig,strcat(path,'Fluxgrey_1_10p.eps'),'-depsc')