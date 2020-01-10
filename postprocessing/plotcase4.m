function [fig1, fig2, fig3, fig4] = plotcase4(case_in1,case_in2,case_in3,title)

set(groot,'defaultLineLineWidth',1.3)
set(groot,'defaultAxesFontSize',14)
set(groot,'defaultAxesTickLabelInterpreter','latex')

dns  = importdata('solution/DNS/t10rm');
ydns = [dns(1:end/16,1)' dns(end/16:2:end/8,1)' dns(end/8:4:end/4,1)' dns(end/4:5:end/4*3,1)' dns(3*end/4:4:7*end/8,1)' dns(7*end/8:2:15*end/16,1)' dns(15*end/16:end,1)'];


y = case_in1.SA.y;

SA1 = case_in1.SA;
V2F1= case_in1.V2F;
SA2 = case_in2.SA;
V2F2= case_in2.V2F;
SA3 = case_in3.SA;
V2F3= case_in3.V2F;

TD1   = interp1(y,SA1.Tdns,ydns,'pchip');
THFD1 = interp1(y,SA1.THFdns,ydns,'pchip');
TD2   = interp1(y,SA2.Tdns,ydns,'pchip');
THFD2 = interp1(y,SA2.THFdns,ydns,'pchip');
TD3   = interp1(y,SA3.Tdns,ydns,'pchip');
THFD3 = interp1(y,SA3.THFdns,ydns,'pchip');

grey =[0.21 0.2 0.2];
TickLength = [0.02 0.05];


grey2 = [0.6 0.6 0.6];

%%

mymap  = importdata('colormap/colormap');
color1 = mymap(ceil(length(mymap(:,1))/18*4),:); 
color2 = mymap(floor(length(mymap(:,1))/20*14),:); %mymap(length(mymap(:,1))/2,:);
color4 = mymap(floor(length(mymap(:,1))/18*16),:);
color3 = color1; %grey2;
color2 = grey2;

fig1=figure('Position',[0 0 1000 650]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha,pos] = tight_subplot(2,3,[0.04 0.01],[0.1 0.08],[0.08 0.02]);

lim1 = max([1-V2F1.DWX.T(end/2),V2F1.DWX.T(end/2),1-V2F1.RAD.T(end/2),V2F1.RAD.T(end/2),V2F1.RAD.P.T(end/2),1-V2F1.RAD.P.T(end/2)]);
lim3 = max([1-V2F3.DWX.T(end/2),V2F3.DWX.T(end/2),1-V2F3.RAD.T(end/2),V2F3.RAD.T(end/2),V2F3.RAD.P.T(end/2),1-V2F3.RAD.P.T(end/2)]);
lim2 = max([1-V2F2.DWX.T(end/2),V2F2.DWX.T(end/2),1-V2F2.RAD.T(end/2),V2F2.RAD.T(end/2),V2F2.RAD.P.T(end/2),1-V2F2.RAD.P.T(end/2)]);

lim = max([lim1, lim2, lim3]);

axes(ha(1))
hold on
plot(y(1:end/2),1-V2F1.DWX.T(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(y(1:end/2),1-V2F1.RAD.P.T(1:end/2),'--','color',color4,'LineWidth',1.3);
plot(y(1:end/2),1-V2F1.RAD.T(1:end/2),'-','color',color4,'LineWidth',1.8);
plot(ydns(1:end/2),1-TD1(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F1.DWX.T(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F1.RAD.P.T(end/2:end),'--','color',color3,'LineWidth',1.3);
plot(2-y(end/2:end),V2F1.RAD.T(end/2:end),'-','color',color3,'LineWidth',1.8);
plot(2-ydns(end/2:end),TD1(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
ylabel('$| \overline{T} - T_w|$','Interpreter','latex');
axis([0 1 0 lim]);
set(gca,'xscale','log')
yticks([0 lim/3 lim/3*2 lim]);
set(gca,'YTickLabel',{num2str(0,'%.1f'), num2str(lim/3,'%.1f'), num2str(lim/3*2,'%.1f'), num2str(lim,'%.1f')});
set(gca,'XTickLabel','');
xlabel('');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(0.015,lim*1.06,title{1},'FontSize',18,'interpreter','latex','horizontalalignment','center')
h = legend({'standard model','rad mod $f_G(\kappa_p)$','rad mod $f_G(\kappa_g)$'},'location','northwest','interpreter','latex');
legend boxoff
p = get(h,'Position');
box on

axes(ha(2))
hold on
plot(y(1:end/2),1-V2F2.DWX.T(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(y(1:end/2),1-V2F2.RAD.P.T(1:end/2),'--','color',color4,'LineWidth',1.3);
plot(y(1:end/2),1-V2F2.RAD.T(1:end/2),'-','color',color4,'LineWidth',1.8);
plot(ydns(1:end/2),1-TD2(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F2.DWX.T(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F2.RAD.P.T(end/2:end),'--','color',color3,'LineWidth',1.3);
plot(2-y(end/2:end),V2F2.RAD.T(end/2:end),'-','color',color3,'LineWidth',1.8);
plot(2-ydns(end/2:end),TD2(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
axis([0 1 0 lim]);
set(gca,'xscale','log')
yticks([0 lim/3 lim/3*2 lim]);
set(gca,'YTickLabel','','XTickLabel','');
xlabel('');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(0.015,lim*1.06,title{2},'FontSize',18,'interpreter','latex','horizontalalignment','center')
box on

axes(ha(3))
hold on
plot(y(1:end/2),1-V2F3.DWX.T(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(y(1:end/2),1-V2F3.RAD.P.T(1:end/2),'--','color',color4,'LineWidth',1.3);
plot(y(1:end/2),1-V2F3.RAD.T(1:end/2),'-','color',color4,'LineWidth',1.8);
plot(ydns(1:end/2),1-TD3(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F3.DWX.T(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F3.RAD.P.T(end/2:end),'--','color',color3,'LineWidth',1.3);
plot(2-y(end/2:end),V2F3.RAD.T(end/2:end),'-','color',color3,'LineWidth',1.8);
plot(2-ydns(end/2:end),TD3(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
axis([0 1 0 lim]);
set(gca,'xscale','log')
yticks([0 lim/3 lim/3*2 lim]);
set(gca,'YTickLabel','','XTickLabel','');
xlabel('');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(0.015,lim*1.06,title{3},'FontSize',18,'interpreter','latex','horizontalalignment','center')
box on

y1 = max(V2F1.DWX.THF*1.1);
y2 = max(V2F2.DWX.THF*1.1);
y3 = max(V2F3.DWX.THF*1.1);
ylim = max([y1 y2 y3]);

axes(ha(4))
hold on
plot(y(1:end/2),V2F1.DWX.THF(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(y(1:end/2),V2F1.RAD.P.THF(1:end/2),'--','color',color4,'LineWidth',1.3);
plot(y(1:end/2),V2F1.RAD.THF(1:end/2),'-','color',color4,'LineWidth',1.8);
plot(ydns(1:end/2),THFD1(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F1.DWX.THF(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F1.RAD.P.THF(end/2:end),'--','color',color3,'LineWidth',1.3);
plot(2-y(end/2:end),V2F1.RAD.THF(end/2:end),'-','color',color3,'LineWidth',1.8);
plot(2-ydns(end/2:end),THFD1(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
ylabel('$\overline{\rho} \widetilde{v^{\prime \prime} T^{\prime \prime}}$','Interpreter','latex');
axis([0 1 0 ylim]);
yticks([0 ylim/3 ylim/3*2 ylim]);
set(gca, 'YTickLabel', num2str (get (gca, 'YTick').'*1000 , '%.1f') )
ha(4).YAxis.Exponent = -3;
set(gca,'xscale','log')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
set(gca, 'XTickLabel', '' )
text(y(2),ylim*1.03,'$\times 10^{-3}$','interpreter','latex','FontSize',14);
text(y(2),ylim*(-0.07),'wall','interpreter','latex','FontSize',14);
text(y(floor(length(y)*2.8/8)),ylim*(-0.07),'center','interpreter','latex','FontSize',14);
text(0.001,ylim/5*4.1,'$\circ$ DNS cold side','FontSize',13,'interpreter','latex','color',color3);
text(0.001,ylim/4*3,'$\circ$ DNS hot side','FontSize',13,'interpreter','latex','color',color4);
box on

axes(ha(5))
hold on
plot(y(1:end/2),V2F2.DWX.THF(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(y(1:end/2),V2F2.RAD.P.THF(1:end/2),'--','color',color4,'LineWidth',1.3);
plot(y(1:end/2),V2F2.RAD.THF(1:end/2),'-','color',color4,'LineWidth',1.8);
plot(ydns(1:end/2),THFD2(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F2.DWX.THF(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F2.RAD.P.THF(end/2:end),'--','color',color3,'LineWidth',1.3);
plot(2-y(end/2:end),V2F2.RAD.THF(end/2:end),'-','color',color3,'LineWidth',1.8);
plot(2-ydns(end/2:end),THFD2(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
axis([0 1 0 ylim]);
set(gca,'xscale','log')
yticks([0 ylim/3 ylim/3*2 ylim]);
set(gca,'YTicklabel','');
set(gca,'ticklength',TickLength);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca, 'XTickLabel', '' )
text(y(2),ylim*(-0.07),'wall','interpreter','latex','FontSize',14);
text(y(floor(length(y)*2.8/8)),ylim*(-0.07),'center','interpreter','latex','FontSize',14);
box on

axes(ha(6))
hold on
plot(y(1:end/2),V2F3.DWX.THF(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(y(1:end/2),V2F3.RAD.P.THF(1:end/2),'--','color',color4,'LineWidth',1.3);
plot(y(1:end/2),V2F3.RAD.THF(1:end/2),'-','color',color4,'LineWidth',1.8);
plot(ydns(1:end/2),THFD3(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F3.DWX.THF(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F3.RAD.P.THF(end/2:end),'--','color',color3,'LineWidth',1.3);
plot(2-y(end/2:end),V2F3.RAD.THF(end/2:end),'-','color',color3,'LineWidth',1.8);
plot(2-ydns(end/2:end),THFD3(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
axis([0 1 0 ylim]);
set(gca,'xscale','log')
set(gca,'XMinorTick','on','YMinorTick','on')
yticks([0 ylim/3 ylim/3*2 ylim]);
set(gca,'YTicklabel','');
set(gca,'ticklength',TickLength);
set(gca, 'XTickLabel', '' )
% xlabel('wall distance','Interpreter','latex');
text(y(2),ylim*(-0.07),'wall','interpreter','latex','FontSize',14);
text(y(floor(length(y)*2.8/8)),ylim*(-0.07),'center','interpreter','latex','FontSize',14);
box on

%% FIGURE 2


fig2=figure('Position',[0 0 1000 650]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha,pos] = tight_subplot(2,3,[0.04 0.01],[0.1 0.08],[0.08 0.02]);

axes(ha(1))
hold on
plot(ydns(1:end/2),1-TD1(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-ydns(end/2:end),TD1(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
plot(y(1:end/2),V2F2.RAD.THF(1:end/2)+100,'-','color',color3,'LineWidth',2.3);
ylabel('$| \overline{T} - T_w|$','Interpreter','latex');
axis([0 1 0 lim]);
set(gca,'xscale','log')
yticks([0 lim/3 lim/3*2 lim]);
set(gca,'YTickLabel',{num2str(0,'%.1f'), num2str(lim/3,'%.1f'), num2str(lim/3*2,'%.1f'), num2str(lim,'%.1f')});
set(gca,'XTickLabel','');
xlabel('');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(0.015,lim*1.06,title{1},'FontSize',18,'interpreter','latex','horizontalalignment','center')
% h = legend({'DNS cold side', 'DNS hot side'},'location','northwest','interpreter','latex');
% legend boxoff
% p = get(h,'Position');
box on

axes(ha(2))
hold on
plot(ydns(1:end/2),1-TD2(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-ydns(end/2:end),TD2(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
plot(y(1:end/2),V2F2.RAD.THF(1:end/2)+100,'-','color',color3,'LineWidth',2.3);
axis([0 1 0 lim]);
set(gca,'xscale','log')
yticks([0 lim/3 lim/3*2 lim]);
set(gca,'YTickLabel','','XTickLabel','');
xlabel('');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(0.015,lim*1.06,title{2},'FontSize',18,'interpreter','latex','horizontalalignment','center')
box on

axes(ha(3))
hold on
plot(ydns(1:end/2),1-TD3(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-ydns(end/2:end),TD3(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
plot(y(1:end/2),V2F2.RAD.THF(1:end/2)+100,'-','color',color3,'LineWidth',2.3);
axis([0 1 0 lim]);
set(gca,'xscale','log')
yticks([0 lim/3 lim/3*2 lim]);
set(gca,'YTickLabel','','XTickLabel','');
xlabel('');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(0.015,lim*1.06,title{3},'FontSize',18,'interpreter','latex','horizontalalignment','center')
box on

y1 = max(V2F1.DWX.THF*1.1);
y2 = max(V2F2.DWX.THF*1.1);
y3 = max(V2F3.DWX.THF*1.1);
ylim = max([y1 y2 y3]);

axes(ha(4))
hold on
plot(ydns(1:end/2),THFD1(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-ydns(end/2:end),THFD1(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
plot(y(1:end/2),V2F2.RAD.THF(1:end/2)+100,'-','color',color3,'LineWidth',2.3);
ylabel('$\overline{\rho} \widetilde{v^{\prime \prime} T^{\prime \prime}}$','Interpreter','latex');
axis([0 1 0 ylim]);
yticks([0 ylim/3 ylim/3*2 ylim]);
set(gca, 'YTickLabel', num2str (get (gca, 'YTick').'*1000 , '%.1f') )
ha(4).YAxis.Exponent = -3;
set(gca,'xscale','log')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
set(gca, 'XTickLabel', '' )
text(y(2),ylim*1.03,'$\times 10^{-3}$','interpreter','latex','FontSize',14);
text(y(2),ylim*(-0.07),'wall','interpreter','latex','FontSize',14);
text(y(floor(length(y)*2.8/8)),ylim*(-0.07),'center','interpreter','latex','FontSize',14);
text(0.001,ylim/5*4.1,'$\circ$ DNS cold side','FontSize',13,'interpreter','latex','color',color3);
text(0.001,ylim/4*3,'$\circ$ DNS hot side','FontSize',13,'interpreter','latex','color',color4);
box on

axes(ha(5))
hold on
plot(ydns(1:end/2),THFD2(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-ydns(end/2:end),THFD2(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
plot(y(1:end/2),V2F2.RAD.THF(1:end/2)+100,'-','color',color3,'LineWidth',2.3);
axis([0 1 0 ylim]);
set(gca,'xscale','log')
yticks([0 ylim/3 ylim/3*2 ylim]);
set(gca,'YTicklabel','');
set(gca,'ticklength',TickLength);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca, 'XTickLabel', '' )
text(y(2),ylim*(-0.07),'wall','interpreter','latex','FontSize',14);
text(y(floor(length(y)*2.8/8)),ylim*(-0.07),'center','interpreter','latex','FontSize',14);
box on

axes(ha(6))
hold on
plot(ydns(1:end/2),THFD3(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-ydns(end/2:end),THFD3(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
plot(y(1:end/2),V2F2.RAD.THF(1:end/2)+100,'-','color',color3,'LineWidth',2.3);
axis([0 1 0 ylim]);
set(gca,'xscale','log')
set(gca,'XMinorTick','on','YMinorTick','on')
yticks([0 ylim/3 ylim/3*2 ylim]);
set(gca,'YTicklabel','');
set(gca,'ticklength',TickLength);
set(gca, 'XTickLabel', '' )
% xlabel('wall distance','Interpreter','latex');
text(y(2),ylim*(-0.07),'wall','interpreter','latex','FontSize',14);
text(y(floor(length(y)*2.8/8)),ylim*(-0.07),'center','interpreter','latex','FontSize',14);
box on

%% FIGURE 3


fig3=figure('Position',[0 0 1000 650]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha,pos] = tight_subplot(2,3,[0.04 0.01],[0.1 0.08],[0.08 0.02]);

axes(ha(1))
hold on
plot(y(1:end/2),1-V2F1.DWX.T(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(ydns(1:end/2),1-TD1(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F1.DWX.T(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-ydns(end/2:end),TD1(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
ylabel('$| \overline{T} - T_w|$','Interpreter','latex');
axis([0 1 0 lim]);
set(gca,'xscale','log')
yticks([0 lim/3 lim/3*2 lim]);
set(gca,'YTickLabel',{num2str(0,'%.1f'), num2str(lim/3,'%.1f'), num2str(lim/3*2,'%.1f'), num2str(lim,'%.1f')});
set(gca,'XTickLabel','');
xlabel('');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(0.015,lim*1.06,title{1},'FontSize',18,'interpreter','latex','horizontalalignment','center')
h = legend({'standard model'},'location','northwest','interpreter','latex');
legend boxoff
p = get(h,'Position');
box on

axes(ha(2))
hold on
plot(y(1:end/2),1-V2F2.DWX.T(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(ydns(1:end/2),1-TD2(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F2.DWX.T(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-ydns(end/2:end),TD2(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
axis([0 1 0 lim]);
set(gca,'xscale','log')
yticks([0 lim/3 lim/3*2 lim]);
set(gca,'YTickLabel','','XTickLabel','');
xlabel('');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(0.015,lim*1.06,title{2},'FontSize',18,'interpreter','latex','horizontalalignment','center')
box on

axes(ha(3))
hold on
plot(y(1:end/2),1-V2F3.DWX.T(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(ydns(1:end/2),1-TD3(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F3.DWX.T(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-ydns(end/2:end),TD3(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
axis([0 1 0 lim]);
set(gca,'xscale','log')
yticks([0 lim/3 lim/3*2 lim]);
set(gca,'YTickLabel','','XTickLabel','');
xlabel('');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(0.015,lim*1.06,title{3},'FontSize',18,'interpreter','latex','horizontalalignment','center')
box on

y1 = max(V2F1.DWX.THF*1.1);
y2 = max(V2F2.DWX.THF*1.1);
y3 = max(V2F3.DWX.THF*1.1);
ylim = max([y1 y2 y3]);

axes(ha(4))
hold on
plot(y(1:end/2),V2F1.DWX.THF(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(ydns(1:end/2),THFD1(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F1.DWX.THF(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-ydns(end/2:end),THFD1(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
ylabel('$\overline{\rho} \widetilde{v^{\prime \prime} T^{\prime \prime}}$','Interpreter','latex');
axis([0 1 0 ylim]);
yticks([0 ylim/3 ylim/3*2 ylim]);
set(gca, 'YTickLabel', num2str (get (gca, 'YTick').'*1000 , '%.1f') )
ha(4).YAxis.Exponent = -3;
set(gca,'xscale','log')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
set(gca, 'XTickLabel', '' )
text(y(2),ylim*1.03,'$\times 10^{-3}$','interpreter','latex','FontSize',14);
text(y(2),ylim*(-0.07),'wall','interpreter','latex','FontSize',14);
text(y(floor(length(y)*2.8/8)),ylim*(-0.07),'center','interpreter','latex','FontSize',14);
text(0.001,ylim/5*4.1,'$\circ$ DNS cold side','FontSize',13,'interpreter','latex','color',color3);
text(0.001,ylim/4*3,'$\circ$ DNS hot side','FontSize',13,'interpreter','latex','color',color4);
box on

axes(ha(5))
hold on
plot(y(1:end/2),V2F2.DWX.THF(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(ydns(1:end/2),THFD2(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F2.DWX.THF(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-ydns(end/2:end),THFD2(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
axis([0 1 0 ylim]);
set(gca,'xscale','log')
yticks([0 ylim/3 ylim/3*2 ylim]);
set(gca,'YTicklabel','');
set(gca,'ticklength',TickLength);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca, 'XTickLabel', '' )
text(y(2),ylim*(-0.07),'wall','interpreter','latex','FontSize',14);
text(y(floor(length(y)*2.8/8)),ylim*(-0.07),'center','interpreter','latex','FontSize',14);
box on

axes(ha(6))
hold on
plot(y(1:end/2),V2F3.DWX.THF(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(ydns(1:end/2),THFD3(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F3.DWX.THF(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-ydns(end/2:end),THFD3(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
axis([0 1 0 ylim]);
set(gca,'xscale','log')
set(gca,'XMinorTick','on','YMinorTick','on')
yticks([0 ylim/3 ylim/3*2 ylim]);
set(gca,'YTicklabel','');
set(gca,'ticklength',TickLength);
set(gca, 'XTickLabel', '' )
% xlabel('wall distance','Interpreter','latex');
text(y(2),ylim*(-0.07),'wall','interpreter','latex','FontSize',14);
text(y(floor(length(y)*2.8/8)),ylim*(-0.07),'center','interpreter','latex','FontSize',14);
box on


%%

fig4=figure('Position',[0 0 1000 650]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha,pos] = tight_subplot(2,3,[0.04 0.01],[0.1 0.08],[0.08 0.02]);

axes(ha(1))
hold on
plot(y(1:end/2),1-V2F1.DWX.T(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(y(1:end/2),1-V2F1.RAD.P.T(1:end/2),'--','color',color4,'LineWidth',1.3);
plot(ydns(1:end/2),1-TD1(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F1.DWX.T(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F1.RAD.P.T(end/2:end),'--','color',color3,'LineWidth',1.3);
plot(2-ydns(end/2:end),TD1(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
ylabel('$| \overline{T} - T_w|$','Interpreter','latex');
axis([0 1 0 lim]);
set(gca,'xscale','log')
yticks([0 lim/3 lim/3*2 lim]);
set(gca,'YTickLabel',{num2str(0,'%.1f'), num2str(lim/3,'%.1f'), num2str(lim/3*2,'%.1f'), num2str(lim,'%.1f')});
set(gca,'XTickLabel','');
xlabel('');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(0.015,lim*1.06,title{1},'FontSize',18,'interpreter','latex','horizontalalignment','center')
h = legend({'standard model','rad mod $f_G(\kappa_p)$'},'location','northwest','interpreter','latex');
legend boxoff
p = get(h,'Position');
box on

axes(ha(2))
hold on
plot(y(1:end/2),1-V2F2.DWX.T(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(y(1:end/2),1-V2F2.RAD.P.T(1:end/2),'--','color',color4,'LineWidth',1.3);
plot(ydns(1:end/2),1-TD2(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F2.DWX.T(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F2.RAD.P.T(end/2:end),'--','color',color3,'LineWidth',1.3);
plot(2-ydns(end/2:end),TD2(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
axis([0 1 0 lim]);
set(gca,'xscale','log')
yticks([0 lim/3 lim/3*2 lim]);
set(gca,'YTickLabel','','XTickLabel','');
xlabel('');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(0.015,lim*1.06,title{2},'FontSize',18,'interpreter','latex','horizontalalignment','center')
box on

axes(ha(3))
hold on
plot(y(1:end/2),1-V2F3.DWX.T(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(y(1:end/2),1-V2F3.RAD.P.T(1:end/2),'--','color',color4,'LineWidth',1.3);
plot(ydns(1:end/2),1-TD3(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F3.DWX.T(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F3.RAD.P.T(end/2:end),'--','color',color3,'LineWidth',1.3);
plot(2-ydns(end/2:end),TD3(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
axis([0 1 0 lim]);
set(gca,'xscale','log')
yticks([0 lim/3 lim/3*2 lim]);
set(gca,'YTickLabel','','XTickLabel','');
xlabel('');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
text(0.015,lim*1.06,title{3},'FontSize',18,'interpreter','latex','horizontalalignment','center')
box on

y1 = max(V2F1.DWX.THF*1.1);
y2 = max(V2F2.DWX.THF*1.1);
y3 = max(V2F3.DWX.THF*1.1);
ylim = max([y1 y2 y3]);

axes(ha(4))
hold on
plot(y(1:end/2),V2F1.DWX.THF(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(y(1:end/2),V2F1.RAD.P.THF(1:end/2),'--','color',color4,'LineWidth',1.3);
plot(ydns(1:end/2),THFD1(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F1.DWX.THF(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F1.RAD.P.THF(end/2:end),'--','color',color3,'LineWidth',1.3);
plot(2-ydns(end/2:end),THFD1(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
ylabel('$\overline{\rho} \widetilde{v^{\prime \prime} T^{\prime \prime}}$','Interpreter','latex');
axis([0 1 0 ylim]);
yticks([0 ylim/3 ylim/3*2 ylim]);
set(gca, 'YTickLabel', num2str (get (gca, 'YTick').'*1000 , '%.1f') )
ha(4).YAxis.Exponent = -3;
set(gca,'xscale','log')
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
set(gca, 'XTickLabel', '' )
text(y(2),ylim*1.03,'$\times 10^{-3}$','interpreter','latex','FontSize',14);
text(y(2),ylim*(-0.07),'wall','interpreter','latex','FontSize',14);
text(y(floor(length(y)*2.8/8)),ylim*(-0.07),'center','interpreter','latex','FontSize',14);
text(0.001,ylim/5*4.1,'$\circ$ DNS cold side','FontSize',13,'interpreter','latex','color',color3);
text(0.001,ylim/4*3,'$\circ$ DNS hot side','FontSize',13,'interpreter','latex','color',color4);
box on

axes(ha(5))
hold on
plot(y(1:end/2),V2F2.DWX.THF(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(y(1:end/2),V2F2.RAD.P.THF(1:end/2),'--','color',color4,'LineWidth',1.3);
plot(ydns(1:end/2),THFD2(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F2.DWX.THF(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F2.RAD.P.THF(end/2:end),'--','color',color3,'LineWidth',1.3);
plot(2-ydns(end/2:end),THFD2(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
axis([0 1 0 ylim]);
set(gca,'xscale','log')
yticks([0 ylim/3 ylim/3*2 ylim]);
set(gca,'YTicklabel','');
set(gca,'ticklength',TickLength);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca, 'XTickLabel', '' )
text(y(2),ylim*(-0.07),'wall','interpreter','latex','FontSize',14);
text(y(floor(length(y)*2.8/8)),ylim*(-0.07),'center','interpreter','latex','FontSize',14);
box on

axes(ha(6))
hold on
plot(y(1:end/2),V2F3.DWX.THF(1:end/2),'-','color',color4,'LineWidth',0.8);
plot(y(1:end/2),V2F3.RAD.P.THF(1:end/2),'--','color',color4,'LineWidth',1.3);
plot(ydns(1:end/2),THFD3(1:end/2),'o','color',color4,'MarkerSize',5,'Linewidth',1.0);
plot(2-y(end/2:end),V2F3.DWX.THF(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F3.RAD.P.THF(end/2:end),'--','color',color3,'LineWidth',1.3);
plot(2-ydns(end/2:end),THFD3(end/2:end),'o','color',color3,'MarkerSize',5,'Linewidth',1.0);
axis([0 1 0 ylim]);
set(gca,'xscale','log')
set(gca,'XMinorTick','on','YMinorTick','on')
yticks([0 ylim/3 ylim/3*2 ylim]);
set(gca,'YTicklabel','');
set(gca,'ticklength',TickLength);
set(gca, 'XTickLabel', '' )
% xlabel('wall distance','Interpreter','latex');
text(y(2),ylim*(-0.07),'wall','interpreter','latex','FontSize',14);
text(y(floor(length(y)*2.8/8)),ylim*(-0.07),'center','interpreter','latex','FontSize',14);
box on


end

