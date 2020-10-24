%%
clear;clc;
%%
compEx1a
im{1} = imread('kronan1.JPG');
im{2} = imread('kronan2.JPG');
%%
load compex2data.mat
%%

d = linspace (5 ,11 ,200);
sc = 0.25;
set(0,'DefaultFigureVisible','off')
[ ncc , outside_image ] = compute_ncc (d , im{2} , P {2} , im{1} , segm_kronan1 , P {1} ,3 , sc );
set(0,'DefaultFigureVisible','on')
[ maxval , maxpos ] = max ( ncc ,[] ,3);
disp_result ( im{2} ,P {2} , segm_kronan2 , d( maxpos ) ,0.25 , sc )


