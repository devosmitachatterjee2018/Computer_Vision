function [best_inlier_indices, best_H] = ransac_homography(x1,x2)
%RANSAC PLANE outputs the plane fit to the 3D points, given using ransac
%algorithm
max_iter = 10e5;
no_of_selected_points = 4;
best_H = zeros(3,3);
max_inliers = -inf;
best_inlier_indices = zeros(1,size(x1,2));
for i=1:1:max_iter
    
    selected_indices = randperm(size(x1,2), no_of_selected_points);
    H = compute_homography(x1(:,selected_indices),x2(:,selected_indices));
    x2_h = pflat(H*x1);
    inliers_indices = vecnorm(x2_h-x2,2,1) <= 5;
    no_inliers = sum(inliers_indices);
    if no_inliers > max_inliers
        best_H = H;
        max_inliers = no_inliers;
        best_inlier_indices = inliers_indices;
    end   
    
end

end