%%
clc; clear;
%%
%I = imread('img1.jpg');
%load P_est.mat 
%load data1.mat;
%%
addpath('data\')
I = imread('img2.jpg');
load data2.mat;
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
%            ape: 8390.71 pixels
%            can: 826.57 pixels
%            cat: 2400.52 pixels
%           duck: 5167.73 pixels
%         eggbox: 1951.78 pixels
%           glue: 14517.94 pixels
%    holepuncher: 1282.20 pixels

%%
%4.9339e+03