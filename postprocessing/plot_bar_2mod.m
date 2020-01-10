
function [fig1,fig2] = plot_bar_2mod(diff1t,diff2t,diff3t,diff4,diff5,diff6,label,title,namefile)


set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');



grey = [0.6 0.6 0.6];
mycolor=[0 0 0;0 0 1;1 0 0];

ym1 = max([diff1t, diff2t, diff3t]);
ym2 = max([diff4, diff5, diff6]);

diff1 = diff1t;
diff2 = diff2t;
diff3 = diff3t;

% ---------------------------------------------
fig1=figure('Position',[0 0 450 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha,pos] = tight_subplot(1,3,[0.02 0.005],[0.05 0.08],[0.12 0.02]);
% axis tight manual
% filename = strcat(namefile,'-1-test.gif');
% 
% for n = 1:1:4
%     
%     if(n<=1)
%         diff1(1) = diff1t(1)*(n/1.);
%         diff2(1) = diff2t(1)*(n/1.);
%         diff3(1) = diff3t(1)*(n/1.);
%         diff1(2:end) = 0;
%         diff2(2:end) = 0;
%         diff3(2:end) = 0;
%     elseif(n<=2)
%         diff1(1) = diff1t(1);
%         diff2(1) = diff2t(1);
%         diff3(1) = diff3t(1);
%         diff1(2) = diff1t(2)*((n-1)/1.);
%         diff2(2) = diff2t(2)*((n-1)/1.);
%         diff3(2) = diff3t(2)*((n-1)/1.);
%         diff1(3:end) = 0;
%         diff2(3:end) = 0;
%         diff3(3:end) = 0;
%     elseif(n<=3)
%         diff1(1:2) = diff1t(1:2);
%         diff2(1:2) = diff2t(1:2);
%         diff3(1:2) = diff3t(1:2);
%         diff1(3) = diff1t(3)*((n-2)/1.);
%         diff2(3) = diff2t(3)*((n-2)/1.);
%         diff3(3) = diff3t(3)*((n-2)/1.);
%         diff1(4) = 0;
%         diff2(4) = 0;
%         diff3(4) = 0;
%     else
%         diff1(1:3) = diff1t(1:3);
%         diff2(1:3) = diff2t(1:3);
%         diff3(1:3) = diff3t(1:3);
%         diff1(4) = diff1t(4)*((n-3)/1.);
%         diff2(4) = diff2t(4)*((n-3)/1.);
%         diff3(4) = diff3t(4)*((n-3)/1.);
%     end
%     
    axes(ha(1))
    b1 = bar(1,diff1(3),'r');
    hold on
    b4 = bar(2,diff1(4),'FaceColor',grey);
    switch label
        case 'NU'; ylabel('$$\alpha_{t}$$ error','interpreter','latex');
        case 'FL'; ylabel('$$Flux_{rms}$$','interpreter','latex');
    end
    ylim([0 ym1])
    text(2.5,ym1*1.05,title{1},'FontSize',16,'horizontalalignment','center');
    set(gca,'XTickLabel','');
    legend({'SA','V-NO','V-2','V-R'},'location','north')
    legend boxoff
    
    axes(ha(2))
    b1 = bar(1,diff2(3),'r');
    hold on
    b4 = bar(2,diff2(4),'FaceColor',grey);
    set(gca,'YTickLabel','');
    ylim([0 ym1])
    text(2.5,ym1*1.05,title{2},'FontSize',16,'horizontalalignment','center');
    set(gca,'XTickLabel','');
    
    axes(ha(3))
    b1 = bar(1,diff3(3),'r');
    hold on
    b4 = bar(2,diff3(4),'FaceColor',grey);
    set(gca,'YTickLabel','');
    ylim([0 ym1])
    text(2.5,ym1*1.05,title{3},'FontSize',16,'horizontalalignment','center');
    set(gca,'XTickLabel','');
%     drawnow
%     % Capture the plot as an image
%     frame = getframe(fig1);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im,256);
%     % Write to the GIF File
%     if n == 1
%         imwrite(imind,cm,filename,'gif', 'Loopcount',0);
%     else
%         imwrite(imind,cm,filename,'gif','WriteMode','append');
%     end
% end

% ---------------------------------------------
fig2=figure('Position',[0 0 450 450]);
axp = axes('Position',[0 0 1 1],'Visible','off');
[ha,pos] = tight_subplot(1,3,[0.02 0.005],[0.05 0.08],[0.12 0.02]);

axes(ha(1))
b1 = bar(1,diff4(3),'r');
hold on
b4 = bar(2,diff4(4),'FaceColor',grey);
switch label
    case 'NU'; ylabel('$$Nu$$ error','interpreter','latex');
    case 'FL'; ylabel('$$\alpha_{rms}$$','interpreter','latex');
end
ylim([0 ym2])
text(2.5,ym2*1.05,title{1},'FontSize',16,'horizontalalignment','center');
set(gca,'XTickLabel','');
legend({'SA','V-NO','V-2','V-R'},'location','north')
legend boxoff

axes(ha(2))
b1 = bar(1,diff5(3),'r');
hold on
b4 = bar(2,diff5(4),'FaceColor',grey);
set(gca,'YTickLabel','');
ylim([0 ym2])
text(2.5,ym2*1.05,title{2},'FontSize',16,'horizontalalignment','center');
set(gca,'XTickLabel','');

axes(ha(3))
b1 = bar(1,diff6(3),'r');
hold on
b4 = bar(2,diff6(4),'FaceColor',grey);
set(gca,'YTickLabel','');
ylim([0 ym2])
text(2.5,ym2*1.05,title{3},'FontSize',16,'horizontalalignment','center');
set(gca,'XTickLabel','');

% ---------------------------------------------
% set(gcf, 'PaperUnits','points');
% factor1 = 0.8272; factor2 = factor1; %0.72;
% set(gcf, 'PaperPosition', [0 0 factor1*1800 factor2*600]);

end