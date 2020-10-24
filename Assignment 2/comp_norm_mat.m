function N = comp_norm_mat(x)
s_x = 1/std(x(1,:));
mu_x = mean(x(1,:));
s_y = 1/std(x(2,:));
mu_y = mean(x(2,:));
N = [s_x,0,-s_x*mu_x;0,s_y,-s_y*mu_y;0,0,1];
end
