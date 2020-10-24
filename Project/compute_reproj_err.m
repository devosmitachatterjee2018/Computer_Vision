function [reproj_err] = compute_reproj_err(x_ref, x_comp)
    reproj_err =  x_ref - x_comp;
    reproj_err = vecnorm(reproj_err);
end