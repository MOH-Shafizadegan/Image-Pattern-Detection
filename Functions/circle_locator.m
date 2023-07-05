function center_radius = circle_locator(edge_points , image_size , degree_tolerance)
%
% center_radius = circle_locator(edge_points , image_size , degree_tolerance)
%
% This function implements the gradient-pair method for detecting circles
% in an image. The basis of the method is the following fact:
%
%       the diagonally opposite points on the perimeter of a circle
%       have the same gradient orientation but opposite direction,
%       while the orientation coincides with the line connecting them.
%
% Therefore, is this method, we check the gradient direction of all edge 
% point pairs of the image to see whether they satisfy the above
% constraint. In the positive case, their middle point is a candidate for a
% circle center while half the connecting length is a potential radius. The
% output of this function is a 3D matrix contating all possible
% center/radius candidates. In more details, the output is an r*c*250
% matrix where r,c are the size of the input image. The (i,j,k) element of
% the output indicates the radius of a circle for which the point (i,j) of 
% the image was selected as the center for the k'th time. If (i,j) is
% selected less than k times as a center, this element is set to 0 (a circle 
% with 0 radius). In fact, 250 is an upper-bound on the number of times a
% point could be selected as a center.
%
% "edge_points":
% is the 4*n matrix where 'n' is the number of detected edge pixels/points. 
% Each column of this matrix respectively contains the row, column, gradient 
% magnitude, and gradient direction (in degrees) of a pixel passing the
% threshold test.
%
% "image_size":
% is a 1*2 vector of positive integers representing the size of the input
% image.
%
% "degree_tolerance":
% is a positive real number that indicates the tolerance in degrees for
% identifying the points with similar gradient directions. In simple words,
% instead of the points having exactly the same gradient directions, we
% allow for small deviations (e.g., 1 degree).
%
% 
% "center_radius":
% is a 3D matrix contating all possible center/radius candidates. In more 
% details, "center_radius" is an r*c*250 matrix where "image_size = [r,c]".
% The (i,j,k) element of "center_radius" indicates the radius of a circle 
% for which the point (i,j) of the image serves as the center for the k'th 
% time. If (i,j) is selected less than k times as a center, this element is 
% set to 0 (a circle with 0 radius). In fact, 250 is an upper-bound on the 
% number of times a point could be selected as a center.

% defining the output
center_radius               = zeros( image_size(1) , image_size(2) , 250);

% the number of times each point is selected as a center
selection_counter           = sum(sign(center_radius) , 3);


% for checking the edge point pairs, we sweep over all points                          
h   = waitbar(0 , 'Gradient-pair method');                                             
for edge_points_ind = 1 : size(edge_points , 2)-1                                      
    waitbar( edge_points_ind / (size(edge_points , 2)-1) )                             
    % getting the current edge point
    current_point = edge_points(:,edge_points_ind);

    % getting the remaining edge points
    remaining_points = edge_points(:,edge_points_ind+1:end);

    idx_filt1 = abs(mod(remaining_points(4,:) - current_point(4) + 180, 360) - 360) < degree_tolerance;
    idx_filt2 = abs(mod(remaining_points(4,:) - current_point(4) + 180, 360)) < degree_tolerance;
    idx_filt3 = abs(remaining_points(3,:) - current_point(3)) < 10;
    similar_points = remaining_points(:,(idx_filt1 | idx_filt2) & idx_filt3  );

    % for each similar point, compute the center and radius of the circle passing through them
    for similar_point_ind = 1 : size(similar_points , 2)
        % getting the similar point
        similar_point = similar_points(:,similar_point_ind);

        % computing the center of the circle
        center_x = round((current_point(1) + similar_point(1))/2);
        center_y = round((current_point(2) + similar_point(2))/2);
        
        % computing the radius of the circle
        radius = sqrt((current_point(1) - similar_point(1))^2 + (current_point(2) - similar_point(2))^2)/2;

        % updating the output matrix with the center and radius
        selection_counter(center_x , center_y) = selection_counter(center_x , center_y) + 1;
        center_radius(center_x , center_y , selection_counter(center_x , center_y)) = radius;
    end                                                                             
end                                                                                    
close(h)                                                                               
