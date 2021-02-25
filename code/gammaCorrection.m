function [ res ] = gammaCorrection( im,a,gamma )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

im = im2double(im);
r=im(:,:,1);
g=im(:,:,2);
b=im(:,:,3);

res_r = a *(r .^ gamma);
res_g = a *(g .^ gamma);
res_b = a *(b .^ gamma);

res(:,:,1) = res_r;
res(:,:,2) = res_g;
res(:,:,3) = res_b;


end

