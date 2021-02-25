function ret = GreenCompensate( im, w )
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
%padb = padarray(b,padsize,'symmetric','both');

ret=im;
for i=1:height
    for j=1:width
        slider = padr(i:i+w-1,j:j+w-1);
        slideg = padg(i:i+w-1,j:j+w-1);
       % slideb = padb(i:i+w-1,j:j+w-1);
        rm=mean(mean(slider));
        gm=mean(mean(slideg));
       % bm=mean(mean(slideb));
        
        tem=g(i,j)+1.5*(gm-rm)*(1-r(i,j))*r(i,j);
        
        tem=tem*255;
        tem=uint8(tem);
        ret(i, j, 2)=tem;
    end
end


end

