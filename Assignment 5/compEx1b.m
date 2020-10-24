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
%%
lambda = 0.1;
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

errplot2 = plot(1:max_iterations, err);
xlabel('Number of iterations')
ylabel('Reprojection errors')
save err2.jpg errplot2

