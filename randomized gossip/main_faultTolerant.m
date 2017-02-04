clear; close all; clc
K = 50; % No. of consensus instance
iter = 500; % No. of iterations
n = 8;
nf = 1;
n_total = n + nf;
Adjacency = ...
  [1 1 1 1 0 0 1 0 0;
   1 1 1 0 1 0 0 1 0;
   1 1 1 0 0 1 0 0 1;
   1 0 0 1 1 1 1 0 0;
   0 1 0 1 1 1 0 1 0;
   0 0 1 1 1 1 0 0 1;
   1 0 0 1 0 0 1 1 1;
   0 1 0 0 1 0 1 1 1;
   0 0 1 0 0 1 1 1 1;];
Adjacency = Adjacency - eye(9);
createBiograph(Adjacency,n,nf)
rng('default');
x_f = zeros(K,nf);
x = zeros(K,n);
x_total = zeros(K,n_total);
x_start = x_total;
   
for k = 1:K
    decay = -1;
    x_f(k,:) = 0.1*rand(nf,1); 
    x(k,:) = randn(n,1);
    x_total(k,:) = [x(k,:) x_f(k,:)];
    x_start(k,:) = x_total(k,:);
    for t = 1:iter
        i = randi([1,n_total],1);
        neighbor = find(Adjacency(i,:)~=0);
        j = neighbor(randi([1,size(neighbor,2)],1));
        temp = (x_total(k,i)+x_total(k,j))/2;
        x_total(k,i) = temp;
        if j > n
            x_total(k,j) = 0.1*rand*exp(decay);
            decay = decay - 1;
        else
            x_total(k,j) = temp;
        end
        
%         if mod(t,20)==0
%             plot_graph(reshape(x_total(k,:,:),n_total,2),n,n_total)
            
%         end
    end 
end

%% Neighborhood Detection Task
e = 1/K * sum(abs(x_total - x_start))';
e_bar = zeros(n,1);
H1 = zeros(n,1);
for i = 1:n
    e_bar(i) = 1/size(find(Adjacency(i,:)~=0),2) * Adjacency(i,:)*e;
    for j = 1:n_total
        if Adjacency(i,j)~=0
            H1(i) = H1(i) + abs(e(j)-e_bar(i));
        end
    end
end   
fault_neighbor = find(H1>0.6);
fault = [];

%% Localization Task
for i=1:length(fault_neighbor)
    for j = 1:n_total
        if Adjacency(fault_neighbor(i),j)~=0
            if e(j) < 0.25
                fault = [fault j];
                Adjacency(fault_neighbor(i),j) = 0;
                Adjacency(j,fault_neighbor(i)) = 0;
            end
        end
    end
end

createBiograph(Adjacency,n,nf)


    
        
    