function [fp,fp1,fp2,fp3,fp4]= secondAttackModel(fp1,fp2,fp3,fp4)
    for i = 1:size(fp1,1)
        if fp1(i,2)>=0.5 && fp1(i,2)<=0.9
            fp1(i,2) = fp1(i,2) + 0.1;
        elseif fp1(i,2)<0.5 && fp1(i,2)>=0.1
            fp1(i,2) = fp1(i,2) - 0.1;
        end
    end
    for i = size(fp1,1)+1:size([fp1;fp2],1)
        if fp2(i-size(fp1,1),2)>=0.5 && fp2(i-size(fp1,1),2)<=0.9
            fp2(i-size(fp1,1),2) = fp2(i-size(fp1,1),2) + 0.1;
        elseif fp2(i-size(fp1,1),2) < 0.5 && fp2(i-size(fp1,1),2)>=0.1
            fp2(i-size(fp1,1),2) = fp2(i-size(fp1,1),2) - 0.1;
        end       
     end
     for i = size([fp1;fp2],1)+1:size([fp1;fp2;fp3],1)
        if fp3(i-size([fp1;fp2],1),1)>=0.5 && fp3(i-size([fp1;fp2],1),1)<=0.9
            fp3(i-size([fp1;fp2],1),1) = fp3(i-size([fp1;fp2],1),1) + 0.1;
        elseif fp3(i-size([fp1;fp2],1),1) < 0.5 && fp3(i-size([fp1;fp2],1),1)>=0.1
            fp3(i-size([fp1;fp2],1),1) = fp3(i-size([fp1;fp2],1),1) - 0.1;
        end       
     end
     for i = size([fp1;fp2;fp3],1)+1:size([fp1;fp2;fp3;fp4],1)
        if fp4(i-size([fp1;fp2;fp3],1),1)>=0.5 && fp4(i-size([fp1;fp2;fp3],1),1)<=0.9
            fp4(i-size([fp1;fp2;fp3],1),1) = fp4(i-size([fp1;fp2;fp3],1),1) + 0.1;
        elseif fp4(i-size([fp1;fp2;fp3],1),1)<0.5 && fp4(i-size([fp1;fp2;fp3],1),1)>=0.1
            fp4(i-size([fp1;fp2;fp3],1),1) = fp4(i-size([fp1;fp2;fp3],1),1) - 0.1;
        end       
     end
    fp = [fp1;fp2;fp3;fp4];