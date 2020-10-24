function [plane] = get_estimated_plane(X)
meanX = mean(X,2); %Computes the mean 3D point
Xtilde = (X - repmat(meanX ,[1 size(X,2)]));
M = Xtilde(1:3,:)*Xtilde(1:3,:)';

[V,~] = eig(M);
plane = V(:,end);
d = -(dot(plane,meanX(1:3)));
plane = [plane;d];
plane = plane./norm(plane(1:3));
end
