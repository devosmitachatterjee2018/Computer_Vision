%%
clc; clear;
%%
%I = imread('img1.jpg');
%load P_est.mat 
%load data1.mat;
%%
addpath('data\')
I = imread('img4.jpg');
load data4.mat;
%load A.mat;
load Pfinal.mat;
%load Ufinal.mat;
%% Sample 3 correspondences and find candidate camera matrices for one object
obj_idx = 1;
ind = randsample ( size (U { obj_idx } ,2) , 3);
Ps = minimalCameraPose ( pextend ( u{ obj_idx }(: , ind )) , U { obj_idx }(: , ind ));% minimalCameraPose.m % pextend.m
%%
P_est = Pfinal; % cell array with your final pose estimates for each object.
%P_est = poses ; %( ground truth ).    
%% Plot bounding boxes of all objects , overlayed on image . % You can try out the plotting fucntionality immediately ,% by setting P_est = poses ; ( ground truth ).
draw_bounding_boxes (I , poses , P_est , bounding_boxes );% draw_bounding_boxes.m
%%
% Compute ( and print out ) the score for each estimated object pose .
scores = eval_pose_estimates ( poses , P_est , bounding_boxes );% eval_pose_estimates.m
%%
%RMS reprojection error for bounding box corners
%            ape: 2622.67 pixels
%            can: 7008.22 pixels
%            cat: 2966.00 pixels
%           duck: 13979.26 pixels
%         eggbox: 2897.67 pixels
%           glue: 6478.36 pixels
%    holepuncher: 1245.73 pixels
%%
%5.3140e+03