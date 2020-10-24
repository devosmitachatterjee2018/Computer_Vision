%%
clear; clc;
%%
im = imread ('compEx2.jpg'); 
imagesc(im) 
colormap gray 
%%
im = imread ('compEx2.jpg'); 
imagesc(im) 
colormap gray 
hold on 
load('compEx2.mat');
plot(p1(1,:),p1(2,:),'*')
plot(p2(1,:),p2(2,:),'*')
plot(p3(1,:),p3(2,:),'*')

linjer1 = cross(p1(:,1),p1(:,2));%the lines obtained from the pairs p1
linjer2 = cross(p2(:,1),p2(:,2));%the lines obtained from the pairs p2
linjer3 = cross(p3(:,1),p3(:,2));%the lines obtained from the pairs p3
rital(linjer1)
rital(linjer2)
rital(linjer3)

x = pflat(cross(linjer2,linjer3));
plot(x(1,:),x(2,:),'g*')

a = linjer1(1);
b = linjer1(2);
d = abs((linjer1'*x))/sqrt(a.^2+b.^2);
%%
plot3(linjer1,linjer2,linjer3)