%%
clear; clc;
%%
figure;
subplot(1,2,1)
im1 = imread ('compEx4im1.jpg'); 
imagesc(im1) 
colormap gray 

subplot(1,2,2)
im2 = imread ('compEx4im2.jpg'); 
imagesc(im2) 
colormap gray 
%%
load('compEx4.mat');
%%
R1 = P1(:,1:end-1);
t1 = P1(:,end);
C1 = -inv(R1)*t1;
V1 = P1(end,1:end-1)';
R2 = P2(:,1:end-1);
t2 = P2(:,end);
C2 = -inv(R2)*t2;
V2 = P2(end,1:end-1)';
%%
U_new = pflat(U);
figure(3)
plot3(U_new(1,:),U_new(2,:),U_new(3,:),'b.') 
hold on
plot3(C1(1),C1(2),C1(3),'r*') 
plot3(C2(1),C2(2),C2(3),'ko')
quiver3(C1(1),C1(2),C1(3),V1(1),V1(2),V1(3),10)
quiver3(C2(1),C2(2),C2(3),V2(1),V2(2),V2(3),10)
%%
figure;
subplot(1,2,1)
im1 = imread ('compEx4im1.jpg'); 
imagesc(im1) 
colormap gray 
hold on
U_new_proj1 = R1*U_new(1:end-1,:)+t1;
U_new_proj1_f = pflat(U_new_proj1);
plot(U_new_proj1_f(1,:),U_new_proj1_f(2,:),'b.','MarkerSize',2);

subplot(1,2,2)
im2 = imread ('compEx4im2.jpg'); 
imagesc(im2) 
colormap gray 
hold on
U_new_proj2 = R2*U_new(1:end-1,:)+t2;
U_new_proj2_f = pflat(U_new_proj2);
plot(U_new_proj2_f(1,:),U_new_proj2_f(2,:),'r.','MarkerSize',2);
