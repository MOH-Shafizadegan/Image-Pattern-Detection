%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                Part B                 %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Finding circles with different sizes  %%%%%
%%%%%  in color images using FCD algorithm  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Smoothing the imaging before finding its gradient
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% By smoothing the imaging, we soften the edges and remove possible spikes
% from its derivative. This procedure is frequenctly used in image
% processing. The smoothing is performed by convolving the image with a
% given window (Gaussian, rectandular, etc)
window_length               = 7;
window                      = ones(window_length) / window_length^2;
im_B_smooth                 = imfilter(im_B , window , 'symmetric');



% image gradient: we need both the direction and magnitude of the gradient.
% To show the impact of smoothing, we find the gradients of the original
% image as well as the smoothed
[Grad_mag_orig , Grad_dir_orig]     = imgradient(  im_B  );          % 'Grad_dir' contains the angles in degrees
[Grad_mag_smth , Grad_dir_smth]     = imgradient(  im_B_smooth  );   % 'Grad_dir' contains the angles in degrees

% Plotting the results
figure(41)
    %
subplot(2 , 2 , 1)
imshow(im_B)
title('Original image (gray-scale)')
    %
subplot(2 , 2 , 3)  
imshow(Grad_mag_orig , [0 , 160])  ;
title('Gradient-magnitude of the original image');
    %
subplot(2 , 2 , 2)
imshow(im_B_smooth)
title('Smoothed image (gray-scale)')
    %
subplot(2 , 2 , 4)  
imshow(Grad_mag_smth , [0 , 160])  ;
title('Gradient-magnitude of the smoothed image');



figure(42)
    %
subplot(2 , 1 , 1)
surf(Grad_mag_orig , 'EdgeColor' , 'none');
title('Gradient-magnitude of the original image (3D view)');
    %
subplot(2 , 1 , 2)
surf(Grad_mag_smth , 'EdgeColor' , 'none');
title('Gradient-magnitude of the original image (3D view)');






%%%%%%%%%%
% Point screening
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The points at which the gradient is small in magnitude belong to smooth
% regions; however, our method requires the points on edges, which possibly
% have large gradient magnitues. Below, we discrad those with small
% gradient magnitude to expedite the search algorithm in the next step. The
% result of the following function is a 4*n matrix, whereas each column
% corresponds to an edge point; the frist two elements in each column
% encode the location of the point (column and row indices), while the last
% two indicate the gradient magnitude and direction, respectively.
mag_Threshold               = 1/3 * max(max(Grad_mag_smth));
qualified_points            = point_screening(Grad_mag_smth , Grad_dir_smth , mag_Threshold);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementing the gradient-pair method to locate circles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
degree_tolerance            = 0.3;      % tolerance of the detection in degrees
center_radius               = circle_locator(qualified_points , size(im_B) , degree_tolerance);













%%%%%%%%%%%%%%%%%%
% Removing extra-detected circles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% In general, the detected centers/radia form dense clusters around the exact 
% locations. We unify the cluster into a single point by finding the local
% maxima. Note that a point could be the center of multiple circles.
center_radius_redcd         = circle_prunning( center_radius , repetition_Thresh );










%%%%%%%%%%%
% Drawing the circles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
color                       = 255;      % [0 ... 255] => [black ... white]
image_with_circles          = multi_radii_circle_plot(im_B_color , center_radius_redcd , color);


figure(46)
imshow(image_with_circles);
title('Detected circles using gradient-pair method (color image)')

hgsave([Figure_path , 'Detection_by_FCD.fig']);
imwrite(image_with_circles , 'Results/Detection_by_FCD.jpg');