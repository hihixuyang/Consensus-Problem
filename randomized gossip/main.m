clear; close all; clc
n = 10;
nf = 10;
n_total = n + nf;
r = 0.5;
decay = -1;
rng('default');
x_f = 0.1*randn(nf,2); %when attackers choose an coordinated point, attack sometimes succeeds, sometimes fails.
% when nf larger enough, attack succeeds.(n = 50, nf = 10 succeeds)
%x_f = rand(nf,2); %when attackers choose an arbitrary next move, the attack succeeds
x = rand(n,2);
x_total = [x;x_f];
iter = 1;
plot_graph(x_total,n,n_total)

Adjacency = zeros(n,n_total);
for i = 1:n
    for j = 1:n_total
        if norm(x(i,:)-x_total(j,:))<=r
            Adjacency(i,j) = 1;
        end
    end
end

while iter < 3000
    i = randi([1,n],1);
    neighbor = find(Adjacency(i,:)~=0);
    j = neighbor(randi([1,size(neighbor,2)],1));
    temp = (x_total(i,:)+x_total(j,:))/2;
    x_total(i,:) = temp;
    if j > n
        x_total(j,:) = 0.1*randn(1,2)*exp(decay);
        %x_total(j,:) = rand(1,2);
        decay = decay - 1;
    else
        x_total(j,:) = temp;
    end
    Adjacency(i,:) = getAdjacency(x_total,n_total,r,i);
    if j <= n
        Adjacency(j,:) = getAdjacency(x_total,n_total,r,j);
    end
    
    iter = iter + 1;
    if mod(iter,100)==0
        plot_graph(x_total,n,n_total)
        pause(0.2)
    end
end
    
    
    
        
    