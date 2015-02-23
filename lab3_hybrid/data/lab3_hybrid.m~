clc 
close all
clear all

%(close)-high pass filter
Im1=imread('plane.bmp');
%(far)-low pass filter
Im2=imread('bird.bmp');

% figure()
% subplot(1,2,1)
% imshow(Im1)
% title('Image 1')
% subplot(1,2,2)
% imshow(Im2)
% title('Image 2')

filt_low=fspecial('gaussian',[12,12],12);
filt_high=fspecial('gaussian',[35,35],30);
m=1.2;
Im1_high1=m*Im1-imfilter(Im1,filt_high);
Im2_low1=imfilter(Im2,filt_low);

% figure()
% subplot(1,2,1)
% imshow(Im1_high1)
% title('high-pass(Image 1)')
% subplot(1,2,2)
% imshow(Im2_low1)
% title('low-pass(Image 2)')

fft_Im1=fft2(double(Im1));
fft_Im2=fft2(double(Im2));
fft_filt_low=fft2(filt_low);
fft_filt_high=fft2(filt_high);
fft_Im1_high1=fft2(double(Im1_high1));
fft_Im2_low1=fft2(double(Im2_low1));

% figure()
% subplot(2,3,1)
% imshow(fft_Im1)
% title('fft2(Image 1)')
% subplot(2,3,2)
% imshow(fft_Im2)
% title('fft2(Image 2)')
% subplot(2,3,3)
% imshow(fft_filt_low)
% title('fft2(low pass filter)')
% subplot(2,3,6)
% imshow(fft_filt_high)
% title('fft2(high pass filter)')
% subplot(2,3,4)
% imshow(fft_Im1_high1)
% title('fft2(high-pass(Image 1))')
% subplot(2,3,5)
% imshow(fft_Im2_low1)
% title('fft2(low-pass(Image 2))')


Im1_gray = rgb2gray(Im1);
Im2_gray = rgb2gray(Im2);
Im1_high1_gray = rgb2gray(Im1_high1);
Im2_low1_gray = rgb2gray(Im2_low1);


Im1_gray_J = dct2(Im1_gray);
Im2_gray_J = dct2(Im2_gray);
filt_low_J = dct2(filt_low);
filt_high_J = dct2(filt_high);
Im1_high1_gray_J = dct2(Im1_high1_gray);
Im2_low1_gray_J = dct2(Im2_low1_gray);


figure()
subplot(2,3,1)
imshow(log(abs(Im1_gray_J)),[]), colormap(jet(64))
title('dct2(Image 1)')
subplot(2,3,2)
imshow(log(abs(Im2_gray_J)),[]), colormap(jet(64))
title('dct2(Image 2)')
subplot(2,3,3)
imshow(log(abs(filt_low_J)),[]), colormap(jet(64))
title('dct2(low pass filter)')
subplot(2,3,6)
imshow(log(abs(filt_high_J)),[]), colormap(jet(64))
title('dct2(high pass filter)')
subplot(2,3,4)
imshow(log(abs(Im1_high1_gray_J)),[]), colormap(jet(64))
title('dct2(high-pass(Image 1))')
subplot(2,3,5)
imshow(log(abs(Im2_low1_gray_J)),[]), colormap(jet(64))
title('dct2(low-pass(Image 2))')


ImF=Im1_high1+Im2_low1;
imwrite(ImF,'Hybrid.png')

figure()
subplot(2,3,1)
imshow(Im1)
title('Image 1')
subplot(2,3,2)
imshow(Im2)
title('Image 2')
subplot(2,3,4)
imshow(Im1_high1)
title('high-pass(Image 1)')
subplot(2,3,5)
imshow(Im2_low1)
title('low-pass(Image 2)')
subplot(2,3,6)
imshow(ImF)
title('Image Final - Hybrid')

print ('-dpng','panel_hybrid.png')

%% Pyramid
close all
clc 

Im1_0=ImF;
Im1_1=impyramid(Im1_0,'reduce');
Im1_2=impyramid(Im1_1,'reduce');
Im1_3=impyramid(Im1_2,'reduce');
Im1_4=impyramid(Im1_3,'reduce');
Im1_5=impyramid(Im1_4,'reduce');

figure()
subplot(1,4,1)
imshow(Im1_0)
subplot(1,4,2)
imshow(Im1_1)
subplot(1,4,3)
imshow(Im1_2)
subplot(1,4,4)
imshow(Im1_3)

print ('-dpng','hybrid_pyramid.png')

