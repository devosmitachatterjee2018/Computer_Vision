% 
% Displays the image im, and also draws bounding boxes for the provided
% objects. P_gts, P_ests are cell arrays with ground truth and estimated poses.
% If subplots are desired, you may create a subplot with subplot_handle = subplot(3,3,1),
% and pass subplot_handle as the final argument to this function. Note that subplot_handle = subplot(331) does not work.
% 
function draw_bounding_boxes(im, P_gts, P_ests, bounding_boxes, subplot_handle)
    if nargin < 5
        figure;
        subplot_handle = subplot(1,1,1);
    end

    K = [572.4410, 0, 325.26110; 0, 573.57043, 242.04899; 0, 0, 1];

    for k = 1:length(bounding_boxes)
        tol = 1e-3;
        R = P_gts{k}(:,1:3);
        if ~all(all(abs(R'*R - eye(3)) < tol)) | ~(abs(det(R)-1) < tol)
            max(max(abs(R'*R - eye(3))))
            abs(det(R)-1)
            error('Ground truth pose is not calibrated');
        end
        R = P_ests{k}(:,1:3);
        if ~all(all(abs(R'*R - eye(3)) < tol)) | ~(abs(det(R)-1) < tol)
            error('Estimated pose is not calibrated');
        end
    end

    % imshow(im);
    imshow(im, 'Parent', subplot_handle);
    hold on; 

    % Loop over all objects and display each of them, both ground-truth and
    % estimates poses 
    for k = 1:length(bounding_boxes)
        % First, find the eight corners of the bounding box in the local
        % coordinate system in 3D 
        corners = zeros(3, 8); 
        corners(:,1) = [bounding_boxes{k}.x(2); bounding_boxes{k}.y(2); bounding_boxes{k}.z(2)]; 
        corners(:,2) = [bounding_boxes{k}.x(1); bounding_boxes{k}.y(2); bounding_boxes{k}.z(2)]; 
        corners(:,3) = [bounding_boxes{k}.x(1); bounding_boxes{k}.y(1); bounding_boxes{k}.z(2)]; 
        corners(:,4) = [bounding_boxes{k}.x(2); bounding_boxes{k}.y(1); bounding_boxes{k}.z(2)]; 
        corners(:,5) = [bounding_boxes{k}.x(2); bounding_boxes{k}.y(2); bounding_boxes{k}.z(1)]; 
        corners(:,6) = [bounding_boxes{k}.x(1); bounding_boxes{k}.y(2); bounding_boxes{k}.z(1)]; 
        corners(:,7) = [bounding_boxes{k}.x(1); bounding_boxes{k}.y(1); bounding_boxes{k}.z(1)]; 
        corners(:,8) = [bounding_boxes{k}.x(2); bounding_boxes{k}.y(1); bounding_boxes{k}.z(1)]; 
        
        lightBlue = [91, 207, 244] / 255; 
        % Now, project this into the image using the ground truth pose
        U = P_gts{k}(:,1:3)*corners + repmat(P_gts{k}(:,4), 1, 8); 
        U = pflat(K*U); 
        xs = [U(1,1), U(1, 2), U(1, 3), U(1,4), U(1,5), U(1,6), U(1,7), U(1,8), U(1,1), U(1,2), U(1,3), U(1,4); U(1,2), U(1, 3), U(1,4), U(1,1), U(1,6), U(1,7), U(1,8), U(1,5), U(1,5), U(1,6), U(1,7), U(1,8)];  
        ys = [U(2,1), U(2,2), U(2,3), U(2,4), U(2,5), U(2,6), U(2,7), U(2,8), U(2,1), U(2,2), U(2,3), U(2,4); U(2,2), U(2,3), U(2,4), U(2,1), U(2,6), U(2,7), U(2,8), U(2,5), U(2,5), U(2,6), U(2,7), U(2,8)]; 
        % line(xs, ys, 'LineWidth', 2, 'Color', lightBlue);
        line(subplot_handle, xs, ys, 'LineWidth', 2, 'Color', lightBlue);
        
        % Also project the box using the estimated pose 
        U = P_ests{k}(:,1:3)*corners + repmat(P_ests{k}(:,4), 1, 8); 
        U = pflat(K*U); 
        xs = [U(1,1), U(1, 2), U(1, 3), U(1,4), U(1,5), U(1,6), U(1,7), U(1,8), U(1,1), U(1,2), U(1,3), U(1,4); U(1,2), U(1, 3), U(1,4), U(1,1), U(1,6), U(1,7), U(1,8), U(1,5), U(1,5), U(1,6), U(1,7), U(1,8)];  
        ys = [U(2,1), U(2,2), U(2,3), U(2,4), U(2,5), U(2,6), U(2,7), U(2,8), U(2,1), U(2,2), U(2,3), U(2,4); U(2,2), U(2,3), U(2,4), U(2,1), U(2,6), U(2,7), U(2,8), U(2,5), U(2,5), U(2,6), U(2,7), U(2,8)]; 
        % line(xs, ys, 'LineWidth', 2, 'Color', 'b');
        line(subplot_handle, xs, ys, 'LineWidth', 2, 'Color', 'b');
    end

    hold off;

end
