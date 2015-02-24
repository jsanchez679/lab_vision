function my_segmentation = segment_by_clustering( rgb_image, feature_space, clustering method, number of clusters)

% Where
% feature_space : 'rgb', 'lab', 'hsv', 'rgb+xy', 'lab+xy', 'hsv+xy'
% clustering_method = k-means, gmm, hierarchical or watershed (code seen in class).
% The output of the function should be a image (or matrix) where each pixel has a cluster label.

image_in=imread(rgb_image);

if  strcmp(feature_space,'lab') == 1
    im_color=RGB2Lab(image_in);
    im_matrix = pixels_reorganize(im_color);
    
elseif strcmp(feature_space,'hsv') == 1 
    im_color=rgb2hsv(image_in);
    im_matrix = pixels_reorganize(im_color);
    
elseif strcmp(feature_space,'rgb+xy') == 1 
    im_matrix = pixels_reorganize_xy(rgb_image);
    
elseif strcmp(feature_space,'lab+xy') == 1 
    im_color=RGB2Lab(image_in);
    im_matrix = pixels_reorganize_xy(im_color);
    
elseif strcmp(feature_space,'hsv+xy') == 1 
    im_color=rgb2hsv(image_in);
    im_matrix = pixels_reorganize_xy(im_color);
        
end  
        

end
