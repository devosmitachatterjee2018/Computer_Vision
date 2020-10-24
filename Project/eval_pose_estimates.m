% 
% Displays the image im, and also draws bounding boxes for the provided
% objects. P_gts, P_ests are cell arrays with ground truth and estimated poses.
% 
function scores = eval_pose_estimates(P_gts, P_ests, bounding_boxes)
    objnames = {'ape', 'can', 'cat', 'duck', 'eggbox', 'glue', 'holepuncher'};

    disp('RMS reprojection error for bounding box corners')

    for k = 1:length(objnames)
        tol = 1e-3;
        R = P_gts{k}(:,1:3);
        if ~all(all(abs(R'*R - eye(3)) < tol)) | ~(abs(det(R)-1) < tol)
            error('Ground truth pose is not calibrated');
        end
        R = P_ests{k}(:,1:3);
        if ~all(all(abs(R'*R - eye(3)) < tol)) | ~(abs(det(R)-1) < tol)
            error('Estimated pose is not calibrated');
        end
    end

    scores = {};
    for j = 1:length(objnames)
        scores{j} = eval_pose_estimate(P_gts{j}, P_ests{j}, bounding_boxes{j});
        disp(sprintf('%15s: %.2f pixels', objnames{j}, scores{j}));
    end
end

function score = eval_pose_estimate(P_gt, P_est, bounding_box)
    K = [572.4410, 0, 325.26110; 0, 573.57043, 242.04899; 0, 0, 1];
    corners = zeros(3, 8);
    corners(:,1) = [bounding_box.x(2); bounding_box.y(2); bounding_box.z(2)];
    corners(:,2) = [bounding_box.x(1); bounding_box.y(2); bounding_box.z(2)];
    corners(:,3) = [bounding_box.x(1); bounding_box.y(1); bounding_box.z(2)];
    corners(:,4) = [bounding_box.x(2); bounding_box.y(1); bounding_box.z(2)];
    corners(:,5) = [bounding_box.x(2); bounding_box.y(2); bounding_box.z(1)];
    corners(:,6) = [bounding_box.x(1); bounding_box.y(2); bounding_box.z(1)];
    corners(:,7) = [bounding_box.x(1); bounding_box.y(1); bounding_box.z(1)];
    corners(:,8) = [bounding_box.x(2); bounding_box.y(1); bounding_box.z(1)];

    proj_corners_gt = pflat(K * (P_gt(:,1:3)*corners + repmat(P_gt(:,4), 1, 8)));
    proj_corners_est = pflat(K * (P_est(:,1:3)*corners + repmat(P_est(:,4), 1, 8)));

    score = sqrt(mean(sum((proj_corners_gt(1:2,:) - proj_corners_est(1:2,:)).^2)));
end
