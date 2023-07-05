function normalized_correlation = fft2_correlator( input_image , pattern )

% normalized_correlation = fft2_correlator( input_image , pattern )
%
% The goal of this function is to find a given "pattern" in an image. This
% task is performed by applying the correlation measure. However, the
% implementation of correlation evaluation should be done by using the
% built-in 'fft2' (and 'ifft2') function of MATLAB. Note that we aim for 
% the normalized correlation measure; to clarify,let us consider a simple 
% 1D example:
%
%               input_image = [r s t u v w]         pattern = [a b c]
%
% Then, the result of the normalized correlation should be 
% 
%               correlation_result = [z1 z2 z3 z4 z5 z6]
%
%               z1  = (b*r    +    c*s) / (   (r^2+s^2)^0.5   * (a^2+b^2+c^2)^0.5 )
%               z2  = (a*r + b*s + c*t) / ( (r^2+s^2+t^2)^0.5 * (a^2+b^2+c^2)^0.5 )
%               z3  = (a*s + b*t + c*u) / ( (s^2+t^2+u^2)^0.5 * (a^2+b^2+c^2)^0.5 )
%               z4  = (a*t + b*u + c*v) / ( (t^2+u^2+v^2)^0.5 * (a^2+b^2+c^2)^0.5 )
%               z5  = (a*u + b*v + c*w) / ( (u^2+v^2+w^2)^0.5 * (a^2+b^2+c^2)^0.5 )
%               z6  = (a*v    +    b*w) / (   (v^2+w^2)^0.5   * (a^2+b^2+c^2)^0.5 )
%
%
%
% "pattern":
% is a known image pattern whose matches are sought in an image. "pattern" 
% should be 2D matrix representing the gray-scale version of the desired
% pattern. For this particular project, this is the image of a circle.
% 
% "input_image":
% is a 2D matrix representing the pixels of an image (the gray-scale 
% version). The size of this matrix should be larger than that of "pattern"
% that we look for similar copies of "pattern" inside "input_image".
%
% "correlation_result":
% is a 2D matrix with the same size as "input_image". Each element of this
% matrix stands for a normalized correlation value with a shifted "pattern". 
% The normalization implies that each element is between -1 to 1.


%--- Starting the function ---%

% make sure that format of the inputs are ok
if (length(size(input_image)) ~= 2)||(length(size(pattern)) ~= 2)
    error('!!! Error: Both of the inputs should be 2D matrices !!!')
end


figure_enable       = 1;        % this parameter determines whether to plot 
                                % the final result or not:
                                %       1: enable plotting
                                %       0: disable plotting

% The element of the input matrices which stand for image pixels might be 
% in "uint8" format which does not allow for usual decimal operations. 
% Therefore, they are first converted into "double" floating-point format.
% Moreover, we subtract the DC component of the "pattern" image from both 
% which is a common technique in image processing.
input_image_no_DC       = double(input_image) - mean(mean( double(pattern) ));
pattern_no_DC           = double(pattern) - mean(mean( double(pattern) ));


% size of the input image:
input_size              = size(input_image);

% size of the pattern:
pattern_size            = size(pattern);

% The correlation procedure is very similar to convolution, and therefore,
% can be implemented using DFT (2D DFT). However, to avoid undesired
% wrapp-around effects, we need to use a proper DFT size:
DFT_size                = input_size + pattern_size - [1 1];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                           %%%%%%%
% implementing the normalized correlations using 'fft2'                                %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            %%%%%%%
                                                                                       
% defining the output                                                                  
normalized_correlation  = zeros( input_size );                                         

fliped_pattern = flip(flip(pattern_no_DC, 1), 2);
input_image_fft = fft2(input_image_no_DC, DFT_size(1), DFT_size(2));
pattern_fft = fft2(fliped_pattern, DFT_size(1), DFT_size(2));

cross_power_spectrum = input_image_fft .* pattern_fft;

correlation_result = ifft2(cross_power_spectrum, DFT_size(1), DFT_size(2));

pattern_norm = norm(pattern_no_DC, 'fro');

temp = ones(pattern_size);
temp_fft = fft2(temp, DFT_size(1), DFT_size(2)); 
input_image2_fft = fft2(input_image_no_DC.^2, DFT_size(1), DFT_size(2));
input_image_norm = sqrt(ifft2(input_image2_fft .* temp_fft, DFT_size(1), DFT_size(2)));
normalized_correlation = correlation_result ./ (input_image_norm .* pattern_norm);


% crop the correlation result to match the size of the input image
padx = ceil(pattern_size(1)/2) - 1;
pady = ceil(pattern_size(2)/2) - 1;
normalized_correlation = normalized_correlation(padx:padx+input_size(1)-1,pady:pady+input_size(2)-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting the result
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figure_enable == 1
  
    figure
    imshow(abs(normalized_correlation))
    title('The output of the correlation using fft2 method')
end
