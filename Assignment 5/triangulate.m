function [X_3D] = triangulate(P,x1_n,x2_n)
%TRIANGULATE triangulates the points by solving triangulation dlt and
%outputs the 3D points
no_of_points = length(x1_n);
X_3D = zeros(4,no_of_points);
for i=1:1:no_of_points
    A = set_dlt_triangulation(P,x1_n(:,i),x2_n(:,i));
    [U,S,V] = svd(A);
    X_3D(:,i) = V(:,end); 
end
end
