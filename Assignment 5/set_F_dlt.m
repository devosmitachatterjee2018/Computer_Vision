function [M] = set_F_dlt(x1,x2)
% outputs the M of the 8 pt algorithm
no_of_points = length(x1);
M =zeros(no_of_points,9);
for i=1:1:no_of_points
    %M(i,:) = [x2(1,i)*x1(1,i), x2(1,i)*x1(2,i), x2(1,i)*x1(3,i),...
    %    x2(2,i)*x1(1,i), x2(2,i)*x1(2,i), x2(2,i)*x1(3,i),...
    %    x2(3,i)*x1(1,i), x2(3,i)*x1(2,i), x2(3,i)*x1(3,i)];
    xx = x2(:,i)*x1(:,i)';
    M(i,:) = xx(:)';
end
end