function ret = redCompensate( im, w )
r=im(:,:,1);
g=im(:,:,2);
b=im(:,:,3);
r=im2double(r);
g=im2double(g);
b=im2double(b);
[height,width,~]=size(im);
padsize=[(w-1)/2,(w-1)/2];
padr = padarray(r,padsize,'symmetric','both');
padg = padarray(g,padsize,'symmetric','both');
padb = padarray(b,padsize,'symmetric','both');

ret=im;
for i=1:height
    for j=1:width
        slider = padr(i:i+w-1,j:j+w-1);
        slideg = padg(i:i+w-1,j:j+w-1);
        slideb = padb(i:i+w-1,j:j+w-1);
        rm=mean(mean(slider));
        gm=mean(mean(slideg));
        bm=mean(mean(slideb));
        
        tem=r(i,j)+1.2*(gm-bm)*(1-b(i,j))*g(i,j)+1.2*(bm-gm)*(1-g(i,j))*b(i,j);
        
        tem=tem*255;
        tem=uint8(tem);
        ret(i, j, 1)=tem;
    end
end


end

