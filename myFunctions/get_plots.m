function [ ] = get_plots( anchors,nodes,x_est )
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
    figure
    plot(anchors(1,1),anchors(2,1),'k*',anchors(3,1),anchors(4,1),'k*',anchors(5,1),anchors(6,1),'k*')
    hold on
    p1=plot(anchors(1,:),anchors(2,:),'k',anchors(3,:),anchors(4,:),'k',anchors(5,:),anchors(6,:),'k');
    hold on
    plot(nodes(1,1),nodes(2,1),'c*',nodes(3,1),nodes(4,1),'c*',nodes(5,1),nodes(6,1),'c*')
    hold on
    p2=plot(nodes(1,:),nodes(2,:),'c',nodes(3,:),nodes(4,:),'c',nodes(5,:),nodes(6,:),'c');
    hold on
    plot(x_est(1,1),x_est(2,1),'m*',x_est(3,1),x_est(4,1),'m*',x_est(5,1),x_est(6,1),'m*')
    %plot(x_est(1,1),x_est(2,1),'m*',x_est(3,1),x_est(4,1),'m*',x_est(5,1),x_est(6,1),'m*')
    hold on
    p3=plot(x_est(1,:),x_est(2,:),'m',x_est(3,:),x_est(4,:),'m',x_est(5,:),x_est(6,:),'m');
    xlabel('x[m]') 
    ylabel('y[m]')
    
    M = max([anchors(2,:) anchors(4,:) anchors(6,:)]);
    m = min([anchors(2,:) anchors(4,:) anchors(6,:)]);
    
    %xlim([0 145]) 
    ylim([m-max(0.2*abs(m),5) M+0.3*M]) 
    l=legend([p1(1) p2(1) p3(1)],'Anchors','Nodes'' True Position','Nodes'' Estimated Position','Orientation','Horizontal','Location','northeast');
    l.FontSize = 9;
    legend('boxoff')
    box off


end

