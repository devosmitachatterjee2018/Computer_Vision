%%
clear; clc;
%%
addpath('data\');
load('data7.mat');
%%data(1) = load('data1.mat');
%%data(2) = load('data2.mat');
%%data(3) = load('data3.mat');
%%data(4) = load('data4.mat');
%%data(5) = load('data5.mat');
%%data(6) = load('data6.mat');
%%data(7) = load('data7.mat');
%%data(8) = load('data8.mat');
%%data(9) = load('data9.mat');
%load K.mat 
%%
load P.mat 
%%
A = {};
K1 = {};
R1 = {};
for i = 1:7
    [K1{i},R1{i}]=rq(P{i});
    A{i} = inv(K1{i})*P{i}*sign(det(P{i}(:,1:3)));
end
save A.mat A
%%
U1 = {};
u1 = {};
max_iterations = 10^3;
for i = 1:7
    X_3D = U{i};
    U1{i} = [X_3D;ones(1,size(X_3D,2))];
    x = u{i};
    u1{i} = [x;ones(1,size(x,2))];
end
P1 = A;
%%
x1={u1{1}};
x2={u1{2}};
x3={u1{3}};
x4={u1{4}};
x5={u1{5}};
x6={u1{6}};
x7={u1{7}};
%%
X1=U1{1};
X2=U1{2};
X3=U1{3};
X4=U1{4};
X5=U1{5};
X6=U1{6};
X7=U1{7};
%%
P1_f={P1{1}};
P2_f={P1{2}};
P3_f={P1{3}};
P4_f={P1{4}};
P5_f={P1{5}};
P6_f={P1{6}};
P7_f={P1{7}};
%%
[ err_before1 , res_before1 ] = ComputeReprojectionError (P1_f ,X1 ,x1 );
[ err_before2 , res_before2 ] = ComputeReprojectionError (P2_f ,X2 ,x2 );
[ err_before3 , res_before3 ] = ComputeReprojectionError (P3_f ,X3 ,x3 );
[ err_before4 , res_before4 ] = ComputeReprojectionError (P4_f ,X4 ,x4 );
[ err_before5 , res_before5 ] = ComputeReprojectionError (P5_f ,X5 ,x5 );
[ err_before6 , res_before6 ] = ComputeReprojectionError (P6_f ,X6 ,x6 );
[ err_before7 , res_before7 ] = ComputeReprojectionError (P7_f ,X7 ,x7 );


%figure(1)
%hist ( res_before1 ,100)
%title('Residual values before')
%%
lambda = 0.1;
%%
err1 = zeros(max_iterations);
for i = 1:max_iterations
[r ,J ] = LinearizeReprojErr (P1_f ,X1 ,x1 );
C = J'* J+ lambda * speye ( size(J ,2));
c = J'* r;
deltav = -C \c ;
[ Pnew , Unew ] = update_solution ( deltav ,P1_f ,X1 );
[ err_after , res_after ] = ComputeReprojectionError (P1_f ,X1 ,x1 );
err1(i) = err_after;
Pfinal{1} = cell2mat(Pnew);
Ufinal{1} = Unew;
end
err2 = zeros(max_iterations);
for i = 1:max_iterations
[r ,J ] = LinearizeReprojErr (P2_f ,X2 ,x2 );
C = J'* J+ lambda * speye ( size(J ,2));
c = J'* r;
deltav = -C \c ;
[ Pnew , Unew ] = update_solution ( deltav ,P2_f ,X2 );
[ err_after , res_after ] = ComputeReprojectionError (P2_f ,X2 ,x2 );
err2(i) = err_after;
Pfinal{2} = cell2mat(Pnew);
Ufinal{2} = Unew;
end
err3 = zeros(max_iterations);
for i = 1:max_iterations
[r ,J ] = LinearizeReprojErr (P3_f ,X3 ,x3 );
C = J'* J+ lambda * speye ( size(J ,2));
c = J'* r;
deltav = -C \c ;
[ Pnew , Unew ] = update_solution ( deltav ,P3_f ,X3 );
[ err_after , res_after ] = ComputeReprojectionError (P3_f ,X3 ,x3 );
err3(i) = err_after;
Pfinal{3} = cell2mat(Pnew);
Ufinal{3} = Unew;
end
err4 = zeros(max_iterations);
for i = 1:max_iterations
[r ,J ] = LinearizeReprojErr (P4_f ,X4 ,x4 );
C = J'* J+ lambda * speye ( size(J ,2));
c = J'* r;
deltav = -C \c ;
[ Pnew , Unew ] = update_solution ( deltav ,P4_f ,X4 );
[ err_after , res_after ] = ComputeReprojectionError (P4_f ,X4 ,x4 );
err4(i) = err_after;
Pfinal{4} = cell2mat(Pnew);
Ufinal{4} = Unew;
end
err5 = zeros(max_iterations);
for i = 1:max_iterations
[r ,J ] = LinearizeReprojErr (P5_f ,X5 ,x5 );
C = J'* J+ lambda * speye ( size(J ,2));
c = J'* r;
deltav = -C \c ;
[ Pnew , Unew ] = update_solution ( deltav ,P5_f ,X5 );
[ err_after , res_after ] = ComputeReprojectionError (P5_f ,X5 ,x5 );
err5(i) = err_after;
Pfinal{5} = cell2mat(Pnew);
Ufinal{5} = Unew;
end
err6 = zeros(max_iterations);
for i = 1:max_iterations
[r ,J ] = LinearizeReprojErr (P6_f ,X6 ,x6 );
C = J'* J+ lambda * speye ( size(J ,2));
c = J'* r;
deltav = -C \c ;
[ Pnew , Unew ] = update_solution ( deltav ,P6_f ,X6 );
[ err_after , res_after ] = ComputeReprojectionError (P6_f ,X6 ,x6 );
err6(i) = err_after;
Pfinal{6} = cell2mat(Pnew);
Ufinal{6} = Unew;
end
err7 = zeros(max_iterations);
for i = 1:max_iterations
[r ,J ] = LinearizeReprojErr (P7_f ,X7 ,x7 );
C = J'* J+ lambda * speye ( size(J ,2));
c = J'* r;
deltav = -C \c ;
[ Pnew , Unew ] = update_solution ( deltav ,P7_f ,X7 );
[ err_after , res_after ] = ComputeReprojectionError (P7_f ,X7 ,x7 );
err7(i) = err_after;
Pfinal{7} = cell2mat(Pnew);
Ufinal{7} = Unew;
end
%figure
%plot(1:max_iterations, err1);
%xlabel('Number of iterations')
%ylabel('Reprojection errors')

save Pfinal.mat Pfinal
save Ufinal.mat Ufinal
%%
%hist ( res_after ,100);
%title('Residual values after')
