function [est_img]=roadtech(im_original,value)
org_img=imresize(im_original,0.2);
noise_img=imnoise(org_img,'salt & pepper',value);
[m n]=size(noise_img); 
for i=2:m-1
    a=i-1;
        b=i+1;
        c=1;
        d=3;
    for j=2:n-1
            A=noise_img(a:b,c:d);
            estmd=detects(A);
            est_img1(i,j)=uint8(estmd);
            clear A;
            c=c+1;
            d=d+1;
             
    end
end
est_img=est_img1;




