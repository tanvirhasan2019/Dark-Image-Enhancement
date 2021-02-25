function [ ret ] = sharp( im )
%GaussKernel=fspecial('gaussian',5,3);
GaussKernel=fspecial('gaussian',25,22);
im=im2double(im);
imBlur=imfilter(im,GaussKernel);
unSharpMask=im-imBlur;
stretchIm=hisStretching(unSharpMask);
ret=(im+stretchIm)/2;
end

