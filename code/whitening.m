clear all

%�����õ�һ��ͼ���в���������gammaУ�������ݱ�����input1.mat���񻯵����ݱ�����input2.mat��
im = imread('1.jpg');
subplot(2,4,1);
imshow(im);
xlabel('origin image');

% ͼ���һ��
im = hisStretching(im);
subplot(2,4,2)
imshow(im);
xlabel('normalization');

% ��ɫͨ������
im1 = redCompensate(im);
subplot(2,4,3)
imshow(im1);
xlabel('red channel compensate')

% ��ɫͨ�����䣬�ڻ���ˮ����߸�ˮλ���߸�������Ĵ������ڣ�������ɫͨ��˥��ǿ��ʱ������ɫͨ�����в���
%im1 = blueCompensate(im1);
%subplot(2,4,4)
%imshow(im1);
%xlabel('blue channel compensate')

% �Ҷ�����任
im2 = grayWorld(im1);
subplot(2,4,5)
imshow(im2);
xlabel('gray world')

% ٤��У��
im3 = gammaCorrection(im2,1,0.6);
subplot(2,4,6)
imshow(im3);
xlabel('gamma correction');
save('input1.mat','im3');

% ��
im4 = sharp(im2);
subplot(2,4,7)
imshow(im4);
xlabel('sharp')
save('input2.mat','im4');


