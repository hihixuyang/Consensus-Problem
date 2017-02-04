function[A]=query_adjacency(ptotal,ntotal,r)

    %% Computes the adjacency matrix for the disk graph
    A=zeros(ntotal,ntotal);
    for i=1:ntotal
      for j = 1:ntotal
        d = sqrt((ptotal(i,1)-ptotal(j,1)).^2+(ptotal(i,2)-ptotal(j,2)).^2);
        if (i~=j && d <= r)   % Check for proximity
          A(i,j)=1;    
        end
      end
    end
end
