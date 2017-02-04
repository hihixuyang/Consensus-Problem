function[]=show_graph(p,n,nf,fp,ptotal,ntotal,r)
    % A is the adjacency matrix associated with the system using a disk graph. 
    A = query_adjacency(ptotal,ntotal,r);  
    figure(1);
    hold off;

    for i=1:n
      for j=1:ntotal
        if (A(i,j)==1);
          plot([ptotal(i,1),ptotal(j,1)],[ptotal(i,2),ptotal(j,2)],'color',[0.5 0.5 0.5]);
          hold on;
        end
      end
    end
    for i = 1:n
      plot(p(i,1),p(i,2),'o','LineWidth',1,...            
                'MarkerEdgeColor','k',...     
                'MarkerFaceColor','g',...     
                'MarkerSize',10);
           
      hold on;
    end

    
    for i=1:nf
      plot(fp(i,1),fp(i,2),'o','LineWidth',1,...            
                'MarkerEdgeColor','k',...     
                'MarkerFaceColor','r',...     
                'MarkerSize',10);
             
      hold on;
    end
    
    axis('equal')
    axis([0 1 0 1]);
    set(gca,'xtick',[0 1]);
    set(gca,'ytick',[0 1]);
    set(gca,'FontSize',16);
    xlabel('X');ylabel('Y'); 
    drawnow;
end
