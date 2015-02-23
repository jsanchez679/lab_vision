clc 
close all
%% Introduction

im1=imread('5.1.12.tiff');
A=size(im1);
im2=imread('4.2.03.tiff');
B=size(im2);

figure()
subplot(1,2,1)
image(im2);
subplot(1,2,2)
imshow(im2);

imwrite(im2,'Mico.png')
imwrite(im2,'Mico.jpg')

%% Changing .tiff to .jpg

A=dir('*.tiff');
l=size(A);
h=l(1);

for i=1:h
    name=A(i).name;
    IMAGE=imread(name);
    name2=name(1:end-5);
    imwrite(IMAGE,[name2,'.jpg'])
end

%% Adding noise

im1x=imnoise(im2,'gaussian',0.05,0.2);
V=ones(size(im2));
im2x=imnoise(im2,'localvar',V);
im3x=imnoise(im2,'poisson');
im4x=imnoise(im2,'salt & pepper');
im5x=imnoise(im2,'speckle');

figure()
subplot(2,3,1)
imshow(im2)
xlabel('original')
subplot(2,3,2)
imshow(im1x)
xlabel('gaussian')
subplot(2,3,3)
imshow(im2x)
xlabel('localvar')
subplot(2,3,4)
imshow(im3x)
xlabel('poisson')
subplot(2,3,5)
imshow(im4x)
xlabel('salt & pepper')
subplot(2,3,6)
imshow(im5x)
xlabel('speckle')

imwrite(im1x,'Im1_a.png')
imwrite(im2x,'Im1_b.png')
imwrite(im3x,'Im1_c.png')
imwrite(im4x,'Im1_d.png')
imwrite(im5x,'Im1_e.png')

imwrite(im1x,'Im1_a.jpg')
imwrite(im2x,'Im1_b.jpg')
imwrite(im3x,'Im1_c.jpg')
imwrite(im4x,'Im1_d.jpg')
imwrite(im5x,'Im1_e.jpg')

%% Mean and Median Filter

im1x=imnoise(im1,'gaussian',0.05,0.2);
V=ones(size(im1));
im2x=imnoise(im1,'localvar',V);
im3x=imnoise(im1,'poisson');
im4x=imnoise(im1,'salt & pepper');
im5x=imnoise(im1,'speckle');


%Mean filter
filtx=fspecial('average');
outim1x=imfilter(im1x,filtx);
outim2x=imfilter(im2x,filtx); 
outim3x=imfilter(im3x,filtx); 
outim4x=imfilter(im4x,filtx); 
outim5x=imfilter(im5x,filtx);

%Median filter
outim1y=medfilt2(im1x);
outim2y=medfilt2(im2x); 
outim3y=medfilt2(im3x); 
outim4y=medfilt2(im4x); 
outim5y=medfilt2(im5x);

figure ()
subplot(3,5,1)
imshow(im1x)
ylabel('Original')
subplot(3,5,2)
imshow(im2x)
subplot(3,5,3)
imshow(im3x)
subplot(3,5,4)
imshow(im4x)
subplot(3,5,5)
imshow(im5x)

subplot(3,5,6)
imshow(outim1x)
ylabel('Mean Filter')
subplot(3,5,7)
imshow(outim1y)

subplot(3,5,8)
imshow(outim2x)
subplot(3,5,9)
imshow(outim2y)

subplot(3,5,10)
imshow(outim3x)
subplot(3,5,11)
imshow(outim3y)
ylabel('Median Filter')
xlabel('gaussian')

subplot(3,5,12)
imshow(outim4x)
xlabel('localvar')
subplot(3,5,13)
imshow(outim4y)
xlabel('poisson')

subplot(3,5,14)
imshow(outim5x)
xlabel('salt & pepper')
subplot(3,5,15)
imshow(outim5y)
xlabel('speckle')

%% Mean filter different sizes

% filt0x=fspecial('average');
% filt1x=fspecial('average',[4 4]);
% filt2x=fspecial('average',[5 5]);
% filt3x=fspecial('average',[6 6]);
% filt4x=fspecial('average',[7 7]);
% filt5x=fspecial('average',[8 8]);
% 
% outim0z=imfilter(im4x,filt0x);
% outim1z=imfilter(im4x,filt1x);
% outim2z=imfilter(im4x,filt2x);
% outim3z=imfilter(im4x,filt3x);
% outim4z=imfilter(im4x,filt4x);
% outim5z=imfilter(im4x,filt5x);

% %Median filter
outim0z=medfilt2(im4x);
outim1z=medfilt2(im4x,[4 4]);
outim2z=medfilt2(im4x,[5 5]); 
outim3z=medfilt2(im4x,[6 6]); 
outim4z=medfilt2(im4x,[7 7]); 
outim5z=medfilt2(im4x,[8 8]);

figure ()
subplot(2,3,1)
imshow(outim0z)
title('Trying different filter sizes')
xlabel('3x3')
subplot(2,3,2)
imshow(outim1z)
xlabel('4x4')
subplot(2,3,3)
imshow(outim2z)
xlabel('5x5')
subplot(2,3,4)
imshow(outim3z)
xlabel('6x6')
subplot(2,3,5)
imshow(outim4z)
xlabel('7x7')
subplot(2,3,6)
imshow(outim5z)
xlabel('8x8')


%% Blur

%Gaussian vs Average filter

im_gm=imread('4.2.01.tiff');
filtg1=fspecial('gaussian');
filtg2=fspecial('gaussian',[9 9]);
outim1g=imfilter(im_gm,filtg1);
outim2g=imfilter(im_gm,filtg2);

filtm1=fspecial('average');
filtm2=fspecial('average',[9 9]);
outim1m=imfilter(im_gm,filtm1);
outim2m=imfilter(im_gm,filtm2);

figure()
subplot(2,3,1)
imshow(im_gm)
title('original')
subplot(2,3,2)
imshow(outim1g)
title('gaussian 3x3')
subplot(2,3,3)
imshow(outim2g)
title('gaussian 9x9')

subplot(2,3,5)
imshow(outim1m)
title('average 3x3')
subplot(2,3,6)
imshow(outim2m)
title('average 9x9')

%% Sharpen

im_sh=imread('5.1.12.tiff');
outim_sh1=imsharpen(im_sh,'Radius',2,'Amount',1);
outim_sh2=imsharpen(outim1m,'Radius',2,'Amount',1);
outim_sh3=imsharpen(outim2m,'Radius',2,'Amount',1);


figure()
subplot(2,3,1)
imshow(im_sh)
title('original')
subplot(2,3,2)
imshow(outim_sh1)
title('sharpened')
subplot(2,3,4)
imshow(outim1m)
title('blurred')
subplot(2,3,5)
imshow(outim_sh2)
title('sharpened (average filter 3x3)')
subplot(2,3,6)
imshow(outim_sh3)
title('sharpened (average filter 9x9)')

%% Edge detection

im_edge=imread('5.1.11.tiff');
edge1=fspecial('laplacian');
edge2=fspecial('log');
edge3=fspecial('prewitt');
edge3v=edge3';
edge4=fspecial('sobel');
edge4v=edge4';

outim_ed1=imfilter(im_edge,edge1);
outim_ed2=imfilter(im_edge,edge2);
outim_ed3=imfilter(im_edge,edge3);
outim_ed3v=imfilter(im_edge,edge3v);
outim_ed4=imfilter(im_edge,edge4);
outim_ed4v=imfilter(im_edge,edge4v);

figure()
subplot(2,4,1)
imshow(im_edge)
title('original')
subplot(2,4,2)
imshow(outim_ed1)
title('laplacian')
subplot(2,4,6)
imshow(outim_ed2)
title('log')
subplot(2,4,3)
imshow(outim_ed3)
title('prewitt-h')
subplot(2,4,4)
imshow(outim_ed3v)
title('prewitt-v')
subplot(2,4,7)
imshow(outim_ed4)
title('sobel-h')
subplot(2,4,8)
imshow(outim_ed4v)
title('sobel-v')

%% Color Spaces

img_rgb=imread('4.2.03.tiff');
r = img_rgb(:,:,1);
g = img_rgb(:,:,2);
b = img_rgb(:,:,3);

figure()
subplot(2,2,1);
subimage(img_rgb);
title('original')
subplot(2,2,2);
subimage(r);
title('R')
subplot(2,2,3);
subimage(g);
title('G')
subplot(2,2,4);
subimage(b);
title('B')

print ('-dpng','rgb_mosaic.png');

img_ycbcr=rgb2ycbcr(img_rgb);
img_lab=RGB2Lab(img_rgb);
img_hsv=rgb2hsv(img_rgb);

figure()
subplot(2,2,1)
subimage(img_rgb);
title('Original')
subplot(2,2,2);
subimage(img_ycbcr);
title('YCBCR');
subplot(2,2,3);
subimage(img_lab);
title('Lab');
subplot(2,2,4); 
subimage(img_hsv);
title('HSV')

print ('-dpng','colorspaces_mosaic.png');


%% Pyramid

img_pyr=imread('5.1.12.tiff');

pyr1=impyramid(img_pyr,'reduce');
pyr2=impyramid(pyr1,'reduce');
pyr3=impyramid(pyr2,'reduce');
pyr4=impyramid(pyr3,'reduce');
pyr5=impyramid(pyr4,'reduce');
pyr6=impyramid(pyr5,'reduce');

figure()
subplot(2,4,1)
imshow(img_pyr)
title('original')
subplot(2,4,2)
imshow(pyr1)
title('pyramid 1')
subplot(2,4,3)
imshow(pyr2)
title('pyramid 2')
subplot(2,4,4)
imshow(pyr3)
title('pyramid 3')
subplot(2,4,5)
imshow(pyr4)
title('pyramid 4')
subplot(2,4,6)
imshow(pyr5)
title('pyramid 5')
subplot(2,4,7)
imshow(pyr6)
title('pyramid 6')

%% Template matching

image=imread('motion04.512.tiff');
figure()
imshow(image)
%comand to crop the train at the right side of the figure
[train,square] = imcrop(image);

c=normxcorr2(train,image);
% c is correlation from -1 to 1
[sx,sy] = size(image);
d=floor(size(train)/2);
dx=d(1);
dy=d(2);
%Remove borders from c2 to make it the same size as image
c2=c(dx+1:sx+dx,dy+1:sy+dy);
%lets accentuate it more
c3=c2.^3;
%convert it into an image from 0 to 1
cr=0.5+0.5*c3;
%leave the original image as the luminance channel
y=mat2gray(image);
%empty cb channel
cb=0.5*ones(size(image));
%join the three channels
ycbcr=cat(3,y,cb,cr);
figure()
imshow(ycbcr)
rgb=ycbcr2rgb(ycbcr);
figure()
imshow(rgb);


image_n=imread('motion05.512.tiff');
c_n=normxcorr2(train,image_n);
%Remove borders from c2 to make it the same size as image
c2_n=c_n(dx+1:sx+dx,dy+1:sy+dy);
%lets accentuate it more
c3_n=c2_n.^3;
%convert it into an image from 0 to 1
cr_n=0.5+0.5*c3_n;
%leave the original image as the luminance channel
y_n=mat2gray(image_n);
%empty cb channel
cb_n=0.5*ones(size(image_n));
%join the three channels
ycbcr_n=cat(3,y_n,cb_n,cr_n);
figure()
imshow(ycbcr_n)
title('Final YCbCr')
rgb_n=ycbcr2rgb(ycbcr_n);
figure()
imshow(rgb_n);
title('Final RGB')
