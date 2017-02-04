
%% system parameters
clear;close;clc
n = 30; % number of fault-free robots
nf = 16; % number of faulty robots
ntotal = n + nf; % total number of robots
d = 2; % dimension
p = rand(n,d); % generate n fault-free robots in R^d
r=0.71; % sensing range
%fp = rand(nf,d); % generate nf faulty robots
%fp = [0.3+0.4*rand(nf,1),0.3+0.4*rand(nf,1)];  %在图中间产生敌方的attack model

% first attack model
%fp1 = [0.3+0.2*rand(nf/4,1),0.5+0.2*rand(nf/4,1)];fp2 = [0.3+0.2*rand(nf/4,1),0.3+0.2*rand(nf/4,1)];fp3 = [0.5+0.2*rand(nf/4,1),0.3+0.2*rand(nf/4,1)];fp4 = [0.5+0.2*rand(nf/4,1),0.5+0.2*rand(nf/4,1)];
% second attack model
fp1 = [0.1*rand(nf/4,1),rand(nf/4,1)];fp2 = [0.9+0.1*rand(nf/4,1),rand(nf/4,1)];fp3 = [0.1+0.8*rand(nf/4,1),0.1*rand(nf/4,1)];fp4 = [0.1+0.8*rand(nf/4,1),0.9+0.1*rand(nf/4,1)];

fp = [fp1;fp2;fp3;fp4];
%fp = [0.8+0.2*rand(nf,1),0.8+0.2*rand(nf,1)]; 
%fp = [0.1,0.1; 0.9,0.9];
ptotal = [p;fp]; % total robots matrix
delta = 0.01; % compact degree of the convergence

%% simulation parameters
dt=0.1; % numerical steplength
Tf=2; % final time
t=0; 
iter=1;

while (t<=Tf);                      
%% Plot the solution every 10 iterations
  if (mod(iter,1)==0);
    show_graph(p,n,nf,fp,ptotal,ntotal,r);
  end
  grid on;
  
  M(iter) = getframe;
  if iter==1
    [I,map]=rgb2ind(M(iter).cdata,256);
    imwrite(I,map,'out.gif','DelayTime',1)
  else
    imwrite(rgb2ind(M(iter).cdata,map),map,'out.gif','WriteMode','append','DelayTime',1)
  end
  
  iter=iter+1;
  Neighbor = query_neighbors(n,ntotal,p,ptotal,r);
  
%% get each fault-free robot's next move (after collection,proposal and adjustment phase)
  adjustment = query_adjustment(n,ntotal,nf,p,ptotal,fp,r,Neighbor,delta,t);
  %adjustment = query_nextMove(n,ntotal,p,ptotal,fp,r);

  for i=1:n
      p(i,:) = adjustment(i,:);
  end
  % update Faulty Robots
  %[fp,fp1,fp2,fp3,fp4] = firstAttackModel(fp1,fp2,fp3,fp4,iter);
  [fp,fp1,fp2,fp3,fp4] = secondAttackModel(fp1,fp2,fp3,fp4);
  ptotal = [p;fp];
 
%% Update time 
  %save_figure(t);
    t=t+dt;
end
movie2avi(M,'out2.avi')

        
            
        