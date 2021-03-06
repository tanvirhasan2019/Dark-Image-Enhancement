clear all


A = imread('car_input.jpg');


%Histogram for input Image 1
image_test=A;
red_plane=image_test(:,:,1);
green_plane=image_test(:,:,2);
blue_plane=image_test(:,:,3);
[red_data pixel_level]=imhist(red_plane);
[green_data pixel_level]=imhist(green_plane);
[blue_data pixel_level]=imhist(blue_plane);
bar(pixel_level, red_data,'r');
hold on;
bar(pixel_level, green_data,'g');
bar(pixel_level, blue_data,'b');


% INPUT IMAGE SHOW
figure, imshow(A), title('input image');
AInv = imcomplement(A);
figure, imshow(AInv), title('imcomplement 1');


%Histogram for Image complement 2
image_test=AInv;
red_plane=image_test(:,:,1);
green_plane=image_test(:,:,2);
blue_plane=image_test(:,:,3);
[red_data pixel_level]=imhist(red_plane);
[green_data pixel_level]=imhist(green_plane);
[blue_data pixel_level]=imhist(blue_plane);
bar(pixel_level, red_data,'r');
hold on;
bar(pixel_level, green_data,'g');
bar(pixel_level, blue_data,'b');



BInv = imreducehaze(AInv);
figure, imshow(BInv), title('imreducehaze 1');


%Histogram for Image Reduce Haze 3
image_test=BInv;
red_plane=image_test(:,:,1);
green_plane=image_test(:,:,2);
blue_plane=image_test(:,:,3);
[red_data pixel_level]=imhist(red_plane);
[green_data pixel_level]=imhist(green_plane);
[blue_data pixel_level]=imhist(blue_plane);
bar(pixel_level, red_data,'r');
hold on;
bar(pixel_level, green_data,'g');
bar(pixel_level, blue_data,'b');






gray_rgb = BInv;

B = imcomplement(BInv);
figure, montage({A, B}), title('input image  vs imcomplement 2');

BInv = imreducehaze(AInv, 'Method','approx','ContrastEnhancement','boost');
BImp = imcomplement(BInv);
figure, montage({A, BImp}), title('input image  vs imcomplement 3');

imwrite(BImp,'ContrastEnhancement output.jpg');

imGray = grayWorld(BImp);

figure,imshow(imGray), title('GRAY WORLD');
imwrite(imGray,'Contrast Graywworld output.jpg');


%Histogram for Gray World  4
image_test=imGray;
red_plane=image_test(:,:,1);
green_plane=image_test(:,:,2);
blue_plane=image_test(:,:,3);
[red_data pixel_level]=imhist(red_plane);
[green_data pixel_level]=imhist(green_plane);
[blue_data pixel_level]=imhist(blue_plane);
bar(pixel_level, red_data,'r');
hold on;
bar(pixel_level, green_data,'g');
bar(pixel_level, blue_data,'b');




gm_2 = gammaCorrection(imGray,1,.5);
imwrite(gm_2,'ContrastEnhancement AFTER GAMMA COR output.jpg');



%Histogram for Gamma Correction  5
image_test=gm_2;
red_plane=image_test(:,:,1);
green_plane=image_test(:,:,2);
blue_plane=image_test(:,:,3);
[red_data pixel_level]=imhist(red_plane);
[green_data pixel_level]=imhist(green_plane);
[blue_data pixel_level]=imhist(blue_plane);
bar(pixel_level, red_data,'r');
hold on;
bar(pixel_level, green_data,'g');
bar(pixel_level, blue_data,'b');



im4 = sharp(imGray);
figure, imshow(im4), title('SHARPE from ContrastEnhancement output');
imwrite(im4,'sharp 1.jpg');




%Histogram for sharepening 6
image_test=im4;
red_plane=image_test(:,:,1);
green_plane=image_test(:,:,2);
blue_plane=image_test(:,:,3);
[red_data pixel_level]=imhist(red_plane);
[green_data pixel_level]=imhist(green_plane);
[blue_data pixel_level]=imhist(blue_plane);
bar(pixel_level, red_data,'r');
hold on;
bar(pixel_level, green_data,'g');
bar(pixel_level, blue_data,'b');



im5 = sharp(A);
figure, imshow(im5), title('SHARPE from gamma output');
imwrite(im5,'sharp 2.jpg');








%GRAY SCALE TO RGB
%{
clc;    % Clear the command window.
format longg;
format compact;
fontSize = 14;
% Change the current folder to the folder of this m-file.
if(~isdeployed)
  cd(fileparts(which(mfilename)));
end
  
% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
  % User does not have the toolbox installed.
  message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
  reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
  if strcmpi(reply, 'No')
    % User said No, so exit.
    return;
  end
end
% Read in a standard MATLAB color demo image.
folder = fullfile(matlabroot, '\toolbox\images\imdemos');
baseFileName = '2.jpg';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
  % Didn't find it there.  Check the search path for it.
  fullFileName = baseFileName; % No path this time.
  if ~exist(fullFileName, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
rgbImage = imread(fullFileName);
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows , columns , numberOfColorBands] = size(rgbImage);
% Display the original color image.
handleToFigure = figure();
subplot(2, 2, 1);
imshow(rgbImage, []);
title('Original Color Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
uiwait(msgbox('Pick a color that you would like to make the image into.'));
[x , y] = ginput(1);
% Plot cross hairs at that point.
hold on;
plot(x, y, 'w+', 'MarkerSize', 50);
% Convert the image into hsv space.
hsv = rgb2hsv(rgbImage);
row = int32(y);
column = int32(x);
selectedPixelRGB = rgbImage(row, column, :);
hsvOfThisPixel = rgb2hsv(selectedPixelRGB);
% Make the hue plane of the hsv image this same hue
hsv(:, :, 1) = hsvOfThisPixel(1);
% Convert back to rgb space.
singleHueRGBImage = hsv2rgb(hsv);
% Just for fun, show the red, green, and blue channels.
% Extract the individual red, green, and blue color channels.
redChannel = singleHueRGBImage(:, :, 1);
greenChannel = singleHueRGBImage(:, :, 2);
blueChannel = singleHueRGBImage(:, :, 3);

%3 CHANNEL OUTPUT IMAGE
imwrite(redChannel,'RED CHANNEL output.jpg');
imwrite(greenChannel,'GREEN CHANNEL output.jpg');
imwrite(blueChannel,'BLUE CHANNEL output.jpg');

subplot(4, 3, 7);
imshow(redChannel);
title('Red Channel Image', 'FontSize', fontSize);
subplot(4, 3, 8);
imshow(greenChannel);
title('Green Channel Image', 'FontSize', fontSize);
subplot(4, 3, 9);
imshow(blueChannel);
title('Blue Channel Image', 'FontSize', fontSize);
% Just for fun, show the hue, saturation, and value channels.
% Extract the individual hue, saturation, and value channels.
hueChannel = hsv(:, :, 1);
saturationChannel = hsv(:, :, 2);
valueChannel = hsv(:, :, 3);


imwrite(hueChannel,'HUE CHANNEL output.jpg');
imwrite(saturationChannel,'SATURATION CHANNEL output.jpg');
imwrite(valueChannel,'VALUE CHANNEL output.jpg');


subplot(4, 3, 10);
imshow(hueChannel);
title('New, Uniform Hue Channel Image', 'FontSize', fontSize);
subplot(4, 3, 11);
imshow(saturationChannel, []);

title('Saturation Channel Image', 'FontSize', fontSize);
subplot(4, 3, 12);
imshow(valueChannel, []);
title('Value Channel Image', 'FontSize', fontSize);
% Display the new, single hue color image.
subplot(2, 2, 2);
imshow(singleHueRGBImage);
title('New, Single Hue Color Image', 'FontSize', fontSize);
message = sprintf('Done with demo.\n\nFor the pixel at x = %d, y = %d,', column, row);
message = sprintf('%s\nthe (R, G, B) of the pixel = (%d, %d, %d), and', ...
  message, selectedPixelRGB(1), selectedPixelRGB(2), selectedPixelRGB(3));
message = sprintf('%s\nthe Hue of the pixel = %f', message, hsvOfThisPixel(1));
uiwait(msgbox(message));
% See if they want to do it for a grayscale image.
promptMessage = sprintf('Do you want to Continue processing a gray scale image,\nor Cancel to abort processing?');
titleBarCaption = 'Continue?';
button = questdlg(promptMessage, titleBarCaption, 'Continue', 'Quit', 'Continue');
if strcmp(button, 'Quit')
  return;
end
% Now let's do it to a gray scale image.
% Read in a standard MATLAB gray scale demo image.
folder = fullfile(matlabroot, '\toolbox\images\imdemos');
baseFileName = '2.jpg';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
  % File doesn't exist -- didn't find it there.  Check the search path for it.
  fullFileName = baseFileName; % No path this time.
  if ~exist(fullFileName, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
grayImage = imread(fullFileName);
handleToFigure2 = figure;
subplot(2,2,1);
imshow(grayImage);
title('Gray Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Convert the gray image into RGB so we can get it into hsv space.
rgbImage = cat(3, grayImage, grayImage, grayImage);
hsv = rgb2hsv(rgbImage);
% Make the hue plane of the hsv image this same hue
hsv(:, :, 1) = hsvOfThisPixel(1);
% Make the saturation 1 so we'll see color.
% Originally it was zero which meant that the image would be gray.
hsv(:, :, 2) = 1;
% Convert back to rgb space.
singleHueRGBImage = uint8(255*hsv2rgb(hsv));
% Display the new, single hue color image.
subplot(2, 2, 2);
imshow(singleHueRGBImage);
title('New, Single Hue Color Image', 'FontSize', fontSize);
message = sprintf('Done with demo.');
uiwait(msgbox(message));
% Close the figure.
% close(handleToFigure);  % Close all figures (except those of imtool.)
% close(handleToFigure2);  % Close all figures (except those of imtool.)














%{
A = imread('2.jpg');
AInv = imcomplement(A);
[BInv, TInv] = imreducehaze(AInv, 'Method', 'approxdcp', 'ContrastEnhancement', 'none');
T = imcomplement(TInv);
figure,
subplot(1,2,1);
imshow(A), title('Lowlight Image');
subplot(1,2,2);
imshow(T), title('Illumination Map');
colormap(gca, hot(256));
% 红色通道补充
%{
im1 = redCompensate(im,5);
%imBlue = blueCompensate(im1); %blue color compensate
subplot(2,2,1)
imshow(im1);
xlabel('red channel compensate')
imwrite(im1,'red channel output after correction.jpg');
%}

% 蓝色通道补充，在浑浊水域或者高水位或者浮游生物的大量存在，导致蓝色通道衰减强烈时，对蓝色通道进行补充
%im1 = blueCompensate(im1);
%subplot(2,3,3)
%imshow(im1);
%xlabel('blue channel compensate')


伽马校正
im3 = gammaCorrection(im1,1,.5);
subplot(2,2,3)
imshow(im3);
xlabel('gamma correction');
%save('input1.mat','im3');
imwrite(im3,'result7_gamma.jpg');


% 灰度世界变换
x1 = 1500;
y1 = 1028;
gray_val = [im3(y1,x1,1) im3(y1,x1,2) im3(y1,x1,3)];
B = chromadapt(im3,gray_val);
subplot(2,2,2)
imshow(B,'InitialMagnification',25)
%title('White-Balanced Image')
xlabel('white balance')
imwrite(B,'white_balance_output.jpg');



% 锐化 SHARPENING CODE
im4 = sharp(im3);
subplot(2,2,4)
imshow(im4);
xlabel('sharp')
%save('input2.mat','im4');
imwrite(im4,'result7_input2.jpg');



%I=imread('autumn.tif'); 
%HISTOGRAM COLOR

R=imhist(im(:,:,1)); 
G=imhist(im(:,:,2)); 
B=imhist(im(:,:,3)); 
figure
plot(R,'r') 
hold on, 
plot(G,'g') 
plot(B,'b')
legend(' Red channel','Green channel','Blue channel');
hold off
%}

%}





