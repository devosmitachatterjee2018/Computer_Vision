function [H] = compute_homography(x1,x2)
A = zeros(2*length(x1),9);
for i=1:1:length(x1)
    
      r_x = [0,0,0, -x1(1,i)*x2(1,i), -x1(2,i)*x2(1,i), ...
        -x2(1,i),x2(1,i)*x2(2,i)*x1(1,i),x2(1,i)*x2(2,i)*x1(2,i), ...
        x2(1,i)*x2(2,i)];
    r_y = [x1(1,i)*x2(2,i), x2(2,i)*x1(2,i), x2(2,i), 0,0,0,...
        -x2(2,i)*x1(1,i)*x2(1,i), -x1(2,i)*x2(2,i)*x2(1,i),...
        -x2(1,i)*x2(2,i)];
    r_z = [-x2(2,i)*x1(1,i), -x2(2,i)*x1(2,i), -x2(2,i),...
        x2(1,i)*x1(1,i),x2(1,i)*x1(2,i),x2(1,i),0,0,0  ];
    A((3*i-2) : (3*i),:) =[r_x;r_y;r_z];
    
    % ?x ?y ?1 0 0 0 ux uy u
    % 0 0 0 ?x ?y ?1 vx vy v
    %r_x = [-x1(:,i)', zeros(1,3), x2(1,i)*x1(:,i)'];
    %r_y = [zeros(1,3), -x1(:,i)', x2(2,i)*x1(:,i)'];
    %A((2*i-1):2*i,:) = [r_x; r_y; r_z];
end

[U,S,V] = svd(A);
H = V(:,end);
H = reshape(H,[3 3])';