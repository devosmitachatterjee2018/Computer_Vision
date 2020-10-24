function [rms] = compute_rms_error(Xs, plane)
rms = sqrt(sum((plane'*Xs).^2)/size(Xs,2));
end