%%
clear; clc;
%%
addpath('data\');
%figure;
%subplot(1,2,1)
%img1 = imread('img1.jpg');
%imshow(img1);

%subplot(1,2,2)
%img2 = imread('img2.jpg');
%imshow(img2);
%%
%%data(1) = load('data1.mat');
%%data(2) = load('data2.mat');
%%data(3) = load('data3.mat');
%%data(4) = load('data4.mat');
%%data(5) = load('data5.mat');
%%data(6) = load('data6.mat');
%%data(7) = load('data7.mat');
%%data(8) = load('data8.mat');
%%data(9) = load('data9.mat');
data6 = load('data6.mat');
%%
%i = 1;
%%figure;
%%subplot(1,2,1)
%x1 = cell2mat(x(i));

%m1 = mean(x1(1:2,:),2); 

%s1 = std(x1(1:2,:),0,2); 

%N1 = [(1/s1(1)), 0, -(1/s1(1))*m1(1);0, (1/s1(2)), -(1/s1(2))*m1(2);0, 0, 1];

%x1_new = N1*x1;
%%plot (data1.u{1}(1,:),data1.u{1}(2,:),'b*');
%%title('Normalized x1')
%%subplot(1,2,2)


%i = 2;
%x2 = cell2mat(x(i));

%m2 = mean(x2(1:2,:)); 

%s2 = std(x2(1:2,:),0,2); 

%N2 = [(1/s2(1)), 0, -(1/s2(1))*m2(1);0, (1/s2(2)), -(1/s2(2))*m2(2);0, 0, 1];

%x2_new = N2*x2;
%%plot (data2.u{1}(1,:),data2.u{1}(2,:),'b*');
%%title('Normalized x2')
%%
%%M1 = DLT(data1.U{1},data1.u{1});
%%[U1 ,S1 ,V1] = svd(M1);
%%v1 = V1(:,end);
%%camera_mat1 = reshape ( v1 (1:12) ,[4 3])';
%%proj1 = camera_mat1*[data1.U{1};ones(1,length(data1.U{1}))];
%%if ( proj1(3,:) < 0)
%%    v1 = -v1;
%%end
%%P1 =reshape(v1(1:12),[4,3])';

%%M2 = DLT(data2.U{1},data2.u{1});
%%[U2 ,S2 ,V2] = svd(M2);
%%v2 = V2(:,end);
%%camera_mat2 = reshape ( v2 (1:12) ,[4 3])';
%%proj2 = camera_mat2*[data2.U{1};ones(1,length(data2.U{1}))];
%%if ( proj2(3,:) < 0)
%%    v2 = -v2;
%%end
%%P2 =reshape(v2(1:12),[4,3])';










%%
%%M1 = {};
%%U1 = {};
%%S1 = {};
%%V1 = {};
%%v1 = {};
%%camera_mat1 = {};
%%P1 = {};
%%proj1 = {};
%%for i = 1:7
%%M1{i} = DLT(data(i).U{1},data(i).u{1});
%%[U1{i} ,S1{i} ,V1{i}] = svd(M1{i});
%%v1{i} = V1{i}(:,end);
%%camera_mat1{i} = reshape ( v1{i} (1:12) ,[4 3])';
%%proj1{i} = camera_mat1{i}*[data(i).U{1};ones(1,length(data(i).U{1}))];
%%if ( proj1{i}(3,:) < 0)
%%    v1{i} = -v1{i};
%%end
%%P1{i} =reshape(v1{i}(1:12),[4,3])';
%%end
%%
%Object 1
P = {};
%M = {};

for i=1:7
    %i = 7;
    Xmodel = data6.U{i};
    x_n = data6.u{i};
    M = DLT(Xmodel,x_n);
    [U1,S1,V1] = svd(M);
    v = V1(:,end);
    camera_mat = reshape(v(1:12),[4,3])';
    proj = camera_mat*[Xmodel;ones(1,length(Xmodel))];
    if ( proj(3,:) < 0)
        v = -v;
    end
    P{i} =reshape(v(1:12),[4,3])';
end
%%
%A = zeros(3,4,7); 
%%N = {};
%%P1 = {};
%%for j = 1:9    
%%N{j} = comp_norm_mat(data(j).U{1});
%%P1{j} = inv(N{j})*P{j};
%%end
%U2 = pflat(data2.U{1});
%m2 = mean(U2(1:2,:)); 
%s2 = std(U2(1:2,:),0,2); 
%N2 = [(1/s2(1)), 0, -(1/s2(1))*m2(1);0, (1/s2(2)), -(1/s2(2))*m2(2);0, 0, 1];

%%
%figure
%subplot(1,2,1)

%A1 = inv(N1)*P1;
%reprojected_points1 = pflat(A1*[Xmodel;ones(1,length(Xmodel))]);
%imagesc(img1)
%title('Image1')
%hold on
%plot(reprojected_points1(1,:),reprojected_points1(2,:),'wo', 'MarkerSize',7)
%plot(x{1}(1,:),x{1}(2,:),'m.')
    
%subplot(1,2,2)
%A2 = inv(N2)*P2;
%reprojected_points2 = pflat(A2*[Xmodel;ones(1,length(Xmodel))]);
%imagesc(img2)
%title('Image2')
%hold on
%plot(reprojected_points2(1,:),reprojected_points2(2,:),'wo', 'MarkerSize',7)
%plot(x{2}(1,:),x{2}(2,:),'m.')

%%
%P={};
%P={A1 A2};
%save cameras.mat P

%%
%[K1,R1]=rq(A1);
%[K2,R2]=rq(A2);
%%
%K1 = K1./K1(end,end);
%K2 = K2./K2(end,end);
%%
%P_est1 = inv(K1)*A1;
%P_est2 = inv(K2)*A2;
%%
%%P1 = {};
%%for i = 1:7
%%[K1{i},R1{i}]=rq(A1{i});
%%P1{i} = inv(K1{i})*A1{i};
%%end
%%
save P.mat P%normalized P 
%%save P1.mat P1%unnormalized P
%%
%No need
%load P.mat
