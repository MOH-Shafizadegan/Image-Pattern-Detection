function image_with_circles = circle_plot(input_image , centers , radius , color)

% image_with_circles = circle_plot(input_image , centers , radius)
%
% This function draws the points on the perimeter of cenrtain circles on
% top of a given image. The circles are centered at locations indicated by
% the input "centers" using the linear indexing system relative to the
% input "image_input". For instance, if "image_input" is a 10*10 image and
% we would like to draw a cricle centered around its (3,4) element, the
% input "centers" shall contain the value 33.
%
% "input_image":
% is a 2D matrix representing the pixels of an image
%
% "centers":
% is a vector containing the location of circle centers in the linear
% indexing system; i.e., each center is in fact one of the pixels of the
% image, however, instead of the [row,col] indexing format, we are using
% the the linear indexing.
%
% "radius":
% is an integer determining the radius of the circles in terms of  the 
% number of pixels (all drawn circles will of the same size).
%
% "color":
% is an integer between 0 and 255; this value is used for the color of
% drawn circles. The values of 0 and 255 result in black and white
% respectively, and any value in between is associated with a gray level.



image_with_circles      = input_image;

% size of the input image:
input_size              = size(input_image);



% row and column indices (integer) of a circle centered at (0,0)
row_ind_raw         = - floor(radius)  :  floor(radius) ;
col_ind_raw         = round( sqrt( radius^2 - row_ind_raw.^2 ) );

row_ind             = [row_ind_raw  row_ind_raw     col_ind_raw     -col_ind_raw];
col_ind             = [col_ind_raw  -col_ind_raw    row_ind_raw     row_ind_raw];



% sweeping over all possible centers
for circle_ind = 1 : length(centers)
    [row_c , col_c]     = ind2sub(input_size(1:2) , centers(circle_ind));
    
    row_c_ind           = row_c + row_ind;
    col_c_ind           = col_c + col_ind;
    
    % checking the range
    inbound_range       = ( row_c_ind > 0 )&( row_c_ind <= input_size(1) )&( col_c_ind > 0 )&( col_c_ind <= input_size(2) );
    row_c_ind           = row_c_ind( inbound_range );
    col_c_ind           = col_c_ind( inbound_range );
    
    
    circle_pixels       = sub2ind(input_size(1:2) , row_c_ind , col_c_ind);
    
    for color_ind = 1 : size(input_image , 3)
        aux             = image_with_circles(: , : , color_ind);
        aux(circle_pixels)                      = color;
        image_with_circles(: , : , color_ind)   = aux;
    end
end