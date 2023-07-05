%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%               Part A.3                %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Finding circles in color images using %%%%%
%%%%%   fft2-based normalized correlation   %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%
% The standard procedure so far
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following function evaluates the normalized correlation values based
% on the built-in 'fft2' and 'ifft2' functions
normalized_correlation  = fft2_correlator( im_A_3_1 , pattern_im_A_3_1 );


% In general, the detected centers form dense clusters around the exact 
% locations. We unify the cluster into a single point by finding the local
% maxima. Since larger negative values also represent similarity in the
% opposite direction, we consider the absolute value of the correlations:
correlation_maxima      = local_maxima_finder( abs(normalized_correlation) );



% A local maxima somehow represent that a part in the image resembles more
% the structure of the pattern compared to its neighbours. However, this
% similarity might not be enough to qualify that part as a match. Thus, we
% need to threshold the correlation values to remove unintereting maxima:
qualified_maxima    = ( correlation_maxima  >  Threshold_A_3 );

% plotting the detectd match locations
if 0
    figure(32)
    mesh(double(qualified_maxima))
    title('Detected qualified centers')
end






% Drawing the detected circles
radius              = min( floor( size(pattern_im_A_3_1) / 2 ) );         % the radius of the circles according to the pattern
color               = 0;
image_with_circles  = circle_plot(im_A_3_1_color , find(qualified_maxima==1) , radius , color);

figure(33)
imshow(image_with_circles);
title('Detected circles using the fft2 method (color image)')

hgsave([Figure_path , 'color_fft2_corr_detect.fig']);
imwrite(image_with_circles , 'Results/color_fft2_corr_detect.jpg')















%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The previous procedure applied on image gradients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We replace images with their black and white derivatives (edges)
im_A_3_2                = edge(im_A_3_1 , 'canny');
pattern_im_A_3_2        = edge(pattern_im_A_3_1 , 'canny');


figure(34)
imshow(im_A_3_2)
title('Derivative of the color image')



% The following function evaluates the normalized correlation values based
% on the built-in 'fft2' and 'ifft2' functions
normalized_correlation  = fft2_correlator( im_A_3_2 , pattern_im_A_3_2 );


% In general, the detected centers form dense clusters around the exact 
% locations. We unify the cluster into a single point by finding the local
% maxima. Since larger negative values also represent similarity in the
% opposite direction, we consider the absolute value of the correlations:
correlation_maxima      = local_maxima_finder( abs(normalized_correlation) );



% A local maxima somehow represent that a part in the image resembles more
% the structure of the pattern compared to its neighbours. However, this
% similarity might not be enough to qualify that part as a match. Thus, we
% need to threshold the correlation values to remove unintereting maxima:
qualified_maxima    = ( correlation_maxima  >  Threshold_A_3 );

% plotting the detectd match locations
if 0
    figure(35)
    mesh(double(qualified_maxima))
    title('Detected qualified centers')
end






% Drawing the detected circles
radius              = min( floor( size(pattern_im_A_3_2) / 2 ) );         % the radius of the circles according to the pattern
color               = 0;
image_with_circles  = circle_plot(im_A_3_1_color , find(qualified_maxima==1) , radius , color);

figure(36)
imshow(image_with_circles);
title('Detected circles using the fft2 method (color image)')

hgsave([Figure_path , 'color_derivative_fft2_corr_detect.fig'])
imwrite(image_with_circles , 'Results/color_derivative_fft2_corr_detect.jpg')

