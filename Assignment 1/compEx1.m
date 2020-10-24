%%
clear; clc;
%%
load('compEx1.mat');

x2D_new = pflat(x2D);
x3D_new = pflat(x3D);

figure(1)
plot(x2D_new(1,:),x2D_new(2,:),'.') 
title('2D plot')
axis equal

figure(2)
plot3(x3D_new(1,:),x3D_new(2,:),x3D_new(3,:),'.') 
title('3D plot')
axis equal 
