function [best_inlier_indices, best_plane] = ransac_plane(X)
%RANSAC PLANE outputs the plane fit to the 3D points, given using ransac
%algorithm
max_iter = 10;
no_of_selected_points = 3;
X = pflat(X);
best_plane = zeros(1,4);
max_inliers = -inf;
best_inlier_indices = zeros(1,size(X,2));
for i=1:1:max_iter
    selected_indices = randperm(size(X,2), no_of_selected_points);
    plane = null(X(:,selected_indices)');
    plane = plane./norm(plane(1:3));
    inliers_indices = abs(plane'*X) <= 0.1;
    no_inliers = sum(inliers_indices);
    if no_inliers > max_inliers
        best_plane = plane;
        max_inliers = no_inliers;
        best_inlier_indices = inliers_indices;
    end   
    
end

end
