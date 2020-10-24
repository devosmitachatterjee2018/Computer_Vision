clearvars;
clc;
close all;
addpath('assignment4data/')
load('compEx1data.mat')
im{1} = imread('house1.jpg');
im{2} = imread('house2.jpg');

%%
X = pflat(X);

% SOLVING WITH TOTAL LEAST SQUARES
plane_tls = get_estimated_plane(X);

rms_tls = compute_rms_error(X,plane_tls);


% SOLVING WITH RANSAC
[best_inlier_indices,plane_ransac] = ransac_plane(X);

rms_ransac = compute_rms_error(X,plane_ransac);


% SOLVING WITH ONLY INLIERS
plane_tls_inliers = get_estimated_plane(X(:,best_inlier_indices));
rms_tls_inliers = compute_rms_error(X,plane_tls_inliers);

%%
figure
dist_ransac = abs(plane_ransac'*X);
histogram(dist_ransac, 100)
title('Histogram for RANSAC inliers')


figure
dist_tls_inliers = abs(plane_tls_inliers'*X);
histogram(dist_tls_inliers, 100)
title('Histogram for tls inliers')



figure;
for i=1:length(im)
    subplot(1,2,i)
    imagesc(im{i})
    hold on;
    proj_plane = pflat(P{i}*X(:,best_inlier_indices));
    plot(proj_plane(1,:),proj_plane(2,:),'.')
    legend('projected points on the plane')
    
end


%%
%Estimating homography
x_img = {};
% Normalizing cameras
x_img{1} = x;
P{1} = inv(K)*P{1};
P{2} = inv(K)*P{2};
H_normalization = vertcat([inv(P{1}(:,1:3)),- inv(P{1}(:,1:3))*P{1}(:,4)],...
    [zeros(1,3),1]);
P_n{1} = P{1}*H_normalization;
P_n{2} =P{2}*H_normalization;
R2 = P_n{2}(:,1:3);
t2 = P_n{2}(:,end);
%N = comp_norm_mat(X(1:4,:));
plane_ransac = pflat(plane_ransac);
%plane_ransac_n = plane_ransac(1:4);
H = R2-(t2*(plane_ransac(1:3)'));
x_img{2} = pflat(K*H*inv(K)*x_img{1});

figure;

for i=1:2
    
    subplot(1,2,i)
    imagesc(im{i})
    hold on;
    proj_plane = pflat(K*P{i}*X(:,best_inlier_indices));
    plot(proj_plane(1,:),proj_plane(2,:),'*', 'MarkerSize', 8)
    plot(x_img{i}(1,:),x_img{i}(2,:),'*','MarkerSize', 8)
    legend('projected points on the plane', 'extra annotated points')
    
end
title('transformed using Homography')