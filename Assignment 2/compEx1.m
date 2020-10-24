%%
clear; clc;
%%
load('compEx1data.mat');
%%
plot3(X(1,:), X(2,:), X(3,:), '.')
hold on 

plotcams(P)
axis equal
%%
i = 1;
im = imread(imfiles{i});
imagesc(im)
axis equal

hold on 

visible = isfinite(x{i}(1,:));
plot (x{i}(1,visible),x{i}(2,visible),'*');

P1 = cell2mat(P(1));
X_proj = P1*X;
X_proj_2D = pflat(X_proj);
plot (X_proj_2D(1,visible),X_proj_2D(2,visible),'ro');
axis equal
%%
T1 = [1,0,0,0;0,4,0,0;0,0,1,0;1/10,1/10,0,1];
X1_proj = T1*X;
X1_proj_3D = pflat(X1_proj);
plot3(X1_proj_3D(1,:), X1_proj_3D(2,:), X1_proj_3D(3,:), 'k.', 'Markersize',4);
axis equal
hold on

T2 = [1,0,0,0;0,1,0,0;0,0,1,0;1/16,1/16,0,1];
X2_proj = T2*X;
X2_proj_3D = pflat(X2_proj);
plot3(X2_proj_3D(1,:), X2_proj_3D(2,:), X2_proj_3D(3,:), 'b.', 'Markersize',4);
axis equal


P_T1 = {};
P_T2 = {};

for i=1:9
    P_T1{i} = P{i}*inv(T1);
    P_T2{i} = P{i}*inv(T2);
end 

plotcams(P_T1)
axis equal

plotcams(P_T2)  
axis equal
%%
i = 1;
im = imread(imfiles{i});
imagesc(im)
axis equal

hold on 

visible = isfinite(x{i}(1,:));
plot (x{i}(1,visible),x{i}(2,visible),'k*');

X1_proj_new = P_T1{i}*X1_proj_3D;
X1_proj_new_2D = pflat(X1_proj_new);
plot ( X1_proj_new_2D(1,visible),X1_proj_new_2D(2,visible),'rv');

X2_proj_new = P_T2{i}*X2_proj_3D;
X2_proj_new_2D = pflat(X2_proj_new);
plot ( X2_proj_new_2D(1,visible),X2_proj_new_2D(2,visible),'co');
axis equal

%%
p = cell2mat(P(1));
A = p(:,1:end-1);
[K,R]=rq(A);

p1 = cell2mat(P_T1(1));
A1 = p1(:,1:end-1);
[K1,R1]=rq(A1);

p2 = cell2mat(P_T2(1));
A2 = p2(:,1:end-1);
[K2,R2]=rq(A2);