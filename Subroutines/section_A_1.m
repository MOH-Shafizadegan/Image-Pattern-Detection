%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%               Part A.1                %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Finding circles in a gray image using %%%%%
%%%%%   direct evaluation of normalized     %%%%%
%%%%%              correlation              %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% The following function evaluates the normalized correlation values based
% on the built-in 'fft2' and 'ifft2' functions
normalized_correlation  = direct_correlator( im_A_1 , pattern_im_A_1 );


% In general, the detected centers form dense clusters around the exact 
% locations. We unify the cluster into a single point by finding the local
% maxima. Since larger negative values also represent similarity in the
% opposite direction, we consider the absolute value of the correlations:
correlation_maxima      = local_maxima_finder( abs(normalized_correlation) );



% A local maxima somehow represent that a part in the image resembles more
% the structure of the pattern compared to its neighbours. However, this
% similarity might not be enough to qualify that part as a match. Thus, we
% need to threshold the correlation values to remove unintereting maxima:
qualified_maxima    = ( correlation_maxima  >  Threshold_A_1 );

% plotting the detectd match locations
if 0
    figure(12)
    mesh(double(qualified_maxima))
    title('Detected qualified centers')
end






% Drawing the detected circles
radius              = min( floor( size(pattern_im_A_1) / 2 ) );         % the radius of the circles according to the pattern
color               = 0;
image_with_circles  = circle_plot(im_A_1 , find(qualified_maxima==1) , radius , color);

figure(13)
imshow(image_with_circles);
title('Detected circles using the direct method')

hgsave([Figure_path , 'direct_corr_detect.fig']);
imwrite(image_with_circles , 'Results/direct_corr_detect.jpg');
