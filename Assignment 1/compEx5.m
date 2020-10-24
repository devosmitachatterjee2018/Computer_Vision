%%
clear; clc;
%%
figure(1)
im = imread ('compEx5.jpg'); 
imagesc(im) 
colormap gray 
%%
load('compEx5.mat');
%%
figure(2)
im = imread ('compEx5.jpg'); 
imagesc(im) 
colormap gray 
hold on 
plot(corners(1 ,[1: end 1]),corners(2 ,[1: end 1]), 'b*- ');
axis equal
%%
origin = [0;0;1];
origin_new = K\origin;
plot(origin_new(1),origin_new(2),'r*')
hold on
corners_new = K\corners;
plot(corners_new(1 ,[1: end 1]),corners_new(2 ,[1: end 1]), '*-');
axis ij
axis equal
%%
v_new = pflat(v);
pi = v_new(1:end-1);
%%
corners_new_3D = [corners_new; -pi'*corners_new];
corners_new1_3D = pflat(corners_new_3D);
plot3(corners_new1_3D(1 ,[1: end 1]),corners_new1_3D(2 ,[1: end 1]),corners_new1_3D(3 ,[1: end 1]), '*-');
hold on
R1 = eye(3);
t1 = [0;0;0];
C1 = -R1'*t1;
V1 = R1(end,:)';
plot3(C1(1),C1(2),C1(3),'r*') 
quiver3(C1(1),C1(2),C1(3),V1(1),V1(2),V1(3),1)
axis equal

R2 = [sqrt(3)/2,0,1/2;0,1,0;-1/2,0,sqrt(3)/2];
C2 = [2;0;0];
V2 = R2(end,:)';
plot3(C2(1),C2(2),C2(3),'b*') 
quiver3(C2(1),C2(2),C2(3),V2(1),V2(2),V2(3),1)
axis equal

%%
t2 = -R2*C2;
H2 = R2 - t2*pi';
corners_new2_proj = H2*corners_new1_3D(1:end-1,:);

corners_new2_proj1 = pflat(corners_new2_proj);
plot(corners_new2_proj1(1 ,[1: end 1]),corners_new2_proj1(2 ,[1: end 1]), '*- ');
axis equal
%%
plot3(corners_new2_proj1(1 ,[1: end 1]),corners_new2_proj1(2 ,[1: end 1]),corners_new2_proj1(3 ,[1: end 1]), 'b*-');
hold on
corners_new_3D1 = [R2,t2]*corners_new_3D;
corners_new_3D2 = pflat(corners_new_3D1);
plot3(corners_new_3D2(1 ,[1: end 1]),corners_new_3D2(2 ,[1: end 1]),corners_new_3D2(3 ,[1: end 1]),'r*-');
axis equal
legend('homography','camera matrix')
%%
figure;
subplot(1,2,1)
im = imread ('compEx5.jpg'); 
imagesc(im) 
colormap gray 
title('Original image')
subplot(1,2,2)
Htot = (K*H2)/K;
tform = maketform ('projective',Htot');
[new_im,xdata,ydata] = imtransform(im,tform,'size',size(im));
imagesc (xdata,ydata,new_im);
colormap gray 
title('Total transformation')