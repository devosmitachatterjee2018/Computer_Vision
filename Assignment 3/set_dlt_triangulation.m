function [A] = set_dlt_triangulation(P,x1,x2)
A = [x1(1) * P{1}(3,:) - P{1}(1,:) ;
     x1(2) * P{1}(3,:) - P{1}(2,:) ;
     x2(1) * P{2}(3,:) - P{2}(1,:) ;
     x2(2) * P{2}(3,:) - P{2}(2,:) ];
end