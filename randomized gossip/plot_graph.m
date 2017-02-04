function plot_graph(x_total,n,n_total)
    hold off;
    plot(x_total(1:n,1),x_total(1:n,2),'s','LineWidth',1,...            
            'MarkerEdgeColor','k',...     
            'MarkerFaceColor','g',...     
            'MarkerSize',8);
    
    hold on;
    plot(x_total(n+1:n_total,1),x_total(n+1:n_total,2),'o','LineWidth',1,...            
                'MarkerEdgeColor','k',...     
                'MarkerFaceColor','r',...     
                'MarkerSize',7);
        
    
    axis('equal')
    axis([0 1 0 1]);
    set(gca,'xtick',[0 0.5 1]);
    set(gca,'ytick',[0 0.5 1]);
    set(gca,'FontSize',12);
    drawnow;
    