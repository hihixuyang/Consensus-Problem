function [Neighbor] = query_neighbors(n,ntotal,p,ptotal,r)
    Neighbor = cell(n,1);
    for i = 1:n
        neighb = [];
        for j = 1:ntotal
            d = sqrt((p(i,1)-ptotal(j,1)).^2+(p(i,2)-ptotal(j,2)).^2);
            if d <= r         
                neighb = [neighb,j];
            end
        end
        Neighbor{i} = neighb;
    end
end