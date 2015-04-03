
addpath('lib')
clear all;close all;clc;

% create filter bank

% fbCreate: Create a filterbank containing numOrient even and odd-symmetric
% filters and one center-surround filter at numScales scales.
[fb] = fbCreate;


% imagen de referencia para construir diccionario de textones
im1=double(rgb2gray(imread('9_1_s.bmp')))/255;
im2=double(rgb2gray(imread('6_1_s.bmp')))/255;
%figure();imshow (im1)
%figure();imshow (im2)

%Creates an image with im1 and im2 side by side
im = [im1 im2];

%figure();imshow (im)
% numero de textones en diccionario/número de clusters
k = 50;

% diccionario de textones

% fbRun:Run a filterbank (fb) on an array of images (im) with reflected boundary conditions.
% computeTextons:Corre k-means de las imágenes filtradas con el filterbank (fb) y 
% arroja la imagen (map: mapa de textones) con los k clusters que se obtiene de k-means.
% textons: posicion de los centroides de los clusters 
[map,textons] = computeTextons(fbRun(fb,im),k);

figure;imshow(map,[]);colormap(jet);

D=dir('*.bmp');
%texton maps de dos nuevas imagenes
for i=1:numel(D),
    im2=double(rgb2gray(imread(D(i).name)))/255;
    tmap = assignTextons(fbRun(fb,im2),textons');
    
    % la distribucion de textones en la oveja deberia ser similar a la de la
    % imagen de referencia.
    figure;subplot(1,2,1);imshow(tmap,[]);colormap(jet);
    subplot(1,2,2);bar(histc(tmap(:),1:k)/numel(tmap));
    drawnow;
end

