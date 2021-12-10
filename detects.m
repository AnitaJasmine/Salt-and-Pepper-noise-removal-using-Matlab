function [estmd]=detects(A)
[m n]=size(A);
A=uint8(A);
clear pix;
clear Abs_mtx;
pix=A(2 ,2);
 k=1;
 b=zeros(1,9);
%---- CALCULATING ABSOLUTE DIFFERENCE---
for i=1:3
    for j=1:3
        if pix==255
            dif=minus(pix,A(i,j));
            Abs_mtx(i,j)=abs(dif);
            b(k)=abs(dif);
            k=k+1;
        else if pix==0  
            dif=minus(A(i,j),pix);
            Abs_mtx(i,j)=abs(dif);
            b(k)=abs(dif);
            k=k+1;
            end
        end
    end
end

%---SORTING ABSOLUTE DIFFERENCE VALUES IN ASCENDING ORDER---
for i=1:9
    for j=1:9
        if(b(i)<b(j))
            
            t=b(i);
            b(i)=b(j);
            b(j)=t;
        end
    end
end

%---CALCULATING MEAN ROAD VALUE  let m=4----
 sum=0;
for i=2:6
    sum=sum+b(i);
end

%---DETECTING & ESTIMATING PIXEL VALUE REPLACING IMPULSE PIXEL VALUE---
n=0;   
%---DETECTING IMPULSE---
 i=1;   j=1;    k=1;    
         estmd1=A(i+1,j+1);
          if (sum>25) 
             for i=1:3
                 for j=1:3
                        if pix==255
                            if~((abs(A(2,2)-A(i,j))==0) |( abs(A(2,2)-A(i,j))==255))
                                total_sum(k)=A(i,j);
                                k=k+1;
                                n=n+1;
                            end
                            else if pix==0
                             if~((abs(A(i,j)-A(2,2))==0) |( abs(A(i,j)-A(2,2))==255))
                                total_sum(k)=A(i,j);
                                k=k+1;
                                n=n+1;
                             end
                        end
                    end
                 end
               
             end
             tot_sum=0;
             k=k-1; tot_sum= cast(tot_sum,'uint16');
             for i=1:k
                no= cast(total_sum(i),'uint16'); 
                tot_sum=tot_sum+no;
             end
             if~(n==0)
                 estmd1=tot_sum/n;
             else
                 estmd1=(A(1,1)+A(1,2)+A(1,3)+A(2,1)+A(2,3)+A(3,1)+A(3,2)+A(3,3))/8;
             end
          end
          estmd=uint8(estmd1);
end    
        