function [fig1, fig2] = plotcase2(case_in1,case_in2,case_in3)

set(groot,'defaultLineLineWidth',1.3)
set(groot,'defaultAxesFontSize',16)
set(groot,'defaultAxesTickLabelInterpreter','latex')

dns  = importdata('solution/DNS/t10rm');
ydns = [dns(1:2:end/4,1)' dns(end/4:5:end/4*3,1)' dns(3*end/4:2:end,1)'];


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

grey =[0.2 0.2 0.2];
TickLength = [0.02 0.05];


grey2 = [0.6 0.6 0.6];

%%




mymap  = importdata('colormap/colormap');
color1 = mymap(ceil(length(mymap(:,1))/18*4),:); 
color2 = mymap(floor(length(mymap(:,1))/20*14),:); %mymap(length(mymap(:,1))/2,:);
color3 = mymap(floor(length(mymap(:,1))/18*16),:);
color4 = grey2;

fig1=figure('Position',[0 0 1000 430]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha,pos] = tight_subplot(1,3,[0.02 0.01],[0.2 0.1],[0.08 0.02]);

% axes(ha(1))
% D1 = abs((V2F1.DWX.T(1:end/2)   - 1) / V2F1.DWX.qcd(1));
% D2 = abs((V2F1.DWX.T(end/2:end)) / V2F1.DWX.qcd(end));
% R1 = abs((V2F1.RAD.T(1:end/2) - 1) / V2F1.RAD.qcd(1));
% R2 = abs((V2F1.RAD.T(end/2:end)) / V2F1.RAD.qcd(end));
% N1 = abs((SA1.Tdns(1:end/2) - 1) / SA1.qcddns(1));
% N2 = abs((SA1.Tdns(end/2:end)) / SA1.qcddns(end));
% DN1   = interp1(y(1:end/2),N1,ydns(1:end/2),'pchip');
% DN2   = interp1(y(end/2:end),N2,ydns(end/2:end),'pchip');
% hold on
% lim = max([max(D1),max(D2),max(R1),max(R2),max(DN1),max(DN2)]);
% plot(y(1:end/2),D1,'-','color',color3,'LineWidth',1.8);
% plot(y(1:end/2),R1,'-','color',color4,'LineWidth',1.8);
% plot(ydns(1:end/2),DN1,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
% plot(2-y(end/2:end),D2,'-','color',color3,'LineWidth',0.8);
% plot(2-y(end/2:end),R2,'-','color',color4,'LineWidth',0.8);
% plot(2-ydns(end/2:end),DN2,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
% axis([0 1 0 lim]);
% set(gca,'xscale','log')
% ylabel('$T^+$','Interpreter','latex');
% %yticks([0 0.3 0.6 1]);
% %set(gca,'YTickLabel',{'0', '0.3', '0.6', '1'});
% xlabel('$y/\delta$','Interpreter','latex');
% set(gca,'XMinorTick','on','YMinorTick','on')
% set(gca,'ticklength',TickLength);
% legend({'V-2','V-R','DNS'},'location','northwest');
% legend boxoff
% box on
% 
% axes(ha(2))
% D1 = abs((V2F2.DWX.T(1:end/2)   - 1) / V2F2.DWX.qcd(1));
% D2 = abs((V2F2.DWX.T(end/2:end)) / V2F2.DWX.qcd(end));
% R1 = abs((V2F2.RAD.T(1:end/2) - 1) / V2F2.RAD.qcd(1));
% R2 = abs((V2F2.RAD.T(end/2:end)) / V2F2.RAD.qcd(end));
% N1 = abs((SA2.Tdns(1:end/2) - 1) / SA2.qcddns(1));
% N2 = abs((SA2.Tdns(end/2:end)) / SA2.qcddns(end));
% DN1   = interp1(y(1:end/2),N1,ydns(1:end/2),'pchip');
% DN2   = interp1(y(end/2:end),N2,ydns(end/2:end),'pchip');
% hold on
% lim = max([max(D1),max(D2),max(R1),max(R2),max(DN1),max(DN2)]);
% plot(y(1:end/2),D1,'-','color',color3,'LineWidth',1.8);
% plot(y(1:end/2),R1,'-','color',color4,'LineWidth',1.8);
% plot(ydns(1:end/2),DN1,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
% plot(2-y(end/2:end),D2,'-','color',color3,'LineWidth',0.8);
% plot(2-y(end/2:end),R2,'-','color',color4,'LineWidth',0.8);
% plot(2-ydns(end/2:end),DN2,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
% axis([0 1 0 lim]);
% set(gca,'xscale','log')
% xlabel('$y/\delta$','Interpreter','latex');
% set(gca,'XMinorTick','on','YMinorTick','on')
% set(gca,'ticklength',TickLength);
% box on
% 
% axes(ha(3))
% D1 = abs((V2F3.DWX.T(1:end/2)   - 1) / V2F3.DWX.qcd(1));
% D2 = abs((V2F3.DWX.T(end/2:end)) / V2F3.DWX.qcd(end));
% R1 = abs((V2F3.RAD.T(1:end/2) - 1) / V2F3.RAD.qcd(1));
% R2 = abs((V2F3.RAD.T(end/2:end)) / V2F3.RAD.qcd(end));
% N1 = abs((SA3.Tdns(1:end/2) - 1) / SA3.qcddns(1));
% N2 = abs((SA3.Tdns(end/2:end)) / SA3.qcddns(end));
% DN1   = interp1(y(1:end/2),N1,ydns(1:end/2),'pchip');
% DN2   = interp1(y(end/2:end),N2,ydns(end/2:end),'pchip');
% hold on
% lim = max([max(D1),max(D2),max(R1),max(R2),max(DN1),max(DN2)]);
% plot(y(1:end/2),D1,'-','color',color3,'LineWidth',1.8);
% plot(y(1:end/2),R1,'-','color',color4,'LineWidth',1.8);
% plot(ydns(1:end/2),DN1,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
% plot(2-y(end/2:end),D2,'-','color',color3,'LineWidth',0.8);
% plot(2-y(end/2:end),R2,'-','color',color4,'LineWidth',0.8);
% plot(2-ydns(end/2:end),DN2,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
% axis([0 1 0 lim]);
% set(gca,'xscale','log')
% xlabel('$y/\delta$','Interpreter','latex');
% set(gca,'XMinorTick','on','YMinorTick','on')
% set(gca,'ticklength',TickLength);
% box on

axes(ha(1))
hold on
lim = max([1-V2F1.DWX.T(end/2),V2F1.DWX.T(end/2),1-V2F1.RAD.T(end/2),V2F1.RAD.T(end/2)]);
plot(y(1:end/2),1-V2F1.DWX.T(1:end/2),'-','color',color3,'LineWidth',1.8);
plot(y(1:end/2),1-V2F1.RAD.T(1:end/2),'-','color',color4,'LineWidth',1.8);
plot(ydns(1:end/2),1-TD1(1:end/2),'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
plot(2-y(end/2:end),V2F1.DWX.T(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F1.RAD.T(end/2:end),'-','color',color4,'LineWidth',0.8);
plot(2-ydns(end/2:end),TD1(end/2:end),'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
axis([0 1 0 lim]);
set(gca,'xscale','log')
ylabel('$| \overline{T} - T_w|$','Interpreter','latex');
xlabel('$y^+$','Interpreter','latex');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
legend({'V-2','V-R','DNS'},'location','northwest');
legend boxoff
box on

axes(ha(2))
hold on
lim = max([1-V2F2.DWX.T(end/2),V2F2.DWX.T(end/2),1-V2F2.RAD.T(end/2),V2F2.RAD.T(end/2)]);
plot(y(1:end/2),1-V2F2.DWX.T(1:end/2),'-','color',color3,'LineWidth',1.8);
plot(y(1:end/2),1-V2F2.RAD.T(1:end/2),'-','color',color4,'LineWidth',1.8);
plot(ydns(1:end/2),1-TD2(1:end/2),'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
plot(2-y(end/2:end),V2F2.DWX.T(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F2.RAD.T(end/2:end),'-','color',color4,'LineWidth',0.8);
plot(2-ydns(end/2:end),TD2(end/2:end),'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
axis([0 1 0 lim]);
set(gca,'xscale','log')
set(gca,'YTickLabel','');
xlabel('$y^+$','Interpreter','latex');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
box on

axes(ha(3))
hold on
lim = max([1-V2F3.DWX.T(end/2),V2F3.DWX.T(end/2),1-V2F3.RAD.T(end/2),V2F3.RAD.T(end/2)]);
plot(y(1:end/2),1-V2F3.DWX.T(1:end/2),'-','color',color3,'LineWidth',1.8);
plot(y(1:end/2),1-V2F3.RAD.T(1:end/2),'-','color',color4,'LineWidth',1.8);
plot(ydns(1:end/2),1-TD3(1:end/2),'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
plot(2-y(end/2:end),V2F3.DWX.T(end/2:end),'-','color',color3,'LineWidth',0.8);
plot(2-y(end/2:end),V2F3.RAD.T(end/2:end),'-','color',color4,'LineWidth',0.8);
plot(2-ydns(end/2:end),TD3(end/2:end),'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
axis([0 1 0 lim]);
set(gca,'xscale','log')
set(gca,'YTickLabel','');
xlabel('$y^+$','Interpreter','latex');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
box on
% 
% fig2=figure('Position',[0 0 1000 430]);
% axp = axes('Position',[0 0 1 1],'Visible','off');
% [ha,pos] = tight_subplot(1,3,[0.02 0.01],[0.2 0.1],[0.08 0.02]);
% 
% y1 = max(V2F1.DWX.THF*1.1);
% y2 = max(V2F2.DWX.THF*1.1);
% y3 = max(V2F3.DWX.THF*1.1);
% ylim = max([y1 y2 y3]);
% 
% axes(ha(1))
% plot(y,SA1.THF,'-','color',color1);
% hold on
% plot(y,V2F1.NO.THF,'-','color',color2);
% plot(y,V2F1.DWX.THF,'-','color',color3);
% plot(y,V2F1.RAD.THF,'-.','color',color4,'LineWidth',1.8);
% plot(ydns,THFD1,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
% ylabel('$\overline{\rho} \widetilde{v^{\prime \prime} T^{\prime \prime}}$','Interpreter','latex');
% set(gca,'XMinorTick','on','YMinorTick','on')
% set(gca,'ticklength',TickLength);
% axis([0 2 0 ylim]);
% xlabel('$y/\delta$','Interpreter','latex');
% legend({'SA','V-N','V-2','V-R','DNS'},'location','northwest');
% legend boxoff
% box on
% 
% axes(ha(2))
% hold on
% plot(y,SA2.THF,'-','color',color1);
% plot(y,V2F2.NO.THF,'-','color',color2);
% plot(y,V2F2.DWX.THF,'-','color',color3);
% plot(y,V2F2.RAD.THF,'-.','color',color4,'LineWidth',1.8);
% plot(ydns,THFD2,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
% set(gca,'XMinorTick','on','YMinorTick','on')
% set(gca,'YTicklabel','');
% set(gca,'ticklength',TickLength);
% axis([0 2 0 ylim]);
% xlabel('$y/\delta$','Interpreter','latex');
% box on
% 
% axes(ha(3))
% hold on
% plot(y,SA3.THF,'-','color',color1);
% plot(y,V2F3.NO.THF,'-','color',color2);
% plot(y,V2F3.DWX.THF,'-','color',color3);
% plot(y,V2F3.RAD.THF,'-.','color',color4,'LineWidth',1.8);
% plot(ydns,THFD3,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
% set(gca,'XMinorTick','on','YMinorTick','on')
% set(gca,'YTicklabel','');
% set(gca,'ticklength',TickLength);
% axis([0 2 0 ylim]);
% xlabel('$y/\delta$','Interpreter','latex');
% box on

end

