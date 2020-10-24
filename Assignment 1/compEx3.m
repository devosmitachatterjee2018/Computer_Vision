%%
clear; clc;
%%
load('compEx3.mat');
plot([startpoints(1,:);endpoints(1,:)],[startpoints(2,:);endpoints(2,:)],'b-');
xticks([-1 -0.5 0 0.5 1])
xticklabels({'-1','-0.5','0','0.5','1'})
yticks([-1 -0.5 0 0.5 1])
yticklabels({'-1','-0.5','0','0.5','1'})
%%
H1 = [sqrt(3) -1 1;1 sqrt(3) 1;0 0 2];
startpoints1 = [startpoints; ones(1,42)];
endpoints1 = [endpoints; ones(1,42)];
Transformed_startpoints1 = H1*startpoints1;
Transformed_endpoints1 = H1*endpoints1;
Transformed_startpoints1_new = pflat(Transformed_startpoints1);
Transformed_endpoints1_new = pflat(Transformed_endpoints1);
plot([Transformed_startpoints1_new(1,:);Transformed_endpoints1_new(1,:)],[Transformed_startpoints1_new(2,:);Transformed_endpoints1_new(2,:)],'b-');
title('Euclidean transformation')
axis equal
%%
H2 = [1 -1 1;1 1 0;0 0 1];
startpoints2 = [startpoints; ones(1,42)];
endpoints2 = [endpoints; ones(1,42)];
Transformed_startpoints2 = H2*startpoints2;
Transformed_endpoints2 = H2*endpoints2;
Transformed_startpoints2_new = pflat(Transformed_startpoints2);
Transformed_endpoints2_new = pflat(Transformed_endpoints2);
plot([Transformed_startpoints2_new(1,:);Transformed_endpoints2_new(1,:)],[Transformed_startpoints2_new(2,:);Transformed_endpoints2_new(2,:)],'b-');
title('Similarity transformation')
axis equal
%%
H3 = [1 1 0;0 2 0;0 0 1];
startpoints3 = [startpoints; ones(1,42)];
endpoints3 = [endpoints; ones(1,42)];
Transformed_startpoints3 = H3*startpoints3;
Transformed_endpoints3 = H3*endpoints3;
Transformed_startpoints3_new = pflat(Transformed_startpoints3);
Transformed_endpoints3_new = pflat(Transformed_endpoints3);
plot([Transformed_startpoints3_new(1,:);Transformed_endpoints3_new(1,:)],[Transformed_startpoints3_new(2,:);Transformed_endpoints3_new(2,:)],'b-');
title('Affine transformation')
axis equal
%%
H4 = [sqrt(3) -1 1;1 sqrt(3) 1;1/4 1/2 2];
startpoints4 = [startpoints; ones(1,42)];
endpoints4 = [endpoints; ones(1,42)];
Transformed_startpoints4 = H4*startpoints4;
Transformed_endpoints4 = H4*endpoints4;
Transformed_startpoints4_new = pflat(Transformed_startpoints4);
Transformed_endpoints4_new = pflat(Transformed_endpoints4);
plot([Transformed_startpoints4_new(1,:);Transformed_endpoints4_new(1,:)],[Transformed_startpoints4_new(2,:);Transformed_endpoints4_new(2,:)],'b-');
title('Projective transformation')
axis equal