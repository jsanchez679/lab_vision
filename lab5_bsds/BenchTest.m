clc;
clear all;
close all; 

% Using the test dataset to test the function

% Extracting the names from all the *.jpg files. 
directory = 'BSDS500/data/images/test';
Name = dir(fullfile(directory,'*.jpg'));
l_Name = length(Name);

% No of clusters to be created by each method. 
Nclust = [2,5,8,10];
l_Nclust = length(Nclust);

%m=5;

%K-means
for i = 1:l_Name
    imagen_km = i
    for k = 1:l_Nclust
        imageFiles{i} = fullfile(directory, Name(i).name);
        images{i} = imread(imageFiles{i});
        [pathstr,name{i},ext] = fileparts(imageFiles{i});
        
        segs{1,k} = segment_by_clustering(images{i},'rgb','k-means',0,Nclust(k));
        Name_out = strcat(name{i},'.mat');
        directory_out = 'print_results/k-means';
        save(fullfile(directory_out,Name_out),'segs')
        No_clust = Nclust(k)
        %close all
    end
    
end

%GMM
for i = 1:l_Name
    imagen_gmm = i
    for k = 1:l_Nclust
        imageFiles{i} = fullfile(directory, Name(i).name);
        images{i} = imread(imageFiles{i});
        [pathstr,name{i},ext] = fileparts(imageFiles{i});
        
        segs{1,k} = segment_by_clustering(images{i},'rgb','gmm',0,Nclust(k));
        Name_out = strcat(name{i},'.mat');
        directory_out = 'print_results/gmm';
        save(fullfile(directory_out,Name_out),'segs')
        No_clust = Nclust(k)
        %close all
    end
    
end
