function [coords_homogenous] = pflat(coords)
%This function at divides the homogeneous coordinates with
%their last entry for points of any dimensionality.
coords_homogenous = coords./coords(end,:);
end
