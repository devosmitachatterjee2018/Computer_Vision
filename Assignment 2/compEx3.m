%%
clear; clc;
%%
figure;
subplot(1,2,1)
img1 = imread('cube1.JPG');
imshow(img1);

subplot(1,2,2)
img2 = imread('cube2.JPG');
imshow(img2);
%%
load('compEx3data.mat');
%%
i = 1;
figure;
subplot(1,2,1)
x1 = cell2mat(x(i));

m1 = mean(x1(1:2,:),2); 

s1 = std(x1(1:2,:),0,2); 

N1 = [(1/s1(1)), 0, -(1/s1(1))*m1(1);0, (1/s1(2)), -(1/s1(2))*m1(2);0, 0, 1];

x1_new = N1*x1;
plot (x1_new(1,:),x1_new(2,:),'b*');
title('Normalized x1')
subplot(1,2,2)


i = 2;
x2 = cell2mat(x(i));

m2 = mean(x2(1:2,:)); 

s2 = std(x2(1:2,:),0,2); 

N2 = [(1/s2(1)), 0, -(1/s2(1))*m2(1);0, (1/s2(2)), -(1/s2(2))*m2(2);0, 0, 1];

x2_new = N2*x2;
plot (x2_new(1,:),x2_new(2,:),'r*');
title('Normalized x2')
%%
M1 = DLT(Xmodel,x1_new);
[U1 ,S1 ,V1] = svd(M1);
v1 = V1(:,end);
camera_mat1 = reshape ( v1 (1:12) ,[4 3])';
proj1 = camera_mat1*[Xmodel;ones(1,length(Xmodel))];
if ( proj1(3,:) < 0)
    v1 = -v1;
end
P1 =reshape(v1(1:12),[4,3])';

M2 = DLT(Xmodel,x2_new);
[U2 ,S2 ,V2] = svd(M2);
v2 = V2(:,end);
camera_mat2 = reshape ( v2 (1:12) ,[4 3])';
proj2 = camera_mat2*[Xmodel;ones(1,length(Xmodel))];
if ( proj2(3,:) < 0)
    v2= -v2;
end
P2 =reshape(v2(1:12),[4,3])';



%%
figure
subplot(1,2,1)
A1 = inv(N1)*P1;
reprojected_points1 = pflat(A1*[Xmodel;ones(1,length(Xmodel))]);
imagesc(img1)
title('Image1')
hold on
plot(reprojected_points1(1,:),reprojected_points1(2,:),'wo', 'MarkerSize',7)
plot(x{1}(1,:),x{1}(2,:),'m.')
    
subplot(1,2,2)
A2 = inv(N2)*P2;
reprojected_points2 = pflat(A2*[Xmodel;ones(1,length(Xmodel))]);
imagesc(img2)
title('Image2')
hold on
plot(reprojected_points2(1,:),reprojected_points2(2,:),'wo', 'MarkerSize',7)
plot(x{2}(1,:),x{2}(2,:),'m.')

%%
P={};
P={A1 A2};
save cameras.mat P
plot3 ([ Xmodel(1, startind); Xmodel(1, endind)] ,...
[ Xmodel(2 , startind); Xmodel(2 , endind)] ,...
[ Xmodel(3 , startind); Xmodel(3 , endind)] , 'b -');
hold on
plotcams(P)
%%
[K1,R1]=rq(A1);
[K2,R2]=rq(A1);
%%
K1 = K1./K1(end,end);
K2 = K2./K2(end,end);
%%
indices = [1, 4, 13, 16, 25, 28, 31];
x{2} = pflat(x{2});
e_Rms = sqrt(norm(reprojected_points2 - x{2},'fro')/length(x{2}))