function [my_segmentation] = segment_by_clustering( rgb_image, feature_space, clustering_method, threshold_hminima, number_of_clusters)

% Where
% rgb_image : input image in rgb
% feature_space : 'rgb', 'lab', 'hsv', 'rgb+xy', 'lab+xy', 'hsv+xy'
% clustering_method = k-means, gmm, hierarchical or watershed (code seen in class).
% threshold_hminima = threshold to cut the cluster tree generated in 
% hierarchical clustering or the h minima for introducing new markers with
% extended regional image in watershed (only valid for hierarchical 
% or watershed method clustering)
% number_of_clusters = number of clusters for k-means and gmm methods;

% The output of the function should be a image (or matrix) where each pixel 
% has a cluster label.

% ----CODE STARTS HERE----
% Verify if the clustering method is hierarchical. 
% In case it is, the image has to be reduced two times and then its color
% should be changed.

if strcmp(clustering_method,'hierarchical') == 1
    image_in_red1 = impyramid(rgb_image,'reduce');
    image_in_red2 = impyramid(image_in_red1,'reduce');
    image_in=image_in_red2;
    lwd=size(image_in);
    
else 
    image_in=rgb_image;
    lwd=size(image_in);
    threshold=0;
    
end 
   
%Changing color
%From RGB to RGB
if strcmp(feature_space,'rgb') == 1
    im_color = image_in;
    im_matrix = pixels_reorganize(image_in);
    
%From RBG to Lab
elseif  strcmp(feature_space,'lab') == 1
    im_color = RGB2Lab(image_in);
    im_matrix = pixels_reorganize(im_color);
    
%From RBG to HSV
elseif strcmp(feature_space,'hsv') == 1
    im_color = rgb2hsv(image_in);
    im_matrix = pixels_reorganize(im_color);

%From RBG to RGB+XY
elseif strcmp(feature_space,'rgb+xy') == 1
    im_color = image_in;
    im_matrix = pixels_reorganize_xy(rgb_image);

%From RBG to Lab+XY    
elseif strcmp(feature_space,'lab+xy') == 1
    im_color=RGB2Lab(image_in);
    im_matrix = pixels_reorganize_xy(im_color);
    
%From RBG to HSV+XY
elseif strcmp(feature_space,'hsv+xy') == 1
    im_color=rgb2hsv(image_in);
    im_matrix = pixels_reorganize_xy(im_color);
    
end


%Segmentation by clustering
%K-means 'EmptyAction','singleton'
if  strcmp(clustering_method,'k-means') == 1
    v_clust_out = kmeans(im_matrix,number_of_clusters,'MaxIter',1000);
    im_clust_out = reshape(v_clust_out,[lwd(1),lwd(2)]);
    my_segmentation = im_clust_out;
    
%GMM
elseif strcmp(clustering_method,'gmm') == 1
    gmm = gmdistribution.fit(im_matrix,number_of_clusters,'MaxIter',1000);
    v_clust_out = cluster(gmm,im_matrix);
    im_clust_out = reshape(v_clust_out,[lwd(1),lwd(2)]);
    my_segmentation = im_clust_out;
    
%Hierarchical
elseif strcmp(clustering_method,'hierarchical') == 1 
    %Threshold definition
    threshold = threshold_hminima;
    
    distance = pdist(im_matrix);
    tree = linkage(distance);
    v_clust_out = cluster(tree,'cutoff',threshold);
    im_clust_out = reshape(v_clust_out,[lwd(1),lwd(2)]);
    im_clust_out_exp1 = impyramid(im_clust_out,'expand'); 
    im_clust_out_exp2 = impyramid(im_clust_out_exp1,'expand');
    my_segmentation = im_clust_out_exp2;
    
%Watershed
elseif strcmp(clustering_method,'watershed') == 1 
    hy = fspecial('sobel');
    hx = hy';
    Iy = imfilter(double(im_color), hy, 'replicate');
    Ix = imfilter(double(im_color), hx, 'replicate');
    grad = sqrt(Ix.^2 + Iy.^2);
    
    
    %Extended regional minima
    h_minima = threshold_hminima;
    markers = imextendedmin(grad,h_minima);
    ngrad = imimposemin(grad,markers);
    my_segmentation = watershed(ngrad);
   
end  

% plot the result in a subplot with the original image
% figure;
% subplot(2,1,1); 
% image(image_in);
% subplot(2,1,2);
% image(my_segmentation);
% colormap colorcube;

end


