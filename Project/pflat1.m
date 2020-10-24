function [coords_homogenous] = pflat1(coords)
coords_homogenous = coords./coords(end,:);
coords_homogenous = coords_homogenous(1:end-1,:);
end
