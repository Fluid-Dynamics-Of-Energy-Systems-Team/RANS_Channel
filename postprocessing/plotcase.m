function [fig1, fig2] = plotcase(case_in1,case_in2,case_in3)

set(groot,'defaultLineLineWidth',1.3)
set(groot,'defaultAxesFontSize',16)
set(groot,'defaultAxesTickLabelInterpreter','latex')

dns  = importdata('solution/DNS/t10rm');
ydns = [dns(1:3:end/4,1)' dns(end/4:5:end/4*3,1)' dns(3*end/4:3:end,1)'];


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

mymap  = importdata('colormap/colormap');
color1 = mymap(ceil(length(mymap(:,1))/18*4),:); 
color2 = mymap(floor(length(mymap(:,1))/20*14),:); %mymap(length(mymap(:,1))/2,:);
color3 = mymap(floor(length(mymap(:,1))/18*16),:);
color4 = grey2;

fig1=figure('Position',[0 0 1000 430]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha,pos] = tight_subplot(1,3,[0.02 0.01],[0.2 0.1],[0.08 0.02]);

axes(ha(1))
hold on
plot(y,SA1.T,'-','color',color1);
plot(y,V2F1.NO.T,'-','color',color2);
plot(y,V2F1.DWX.T,'-','color',color3);
plot(y,V2F1.RAD.T,'-','color',color4,'LineWidth',1.8);
plot(ydns,TD1,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
axis([0 2 0 1]);
ylabel('$\widetilde{T}$','Interpreter','latex');
yticks([0 0.3 0.6 1]);
set(gca,'YTickLabel',{'0', '0.3', '0.6', '1'});
xlabel('$y/\delta$','Interpreter','latex');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
legend({'SA','V-N','V-2','V-R','DNS'},'location','southwest');
legend boxoff
box on

axes(ha(2))
hold on
plot(y,SA2.T,'-','color',color1);
plot(y,V2F2.NO.T,'-','color',color2);
plot(y,V2F2.DWX.T,'-','color',color3);
plot(y,V2F2.RAD.T,'-','color',color4,'LineWidth',1.8);
plot(ydns,TD2,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
set(gca,'YTicklabel','');
xlabel('$y/\delta$','Interpreter','latex');
axis([0 2 0 1]);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
box on

axes(ha(3))
hold on
plot(y,SA3.T,'-','color',color1);
plot(y,V2F3.NO.T,'-','color',color2);
plot(y,V2F3.DWX.T,'-','color',color3);
plot(y,V2F3.RAD.T,'-','color',color4,'LineWidth',1.8);
plot(ydns,TD3,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
set(gca,'YTicklabel','');
xlabel('$y/\delta$','Interpreter','latex');
axis([0 2 0 1]);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
box on

fig2=figure('Position',[0 0 1000 430]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha,pos] = tight_subplot(1,3,[0.02 0.01],[0.2 0.1],[0.08 0.02]);

y1 = max(V2F1.DWX.THF*1.1);
y2 = max(V2F2.DWX.THF*1.1);
y3 = max(V2F3.DWX.THF*1.1);
ylim = max([y1 y2 y3]);

axes(ha(1))
plot(y,SA1.THF,'-','color',color1);
hold on
plot(y,V2F1.NO.THF,'-','color',color2);
plot(y,V2F1.DWX.THF,'-','color',color3);
plot(y,V2F1.RAD.THF,'-.','color',color4,'LineWidth',1.8);
plot(ydns,THFD1,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
ylabel('$\overline{\rho} \widetilde{v^{\prime \prime} T^{\prime \prime}}$','Interpreter','latex');
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'ticklength',TickLength);
axis([0 2 0 ylim]);
xlabel('$y/\delta$','Interpreter','latex');
legend({'SA','V-N','V-2','V-R','DNS'},'location','northwest');
legend boxoff
box on

axes(ha(2))
hold on
plot(y,SA2.THF,'-','color',color1);
plot(y,V2F2.NO.THF,'-','color',color2);
plot(y,V2F2.DWX.THF,'-','color',color3);
plot(y,V2F2.RAD.THF,'-.','color',color4,'LineWidth',1.8);
plot(ydns,THFD2,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'YTicklabel','');
set(gca,'ticklength',TickLength);
axis([0 2 0 ylim]);
xlabel('$y/\delta$','Interpreter','latex');
box on

axes(ha(3))
hold on
plot(y,SA3.THF,'-','color',color1);
plot(y,V2F3.NO.THF,'-','color',color2);
plot(y,V2F3.DWX.THF,'-','color',color3);
plot(y,V2F3.RAD.THF,'-.','color',color4,'LineWidth',1.8);
plot(ydns,THFD3,'o','color',grey,'MarkerSize',5,'Linewidth',0.5);
set(gca,'XMinorTick','on','YMinorTick','on')
set(gca,'YTicklabel','');
set(gca,'ticklength',TickLength);
axis([0 2 0 ylim]);
xlabel('$y/\delta$','Interpreter','latex');
box on

end

