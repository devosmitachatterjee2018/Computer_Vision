clear;clc;
%%
addpath('assignment2data/');
im{1} = imread('cube1.JPG');
im{2} = imread('cube2.JPG');
load('cameras1.mat')
load('K.mat')
[f{1} d1] = vl_sift( single(rgb2gray(im{1})), 'PeakThresh', 1);
[f{2} d2] = vl_sift( single(rgb2gray(im{2})), 'PeakThresh', 1);
figure;
imagesc(im{1});
vl_plotframe(f{1});
title('SIFT FEATURES - IM 1')
[matches ,scores] = vl_ubcmatch(d1,d2);
%%
x{1}= [f{1}(1,matches(1,:));f{1}(2,matches(1,:))];
x{2}= [f{2}(1,matches(2,:));f{2}(2,matches(2,:))];

perm = randperm(size(matches ,2));
figure;
imagesc([im{1} im{2}]);
hold on;
title('matches')
plot([x{1}(1,perm(1:30)); x{1}(1,perm(1:30))+size(im{1},2)], ...,
    [x{2}(2,perm(1:30)); x{2}(2,perm(1:30))],'-');
hold off;
figure
subplot(1,2,1)
imagesc(im{1})
hold on
plot(x{1}(1,:), x{1}(2,:),'*');
subplot(1,2,2)
imagesc(im{2})
hold on
plot(x{2}(1,:), x{2}(2,:),'*');

%%

no_of_points = length(x{1});
x{1} = [x{1}; ones(1,no_of_points)];
x{2} = [x{2}; ones(1,no_of_points)];
N{1} = comp_norm_mat(x{1});
N{2} = comp_norm_mat(x{2});

X=zeros(4,no_of_points);
for i=1:1:no_of_points
    xn_1 = N{1}*x{1}(:,i);
    xn_2 = N{2}*x{2}(:,i);

    A = set_dlt_triangulation({N{1}*P{1},N{2}*P{2}},xn_1,xn_2);
    %A = normr(A);
    [U,S,V] = svd(A);
    X(:,i) = V(:,end);        
end
X = pflat1(X);
%X(X < quantile(X(:),0.05) | X > quantile(X(:),0.95)) = NaN;
figure
plot3(X(1,:), X(2,:),X(3,:),'.','MarkerSize', 2);

figure
[reprojected_points, reproj_err, good_points] = deal({});

for im_idx=1:2
    reprojected_points{im_idx} = pflat1(P{im_idx}*[X;ones(1,no_of_points)]);
    reproj_err{im_idx} = compute_reproj_err(pflat1(x{im_idx}), reprojected_points{im_idx});
    good_points{im_idx} = logical(reproj_err{im_idx} < 3) ;
    subplot(1,2,im_idx)
    imagesc(im{im_idx})
    hold on
    vl_plotframe(f{im_idx});
    plot(reprojected_points{im_idx}(1,:),reprojected_points{im_idx}(2,:),'m.')
    legend('SIFT', 'Projection')
end

[reproj_err] = compute_reproj_err(pflat1(x{1}), reprojected_points{1});

good_points = bitor(good_points{1},good_points{2});
X = X(:,good_points);
figure
plot3(X(1,:), X(2,:),X(3,:),'o','MarkerSize', 2);