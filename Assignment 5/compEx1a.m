%%
clear; clc;
%%
load x.mat
load X_3D.mat 
load K.mat 
load P.mat 
%%
max_iterations = 10^3;
U = [X_3D;ones(1,size(X_3D,2))];
P = {K*P{1},K*P{2}};
u = x;
[ err_before , res_before ] = ComputeReprojectionError (P ,U ,u );
hist ( res_before ,100)
title('Residual values before')
%res_before.jpg 
%%
lambda = 1;
err = zeros(max_iterations);
for i = 1:max_iterations
[r ,J ] = LinearizeReprojErr (P ,U ,u );
C = J'* J+ lambda * speye ( size(J ,2));
c = J'* r;
deltav = -C \c ;
[ Pnew , Unew ] = update_solution ( deltav ,P , U );
[ err_after , res_after ] = ComputeReprojectionError (P ,U ,u );
err(i) = err_after;
P = Pnew;
U = Unew;
end

plot(1:max_iterations, err);
xlabel('Number of iterations')
ylabel('Reprojection errors')
%err.jpg 

%%
hist ( res_after ,100);
title('Residual values after')
%res_after.jpg 