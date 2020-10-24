%%
clearvars
close all
clc
addpath('C:\Users\Acer\Desktop\Computer Vision Algorithms\Assignment 4\assignment4data');
im{1} = imread('a.jpg');
im{2} = imread('b.jpg');

%%

[f, d, x_n] = deal({});
for i=1:length(im)
    [f{i} d{i}] = vl_sift( single(rgb2gray(im{i})) );
end
matches = vl_ubcmatch(d{1},d{2});

for i=1:1:2
    x{i} = f{i}(1:2,matches(i,:));
    x{i} = insert_ones(x{i});
end

[best_inlier_indices, best_H]= ransac_homography(x{1},x{2});

%best_H = compute_homography(x_n{1},x_n{2});
x_h{2} = pflat(best_H*x{1});
x_h{1} = pflat(inv(best_H)*x{2});

figure
for i=1:1:length(im)
    subplot(1,length(im), i)
    imagesc(im{i})
    hold on
    plot(x{i}(1,~best_inlier_indices), x{i}(2,~best_inlier_indices),'+')
    plot(x{i}(1,best_inlier_indices), x{i}(2,best_inlier_indices),'m+')
    plot(x_h{i}(1,best_inlier_indices), x_h{i}(2,best_inlier_indices),'wo')
    legend('outliers','inliers','transformed - inliers')
        set(legend, 'color', 'none')

end