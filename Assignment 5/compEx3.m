%%
clear; clc;
%%
im{1} = imread('kronan1.JPG');
im{2} = imread('kronan2.JPG');
%%
load('compEx1data.mat');
load('compEx3data.mat');
%%
% Normalize image points
no_of_points = length(x{1});
xn{1} = inv(K)*x{1};
xn{2} = inv(K)*x{2};

M = set_F_dlt(xn{1},xn{2});

[Un,Sn,Vn] = svd(M);
E_approx = reshape(Vn(:,end),[3 3]);

[U,S,V] = svd(E_approx);

if det(U*V')>0
    E = U*diag([1 1 0])*V';
else
    V = -V;
    E = U*diag([1 1 0])*V';
end

%%
F = (inv(K))'*E*inv(K);
l = F*x {1}; 
l = l ./ sqrt ( repmat ( l (1 ,:).^2 + l (2 ,:).^2 ,[3 1]));
imagesc(im{2});
hold on
randomNumber = randi(length(x{2}),1,20);
plot(x{2}(1,randomNumber),x{2}(2,randomNumber),'r*')
rital(l(:,randomNumber),'-')
%%
hist ( abs ( sum ( l .* x {2})) ,100)
%%
W = [0,-1,0;1,0,0;0,0,1];
Z = [0,1,0;-1,0,0;0,0,0];

t{1} = -U(:,end);
R{1} = U*W'*V';

t{2} = U(:,end);
R{2} = U*W*V';

t{3} = U(:,end);
R{3} = U*W'*V';

t{4} = -U(:,end);
R{4} = U*W*V';

P{1} = [eye(3,3),zeros(3,1)];
P{2} = [R{4} t{4}];

for i=1:1:4
    P{2} = [R{i} t{i}];
    figure
    
    points{i} = triangulate(P,xn{1},xn{2});
    X_3D = pflat1(points{i});
    reproj_1 = P{1}*[X_3D;ones(1,length(X_3D))];
    reproj_2 = P{2}*[X_3D;ones(1,length(X_3D))];
    if_front{i} = bitand((reproj_1(3,:) >0) , (reproj_2(3,:) >0));
    plot3(X_3D(1,:),X_3D(2,:), X_3D(3,:),'.');
    hold on
    legend('3D points')
    plotcams(P)
    title(['3D points : camera set ',num2str(i) ]);
    
end

%%
save x.mat x
%%
save X_3D.mat X_3D
save K.mat K
save P.mat P
%%
perm = randperm(size(x{1},2), 20);
F = inv(K)'*E*inv(K);
dist = {};
figure;
for i=1:1:length(x)
    x_proj{i} = pflat1(K*P{i}*[X_3D;ones(1,no_of_points)]);
    subplot(1,2,i)
    imagesc(im{i});
    hold on;
    h(1) = plot(x{i}(1,perm),x{i}(2,perm),'r*','MarkerSize', 10);
    h(2) = plot(x_proj{i}(1,perm),x_proj{i}(2,perm),'bo','MarkerSize', 8);
    if (i ==2)
        l = F*x{1};
    elseif (i==1)
        l= F'*x{2};
    end
    
    l = l./sqrt(repmat(l(1,:).^2 + l(2,:).^2,[3 1]));

    dist{i} = abs(dot(l,x{i}));
    
    rital(l(:,perm))
    hold off;
    lgnd = legend(h([1 2]),'image points','projections');
    set(lgnd, 'color', 'none')
end

figure
histogram(dist{2},100);
