
clc
close all 

im=imread('6046.jpg');
my_segmentation = segment_by_clustering(im,'rgb','k-means',1,10);

% 
% figure()
% subplot(2,1,1)
% image(im)
% subplot(2,1,2)
% image(my_segmentation)
% colormap (colorcube);





