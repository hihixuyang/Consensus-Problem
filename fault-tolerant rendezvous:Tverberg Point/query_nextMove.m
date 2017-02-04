function [nextMove] = query_nextMove(n,ntotal,p,ptotal,fp,r)
    % find the neighbors of each robot, and get the Tverberg Point for each
    % fault-free robot.
    nextMove = [];
    for i = 1:n
        N_i = [];
        for j = 1:ntotal
            d = sqrt((p(i,1)-ptotal(j,1)).^2+(p(i,2)-ptotal(j,2)).^2);
            if d <= r         
               N_i = [N_i;ptotal(j,:)];
            end
        end     
        [tvb_pnt] = tvb(N_i);
        nextMove = [nextMove; p(i,:) + 0.5*(tvb_pnt-p(i,:))];
    end
    nextMove = [nextMove;fp]; 

end