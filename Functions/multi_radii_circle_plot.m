function image_with_circles = multi_radii_circle_plot(input_image , center_radius , color)

% image_with_circles = circle_plot(input_image , centers , radius)
%
% This function draws the points on the perimeter of cenrtain circles on
% top of a given image. The information regarding the center and radius of
% these circles is stored in the 3D matrix "center_radius". In general,
% each pixel can be the center of multiple circles with different radii.
%
% "input_image":
% is a 2D matrix representing the pixels of an image
%
% "center_radius":
% is a 3D matrix contating all possible center/radius candidates. In more 
% details, "center_radius" is an r*c*l matrix where r,c are the size of 
% "input_image". The (i,j,k) element of the output indicates the radius of 
% a circle for which the point (i,j) of the image was selected as the 
% center for the k'th time. If (i,j) is selected less than k times as a 
% center, this element shall be 0 (a circle with 0 radius). 
%
% "color":
% is an integer between 0 and 255; this value is used for the color of
% drawn circles. The values of 0 and 255 result in black and white
% respectively, and any value in between is associated with a gray level.


% defining the output; the base is the original image
image_with_circles  = input_image;


% check for circles
all_circles         = find(center_radius > 0);

if size(center_radius , 3) ~= 1
    
    for circle_ind = 1 : length(all_circles)
        [row , col , rep]   = ind2sub( size(center_radius) , all_circles(circle_ind) );
        center              = sub2ind([size(input_image,1) , size(input_image,2)]  ,  [row]  ,  [col]);
        image_with_circles  = circle_plot(image_with_circles , center , center_radius( all_circles(circle_ind) ) , color);
    end
    
else
    
    for circle_ind = 1 : length(all_circles)
        center              = all_circles(circle_ind);
        image_with_circles  = circle_plot(image_with_circles , center , center_radius( all_circles(circle_ind) ) , color);
    end
    
end