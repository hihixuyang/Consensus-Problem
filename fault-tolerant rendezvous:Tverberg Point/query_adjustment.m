function [adjustment] = query_adjustment(n,ntotal,nf,p,ptotal,fp,r,Neighbor,delta,t)
    proposalTarget = query_proposalNextMove(n,ntotal,nf,p,ptotal,fp,r,Neighbor,delta,t);
    adjustment = [];
    for i = 1:n
        W = zeros(size(Neighbor{i},2),1);
        for j = 1: size(Neighbor{i},2)
            %if j <= n
                d = sqrt((proposalTarget(i,1)-proposalTarget(Neighbor{i}(j),1)).^2+(proposalTarget(i,2)-proposalTarget(Neighbor{i}(j),2)).^2);
                if d <= r
                    W(j) = 1;
                end
            %end
        end
        if W == ones(size(Neighbor{i},2),1)
            adjustment(i,:) = proposalTarget(i,:);
        else
            adjustment(i,:) = p(i,:)+1./2*(proposalTarget(i,:)-p(i,:));
        end
    end 
end