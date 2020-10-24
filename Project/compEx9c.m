%%
clc; clear;
%%
%I = imread('img1.jpg');
%load P_est.mat 
%load data1.mat;
%%
addpath('data\')
I = imread('img9.jpg');
load data9.mat;
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
%            ape: 1971.33 pixels
%            can: 1257.18 pixels
%            cat: 612.15 pixels
%           duck: 2340.84 pixels
%         eggbox: 868.35 pixels
%           glue: 5219.34 pixels
%    holepuncher: 488.95 pixels
%%
%1.8149e+03