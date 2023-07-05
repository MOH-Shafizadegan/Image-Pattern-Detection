%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%               Part A.2                %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Finding circles in a gray image using %%%%%
%%%%%   fft2-based normalized correlation   %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% The following function evaluates the normalized correlation values based
% on the built-in 'fft2' and 'ifft2' functions
normalized_correlation  = fft2_correlator( im_A_2 , pattern_im_A_2 );


% In general, the detected centers form dense clusters around the exact 
% locations. We unify the cluster into a single point by finding the local
% maxima. Since larger negative values also represent similarity in the
% opposite direction, we consider the absolute value of the correlations:
correlation_maxima      = local_maxima_finder( abs(normalized_correlation) );



% A local maxima somehow represent that a part in the image resembles more
% the structure of the pattern compared to its neighbours. However, this
% similarity might not be enough to qualify that part as a match. Thus, we
% need to threshold the correlation values to remove unintereting maxima:
qualified_maxima    = ( correlation_maxima  >  Threshold_A_2 );

% plotting the detectd match locations
if 0
    figure(22)
    mesh(double(qualified_maxima))
    title('Detected qualified centers')
end






% Drawing the detected circles
radius              = min( floor( size(pattern_im_A_2) / 2 ) );         % the radius of the circles according to the pattern
color               = 0;
image_with_circles  = circle_plot(im_A_2 , find(qualified_maxima==1) , radius , color);

figure(23)
imshow(image_with_circles);
title('Detected circles using the fft2 method')

hgsave([Figure_path , 'fft2_corr_detect.fig'])
imwrite(image_with_circles , 'Results/fft2_corr_detect.jpg')
