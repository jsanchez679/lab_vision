%No. 2
clear all;
close all;
clc;

addpath('lib')
addpath('datos_mat')
addpath('textures/test')

load Hist.mat
load textons.mat
load fb.mat

% create filter bank with the 25 images of different categories
% fbCreate: Create a filterbank containing numOrient even and odd-symmetric
% filters and one center-surround filter at numScales scales.
%[fb] = fbCreate;

k=50;
num_Cat = 25;
Hist_train25=zeros(50,25);

for i=1:num_Cat
    for j=1:50
    Hist_train25(j,i)=mean(Hist(j,1+30*(i-1):30*i));
    end
end

%save Hist_train25.mat      % command form

%%
directory = 'textures/test';
Name = dir(fullfile(directory,'*.jpg'));
l_Name = length(Name);

for i = 1:l_Name
    imageFiles_test{i} = fullfile(directory, Name(i).name);
    im_new_test{i} = double(imread(imageFiles_test{i}))/255;
end

%texton maps de dos nuevas imagenes

for i=1:l_Name
    im2_test=double(im_new_test{i});
    tmap_test = assignTextons(fbRun(fb,im2_test),textons');
    
    Hist_test(:,i) = histc(tmap_test(:),1:k)/numel(tmap_test);
end

% save imageFiles_test.mat      % command form
% save Hist_test.mat      % command form

