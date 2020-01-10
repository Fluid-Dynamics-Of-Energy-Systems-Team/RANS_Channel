
function [fig1,fig2] = plot_bar(diff1t,diff2t,diff3t,diff4,diff5,diff6,label,title,namefile)


set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot,'defaultAxesFontSize',20)



grey = [0.8 0.8 0.8];

ym1 = max([diff1t, diff2t, diff3t]);
ym2 = max([diff4, diff5, diff6]);

diff1 = diff1t;
diff2 = diff2t;
diff3 = diff3t;

mymap  = importdata('colormap/colormap');
color1 = mymap(ceil(length(mymap(:,1))/4),:); 
color2 = mymap(floor(length(mymap(:,1))/20*14),:); %mymap(length(mymap(:,1))/2,:);
color3 = mymap(floor(length(mymap(:,1))/18*16),:);
color4 = grey;

% ---------------------------------------------
fig1=figure('Position',[0 0 450 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha,pos] = tight_subplot(1,3,[0.02 0.005],[0.05 0.08],[0.12 0.02]);

axes(ha(1))
%b1 = bar(1,diff1(1),'FaceColor',color1);
hold on
%b2 = bar(2,diff1(2),'FaceColor',color2);
b3 = bar(1,diff1(3),'FaceColor',color3);
b4 = bar(2,diff1(4),'FaceColor',color1);
switch label
    case 'NU'; ylabel('$$\alpha_{t}$$ error','interpreter','latex','FontSize',16);
    case 'FL'; ylabel('$$Flux_{rms}$$','interpreter','latex');
end
ylim([0 ym1])
text(1.5,ym1*1.05,title{1},'FontSize',16,'horizontalalignment','center');
set(gca,'XTickLabel','');
set(gca,'YTickLabel',num2str(get(gca,'YTick').','%2.0f'));
%legend({'standard','radiative modification'},'location','north')
%legend boxoff
box on

axes(ha(2))
%b1 = bar(1,diff2(1),'FaceColor',color1);
hold on
%b2 = bar(2,diff2(2),'FaceColor',color2);
b3 = bar(1,diff2(3),'FaceColor',color3);
b4 = bar(2,diff2(4),'FaceColor',color1);
set(gca,'YTickLabel','');
ylim([0 ym1])
text(1.5,ym1*1.05,title{2},'FontSize',16,'horizontalalignment','center');
set(gca,'XTickLabel','');
box on

axes(ha(3))
%b1 = bar(1,diff3(1),'FaceColor',color1);
hold on
%b2 = bar(2,diff3(2),'FaceColor',color2);
b3 = bar(1,diff3(3),'FaceColor',color3);
b4 = bar(2,diff3(4),'FaceColor',color1);
set(gca,'YTickLabel','');
ylim([0 ym1])
text(1.5,ym1*1.05,title{3},'FontSize',16,'horizontalalignment','center');
set(gca,'XTickLabel','');
box on
% ---------------------------------------------
fig2=figure('Position',[0 0 450 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha,pos] = tight_subplot(1,3,[0.02 0.005],[0.05 0.08],[0.12 0.02]);

axes(ha(1))
%b1 = bar(1,diff4(1),'FaceColor',color1);
hold on
%b2 = bar(2,diff4(2),'FaceColor',color2);
b3 = bar(1,diff4(3),'FaceColor',color3);
b4 = bar(2,diff4(4),'FaceColor',color1);
switch label
    case 'NU'; ylabel('$$Nu$$ error','interpreter','latex','FontSize',16);
    case 'FL'; ylabel('$$\alpha_{rms}$$','interpreter','latex');
end
ylim([0 ym2])
text(1.5,ym2*1.05,title{1},'FontSize',16,'horizontalalignment','center');
set(gca,'XTickLabel','');
set(gca,'YTickLabel',num2str(get(gca,'YTick').','%2.0f'));
%legend({'standard','radiative modification'},'location','north')
%legend boxoff
box on

axes(ha(2))
%b1 = bar(1,diff5(1),'FaceColor',color1);
hold on
%b2 = bar(2,diff5(2),'FaceColor',color2);
b3 = bar(1,diff5(3),'FaceColor',color3);
b4 = bar(2,diff5(4),'FaceColor',color1);
set(gca,'YTickLabel','');
ylim([0 ym2])
text(1.5,ym2*1.05,title{2},'FontSize',16,'horizontalalignment','center');
set(gca,'XTickLabel','');
box on

axes(ha(3))
%b1 = bar(1,diff6(1),'FaceColor',color1);
hold on
%b2 = bar(2,diff6(2),'FaceColor',color2);
b3 = bar(1,diff6(3),'FaceColor',color3);
b4 = bar(2,diff6(4),'FaceColor',color1);
set(gca,'YTickLabel','');
ylim([0 ym2])
text(1.5,ym2*1.05,title{3},'FontSize',16,'horizontalalignment','center');
set(gca,'XTickLabel','');
box on
% ---------------------------------------------
% set(gcf, 'PaperUnits','points');
% factor1 = 0.8272; factor2 = factor1; %0.72;
% set(gcf, 'PaperPosition', [0 0 factor1*1800 factor2*600]);

end