function edge_points = point_screening(Grad_magnitude , Grad_direction , magnitude_Threshold)
%
% edge_points = point_screening(Grad_magnitude , Grad_direction , magnitude_Threshold)
%
% Based on the gradient magnitude of an image, this function selects likely 
% pixels on the edges. The selection criterion is the gradient magnitude
% being above a given threshold. The output is a 4*n matrix where 'n' is 
% the number of detected edge pixels. Each column of the output contains
% the row/column information of the corresponding esdge pixel, as well as
% its gradient magnitude and direction.
%
% "Grad_magnitude":
% is 2D matrix with the same size as the image. This matrix contains the
% magnitude of the gradient at each pixel.
%
% "Grad_direction":
% is 2D matrix with the same size as the image (i.e., 'Grad_magnitude' and 
% 'Grad_direction' should be of the same size). This matrix contains the
% direction of the gradient at each pixel (angles in degrees).
%
% "magnitude_Threshold":
% is a positive real number used as the threshold for separating the edge
% pixels from the rest.
%
%
% "edge_points":
% is the 4*n output where 'n' is the number of detected edge pixels. Each 
% column of this matrix respectively contains the row, column, gradient 
% magnitude, and gradient direction (in degrees) of a pixel passing the
% threshold test.



% finding the point passing the gradient magnitude test
above_threshold_indices     = find( Grad_magnitude >= magnitude_Threshold );

% row/column indices of the selected points
[row_ind , col_ind]         = ind2sub( size(Grad_magnitude) , above_threshold_indices );

% defining the output
edge_points                 = [row_ind.' ; ...
                               col_ind.' ; ...
                               Grad_magnitude(above_threshold_indices).' ; ...
                               Grad_direction(above_threshold_indices).' ];