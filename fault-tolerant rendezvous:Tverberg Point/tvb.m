function [tvb_pnt] = tvb(p)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtain Tverberg point Tverberg partition of maximum depth w/ 1D/2D/3D points
% tvb.m
% Coded by Hyongju Park (park334@illinois.edu, hyongju@gmail.com)
% Date: Apr 15, 2015
% Based upon the paper W.Mulzer and D. Werner, titled
% "Approximating Tverberg points in Linear Time for Any Fixed Dimension"
% Input: set of n points in 1D/2D/3D  (n times d matrix)
% format:
%       p = [x1 y1 z1;
%            x2 y2 z2;
%            ...
%            xn yn zn]
% Output: Tverberg point/partition of depth ceil(n/2^d) 
%       out1: a Tverberg point
%       out2: Tverberg partition
% 0.75:     initial release
% 0.95 Sep, 2, 2015 : bugs are fixed 

d = size(p,2);

if size(p,1)==1
    tvb_pnt = [p(1,1) p(1,2)];
elseif size(p,2)==2
    tvb_pnt = [(p(1,1)+p(2,1))/2 (p(1,2)+p(2,2))/2];
elseif size(p,2)==3 
    tvb_pntx = (p(1,1)+p(2,1)+p(3,1))/3;
    tvb_pnty = (p(1,2)+p(2,2)+p(3,2))/3;
    tvb_pnt = [tvb_pntx tvb_pnty];
else
    switch(d)

        case 1  % d = 1, this is simply a median of a set of points 
    %%
            [B,IX] = sort(p(:,1)); % sort
            sB = size(B,1); % size of the array
            size1 = floor(sB/2); % floor
            % Obtain Tverberg partition (1D) with depth ceil(n / 2)
            for i=1:size1          
                tvb_prt{i} = p([IX(i) IX(sB-i+1)],:); % a pair in each group
            end
            if mod(sB,2) == 1       % if the number of points is ODD
            % there is a group with a single point
                tvb_prt{i+1} = p(IX(i+1),:); % singleton
            end
            % Obtain Tverberg point (1D) with depth ceil(n / 2) == median
            tvb_pnt = median(B); % obtain median -----> Tverberg point       

        case 2  % d = 2
    %%      
            sumX=0;
            sumY=0;
            [B,IX] = sort(p(:,1)); % sort 
            sB = size(B,1); % size of the array
            if sB < 4
                for i=1:sB
                    sumX = sumX + p(i,1);
                    sumY = sumY + p(i,2);
                end
                mean_X = sumX ./ sB;
                mean_Y = sumY ./ sB;
                tvb_pnt = [mean_X, mean_Y];
            end

            size1 = floor(sB/2); % floor
            % Obtain Tverberg partition (1D) with depth ceil(n / 2)
            for i=1:size1
                tver{i} = [IX(i) IX(sB-i+1)]; % a pair in each group
            end
            if mod(sB,2) == 1
                tver{i+1} = IX(i+1); % if the number of points is ODD
            % there is a group with a single point
            end
            % Obtain Tverberg point (1D) with depth ceil(n / 2) == median
            tverp = median(B); % obtain median -----> Tverberg point: X coordinate   
            sT = size(tver,2); % size of partition (1D)
            % lifting to 2D
            for i = 1:sT
               tst_pnt{i} =p(tver{i},1:2); % for each group with up to 2 points
               if size(tst_pnt{i},1) == 1
                   tver2(i) = tst_pnt{i}(1,2); % if it is a singleton take the value
               else
                   if tst_pnt{i}(1,1) == tst_pnt{i}(2,1) % exclude slope at infinite
                       tver2(i) = mean(tst_pnt{i}(:,2));
                   else
                       lineq = polyfit(tst_pnt{i}(:,1),tst_pnt{i}(:,2),1);
                       tver2(i) = lineq(1)*tverp + lineq(2);
                       % find the intersection with the horizontal line
                   end
               end
            end
            [~,IX2] = sort(tver2);
            sB2 = size(IX2,2);
            size2 = floor(sB2/2);
            for i=1:size2
                tver3{i} = [IX2(i) IX2(sB2-i+1)];
            end
            if mod(sB2,2) == 1
                tver3{i+1} = IX2(i+1);
            end
            tverp2 = median(tver2); % tverberg point: Y coordinate
            tvb_pnt = [tverp tverp2]; % tverberg point
            for i = 1:size(tver3,2)
                if size(tver3{i},2) == 1
                    tvb_prt{i} = tst_pnt{tver3{i}};
                else
                    tvb_prt{i} = [tst_pnt{tver3{i}(1)};tst_pnt{tver3{i}(2)}];
                end
            end        

        case 3  % d = 3  
    %%
            [B,IX] = sort(p(:,1)); % sort
            sB = size(B,1); % size of the array
            size1 = floor(sB/2); % floor
            % Obtain Tverberg partition (1D) with depth ceil(n / 2)
            for i=1:size1
                tver{i} = [IX(i) IX(sB-i+1)]; % two elements
            end
            if mod(sB,2) == 1
                tver{i+1} = IX(i+1); % singleton
            end
            % Obtain Tverberg point (1D) with depth ceil(n / 2) == median
            tverp = median(B); % obtain median
            sT = size(tver,2); % size of partition (1D)

            % lifting to 2D
            for i = 1:sT
               tst_pnt{i} =p(tver{i},1:2);
    %            tst_pnt{i}
               if size(tst_pnt{i},1) == 1
                   tver2(i) = tst_pnt{i}(1,2);
               else
                   if tst_pnt{i}(1,1) == tst_pnt{i}(2,1)
                       tver2(i) = mean(tst_pnt{i}(:,2));
                   else
                       lineq = polyfit(tst_pnt{i}(:,1),tst_pnt{i}(:,2),1);
                       tver2(i) = lineq(1)*tverp + lineq(2);
                   end
               end

            %    clear tst_pnt;
            end
            [~,IX2] = sort(tver2);
            sB2 = size(IX2,2);
            size2 = floor(sB2/2);
            for i=1:size2
                tver3{i} = [IX2(i) IX2(sB2-i+1)];
                tver4{i} = [tver{IX2(i)} tver{IX2(sB2-i+1)}];
            end
            if mod(sB2,2) == 1
                tver3{i+1} = IX2(i+1);
                tver4{i+1} = tver{IX2(i+1)};
            end
            tverp2 = median(tver2);
            tver_pnt = [tverp tverp2];
            for i = 1:size(tver3,2)
                if size(tver3{i},2) ==1
                    tverf{i} = tst_pnt{tver3{i}};
                else
                    tverf{i} = [tst_pnt{tver3{i}(1)};tst_pnt{tver3{i}(2)}];
                end
            end
            sT2 = size(tver4,2); % size of Tverberg partition (2D)
            % lifting to 3D
            for i = 1:sT2
    %             tver4{i}
                pl1 = p(tver4{i},:);
    %             pl1
    %             rank(pl1(:,1:2))
                [~,ia,ic] = unique(pl1(:,1:2),'rows');
    %             unique(pl1(:,1:2),'rows')
                tst_pnt2{i} = pl1(ia,:);
    %             ia
    %             tst_pnt2{i}
                for q1 = 1:size(tst_pnt2{i},1)
                   tmp3 = find(ic == q1);
                   if size(tmp3,1) >=2
                       tst_pnt2{i}(q1,:) = mean(pl1(tmp3,:),1);
                   end
                end
    %             tst_pnt2{i} = unique(p(tver4{i},:),'rows');
                if size(tst_pnt2{i},1) == 1 || rank(pl1(ia,1:2)) ==1
                    tver5(i) = tst_pnt2{i}(1,3);
                    tver7(i) = tst_pnt2{i}(1,3);
                elseif size(tst_pnt2{i},1) == 2 || rank(pl1(ia,1:2)) ==2

                tver5(i) = (tver_pnt(2)-tst_pnt2{i}(1,2))/(tst_pnt2{i}(2,2)-tst_pnt2{i}(1,2)) *...
                    (tst_pnt2{i}(2,3)-tst_pnt2{i}(1,3))+tst_pnt2{i}(1,3);
                tver7(i) = (tver_pnt(2)-tst_pnt2{i}(1,2))/(tst_pnt2{i}(2,2)-tst_pnt2{i}(1,2)) *...
                    (tst_pnt2{i}(2,3)-tst_pnt2{i}(1,3))+tst_pnt2{i}(1,3);    
                else

                   [A,b,~,~]=vert2lcon(tst_pnt2{i});
                        b1 = b- A(:,1:2)*tver_pnt';
                        g = inline('x');
                        g1 = inline('-x');
                        options = optimset('Algorithm','interior-point','Display','off');
                        tver5(i) = fmincon(g,0,A(:,3),b1,[],[],[],[],[],options);
                        tver7(i) = fmincon(g1,0,A(:,3),b1,[],[],[],[],[],options);
                end
            % linear programming problem
            end
            tver6 = mean([tver5;tver7]);
            tverp3 = median(tver6);
            tvb_pnt = [tverp tverp2 tverp3];
            [~,IX4] = sort(tver6);
            sB3 = size(IX4,2);
            size3 = floor(sB3/2);

            for i=1:size3
                tverB1(i,:) = [IX4(i) IX4(sB3-i+1)];
                tverB2{i} = [tver4{IX4(i)} tver4{IX4(sB3-i+1)}];
            end
            if mod(sB3,2) == 1
                tverB1(i+1,:) = IX4(i+1);
                tverB2{i+1} = tver4{IX4(i+1)};
            end
            sT3 = size(tverB2,2); % size of partition (2D)
            % lifting to 3D
            for i = 1:sT3
                tvb_prt{i} = p(tverB2{i},:);
            end

    end
end