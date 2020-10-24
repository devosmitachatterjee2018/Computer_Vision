function [M] = DLT(Xmodel,x)

no_of_points = length(Xmodel);
M = zeros(3*no_of_points,12+no_of_points);

for j=1:1:no_of_points
    M(3*(j-1) + 1, 1:4) = [Xmodel(:,j);1]';
    M(3*(j-1) + 2, 5:8) = [Xmodel(:,j);1]';
    M(3*(j-1) + 3, 9:12) = [Xmodel(:,j);1]';
    M((3*(j-1) + 1):(3*(j-1) + 3),(12 + j)) = -[x(:,j);1];
end
end