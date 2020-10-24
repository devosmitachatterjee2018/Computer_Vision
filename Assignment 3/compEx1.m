%%
clear; clc;
%%
figure;
subplot(1,2,1)
img1 = imread('kronan1.JPG');
imshow(img1);

subplot(1,2,2)
img2 = imread('kronan2.JPG');
imshow(img2);
%%
load('compEx1data.mat')
%%
figure;
subplot(1,2,1)
x1 = cell2mat(x(1));

m1 = mean(x1(1:2,:),2); 
s1 = std(x1(1:2,:),0,2); 

N1 = [(1/s1(1)), 0, -(1/s1(1))*m1(1);0, (1/s1(2)), -(1/s1(2))*m1(2);0, 0, 1];

x1_new = N1*x1;
plot (x1_new(1,:),x1_new(2,:),'b*');
title('Normalized x1')
axis equal 

subplot(1,2,2)
x2 = cell2mat(x(2));

m2 = mean(x2(1:2,:),2); 
s2 = std(x2(1:2,:),0,2); 

N2 = [(1/s2(1)), 0, -(1/s2(1))*m2(1);0, (1/s2(2)), -(1/s2(2))*m2(2);0, 0, 1];

x2_new = N2*x2;
plot (x2_new(1,:),x2_new(2,:),'r*');
title('Normalized x2')
axis equal

N = {};
N = {N1,N2};
%%
xn = {};
xn = {x1_new,x2_new};

%%
Mn = algorithm(xn);
[Un ,Sn ,Vn] = svd(Mn);
vn = Vn(:,end);

min(svd(Mn))
norm(Mn*vn)

%%
Ftilde = reshape (vn ,[3 3]);
[Utilde,Stilde,Vtilde] = svd(Ftilde);
Stilde(3,3) = 0;
Fn = Utilde*Stilde*Vtilde';
%%
plot ( diag ( xn{2}'* Fn * xn{1} ));
det(Fn)

%%
F = N2'*Fn*N1;
l = F*x {1}; 
l = l ./ sqrt ( repmat ( l (1 ,:).^2 + l (2 ,:).^2 ,[3 1]));
imagesc(img2);
hold on
randomNumber = randi(length(x{2}),1,20);
plot(x{2}(1,randomNumber),x{2}(2,randomNumber),'r*')
rital(l(:,randomNumber),'-')
%%
F = F./F(3,3)
%%
hist ( abs ( sum ( l .* x {2})) ,100)
%%
mean(abs ( sum ( l .* x {2})))

%%
e2 = null (F'); % Computes the epipole
%%
e2x = [0 -e2(3) e2(2); e2(3) 0 -e2(1); -e2(2) e2(1) 0];
%%
P2 = [e2x*F e2];
P1 = [eye(3),[0;0;0]];
P = {};
P = {P1,P2};
%%
X=zeros(4,length(x{1}));

for i=1:length(x{1})
    xn_1 = N{1}*x{1}(:,i);
    xn_2 = N{2}*x{2}(:,i);
    A = DLT_triangulation({N1*P{1},N2*P{2}},xn_1,xn_2);
    [U,S,V] = svd(A);
    X(:,i) = V(:,end); 
    
end
X = pflat(X);

figure
plot3(X(1,:), X(2,:),X(3,:),'.','MarkerSize', 4);

X_proj1 = P{1}*X;
X_proj2 = P{2}*X;
X_proj1_2D = pflat(X_proj1);
X_proj2_2D = pflat(X_proj2);
%%
figure;
subplot(1,2,1)
imagesc(img1)
hold on 
plot(x{1}(1,:), x{1}(2,:),'b*');
plot(X_proj1_2D(1,:),X_proj1_2D(2,:),'ro')

subplot(1,2,2)
imagesc(img2)
hold on 
plot(x{2}(1,:), x{2}(2,:),'k*');
plot(X_proj2_2D(1,:),X_proj2_2D(2,:),'co')