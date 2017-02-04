function [proposalTarget] = query_proposalNextMove(n,ntotal,nf,p,ptotal,fp,r,Neighbor,delta,t)
    nextMove = query_nextMove(n,ntotal,p,ptotal,fp,r);
    argminDist = [];
    proposalTarget = [];
    if t>=1.2
        delta_1 = delta;
    else
        delta_1 = 0.01;
    end
    for i=1:n
        argminDist(i) = sqrt((nextMove(i,1)-p(i,1)).^2+(nextMove(i,2)-p(i,2)).^2);
        proposalTarget(i,:) = p(i,:);
        for x = 0:delta_1:1    
            for y = 0:delta_1:1
                W = zeros(size(Neighbor{i},2),1);
                for j = 1:size(Neighbor{i},2)
                    d = sqrt((x-ptotal(Neighbor{i}(j),1)).^2+(y-ptotal(Neighbor{i}(j),2)).^2);
                    if d <= r
                        W(j)=1;
                    end
                end
                if W==ones(size(Neighbor{i},2),1)
                    dist = sqrt((nextMove(i,1)-x).^2+(nextMove(i,2)-y).^2);
                    if dist <= argminDist(i)
                        argminDist(i) = dist;
                        proposalTarget(i,:) = [x,y];
                    end
                end
            end
        end
    end
    proposalTarget = [proposalTarget;fp];
end