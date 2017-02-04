function neighbor = getAdjacency(x_total,n_total,r,i)
    neighbor = zeros(1,n_total);
    for j = 1:n_total
        if norm(x_total(i,:)-x_total(j,:))<=r
            neighbor(1,j) = 1;
        end
    end
