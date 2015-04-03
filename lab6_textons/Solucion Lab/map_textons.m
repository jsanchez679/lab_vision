%No. 1
addpath('lib')
addpath('datos_mat')
addpath('textures/train')
clear all;close all;clc;

load num.mat
load imageFiles_txt.mat

% create filter bank with the 25 images of different categories
% fbCreate: Create a filterbank containing numOrient even and odd-symmetric
% filters and one center-surround filter at numScales scales.
[fb] = fbCreate;

directory = 'textures/train';
Name = dir(fullfile(directory,'*.jpg'));
l_Name = length(Name);

% imagenes de referencia para construir diccionario de textones
num_Cat = 25;
% num = zeros(num_Cat,1);
% 
% for i = 1:num_Cat
%     N = randi([30*(i-1)+1 30*i],1,1);
%     num(i,1) = N;
% end 

%%

for i = 1:num_Cat
    imageFiles_txt{i} = fullfile(directory, Name(num(i)).name);
    im_new{i} = double(imread(imageFiles_txt{i}))/255;
end

row1= im_new{1};
row2= im_new{6};
row3= im_new{11};
row4= im_new{16};
row5= im_new{21};

for i = 2:5
    row1f= horzcat(row1,im_new{i});
    row1=row1f;
    
    row2f= horzcat(row2,im_new{i+5});
    row2=row2f;
    
    row3f= horzcat(row3,im_new{i+10});
    row3=row3f;
    
    row4f= horzcat(row4,im_new{i+15});
    row4=row4f;
    
    row5f= horzcat(row5,im_new{i+20});
    row5=row5f;
end

im = vertcat(row1f,row2f,row3f,row4f,row5f);
figure()
imshow(im)

%%
%figure();imshow (im)
% numero de textones en diccionario/número de clusters
k = 50;

% diccionario de textones

% fbRun:Run a filterbank (fb) on an array of images (im) with reflected boundary conditions.
% computeTextons:Corre k-means de las imágenes filtradas con el filterbank (fb) y 
% arroja la imagen (map: mapa de textones) con los k clusters que se obtiene de k-means.
% textons: posicion de los centroides de los clusters

fbRun_im=fbRun(fb,im);
[map,textons] = computeTextons(fbRun_im,k);

figure;imshow(map,[]);colormap(jet);
figure;imagesc(textons);colormap(jet);
xlabel('Filter No')
ylabel('Cluster No')


%%
size_fbRun=size(fbRun_im);
l_size_fbRun=size_fbRun(1);
h_size_fbRun=size_fbRun(2);

sum_filter_im=zeros(l_size_fbRun,h_size_fbRun);
for i=1:l_size_fbRun
    for j=1:h_size_fbRun
        sum_filter_im(i,j)=sumsqr(fbRun_im{i,j});
    end
end

filter_ans=vertcat(sum_filter_im(:,1),sum_filter_im(:,2));
figure;
bar(1:1:32,filter_ans);
xlabel('No. Filtro')
ylabel('Suma de Cuadrados')


%%
addpath('datos_mat')
load textons.mat
load imageFiles_train.mat

for i = 1:l_Name
    imageFiles_train{i} = fullfile(directory, Name(i).name);
    im_new_train{i} = double(imread(imageFiles_train{i}))/255;
end

%texton maps de las imágenes de entrenamiento
for i=1:l_Name
    im2=double(im_new_train{i});
    tmap = assignTextons(fbRun(fb,im2),textons');
    
    Hist(:,i) = histc(tmap(:),1:k)/numel(tmap);
    
    for i= 10 || 40 || 70 || 110 || 140
        figure;imshow(tmap,[]);colormap(jet);
        figure;bar(histc(tmap(:),1:k)/numel(tmap));
        drawnow;
    end 
end
