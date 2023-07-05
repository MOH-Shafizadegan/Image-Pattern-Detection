function normalized_correlation = direct_correlator( input_image , pattern )

% normalized_correlation = direct_correlator( input_image , pattern )
%
% The goal of this function is to find a given "pattern" in an image. This
% task is performed by applying the correlation measure. Note that we aim 
% for the normalized correlation values; to clarify,let us consider a 
% simple 1D example:
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
%
%
%   [Hint]: you may need to extend the main image in both dimensions to
%           take care of the borders




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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                           %%%%%%%
% implementing the normalized correlations (direct method)                             %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            %%%%%%%

% defining the output                                                                  
normalized_correlation  = zeros( input_size );                                         
extended_input = padarray(input_image_no_DC, floor(pattern_size / 2), 0, 'both');

pattern_norm = norm(pattern_no_DC, 'fro');

% main loops for sliding the pattern over the input image                              
h   = waitbar(0 , 'Direct evaluation of the correlation');                             
for row_ind = 1 : input_size(1)                                                        
    waitbar( row_ind / input_size(1) )
    
    for col_ind = 1 : input_size(2)
       sub_matrix = extended_input(row_ind:row_ind+pattern_size(1)-1,...
                                    col_ind:col_ind+pattern_size(2)-1);
       dot_product = sum(sub_matrix .* pattern_no_DC, 'all');
       sub_matrix_norm = norm(sub_matrix, 'fro');
       normalized_correlation(row_ind,col_ind) = dot_product / (sub_matrix_norm * pattern_norm);
    end
                                                                                           
end                                                                                    
close(h)                                                                               

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting the result
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if figure_enable == 1
  
    figure
    imshow(abs(normalized_correlation))
    title('The output of the correlation using direct method')
end
