function center_radius_redcd = circle_prunning( center_radius , repetition_Thresh )
%
% center_radius_redcd = circle_prunning( center_radius , repetition_Thresh )
%
% "center_radius":
% is a 3D matrix contating all possible center/radius candidates. In more 
% details, "center_radius" is an r*c*l matrix where r,c are the size of the
% input image. The (i,j,k) element of the output indicates the radius of a 
% circle for which the point (i,j) of the image was selected as the center 
% for the k'th time. If (i,j) is selected less than k times as a center, 
% this element is set to 0 (a circle with 0 radius). 
%
% "repetition_Thresh":
% if a circle is selected less than 'repetition_Thresh' times it will be 
% considered as mis-detection and discraded. This threshold both simplifies
% the search and avoids false alarms. If no prior is known, set it to 20.
%
% "center_radius_reduced":
% is again a 3D matrix containing the center/radius information of the
% circles. However, many of the elements in "center_radius" are discarded
% to unify the circles close to one another.

                                                            %-------------------*
length_window       = 9;        % We search for the probable centers by         |
                                % testing whether they are maximally            | 
                                % selected compared to their neibourhood.       |     
                                % This parameters sets the neibourhood size     | 
Half_length         = floor(length_window / 2);                                %| 
                                                            %-------------------*
                                
   
                                                            
                                                            
% size of the input             ------------------------------------------------*                            
row                 = size(center_radius , 1);                                 %|
col                 = size(center_radius , 2);                                 %|
                                                                               %|
                                                                               %|
% defining the output                                                          %|
center_radius_redcd = zeros(size(center_radius));                              %|
                                                                               %|
% the number of times each point is selected as a center                       %|
selection_counter   = zeros(row , col);                                        %|
                               %------------------------------------------------*



% we slide a square window over the matrix to determine the local maxima
h   = waitbar(0 , 'Circle Prunning');
for row_ind = 1: row
    waitbar( row_ind / row )
    for col_ind = 1 : col
        
        % the row and column indices of the entries inside the window -----------------------*
        row_vec     = max(1 , row_ind - Half_length) : min(row , row_ind + Half_length);    %|
        col_vec     = max(1 , col_ind - Half_length) : min(col , col_ind + Half_length);    %|
                                                                                            %|
        % center of the window                                                              %| 
        row_center  = row_ind + 1 - max(1 , row_ind - Half_length);                         %|
        col_center  = col_ind + 1 - max(1 , col_ind - Half_length);                         %|
                                                        %------------------------------------*
        
        
        % the radius of all the detected circles whose centers fall in this window ----------*
        aux1        = center_radius(row_vec , col_vec , :);                                 %|
                                                                                            %|
        % removing empty circles                                                            %|
        aux2        = aux1(aux1 > 0);                                                       %|
                                %------------------------------------------------------------*
        
        
        if length(aux2) >= repetition_Thresh    % check whether this window contains any realistic circles
            
            % finding the radii that appear most in this window  --------------------*
            radius_bins     = [floor(2 * min(aux2)) : ceil(2 * max(aux2))] / 2;     %|
            freq            = hist(aux2 , radius_bins);                             %|
            freq            = conv(freq , ones(1 , 2*length_window+1) , 'same');    %|
                                                                                    %|
            [pks , locs]    = findpeaks(freq);                                      %|
            frequent_radii  = radius_bins( locs( pks >= repetition_Thresh ) );      %|
                                                                %--------------------*
            
            % check whether the best center for each of the circles with the
            % above radii coincides with the center of the window
            for radius_ind = 1 : length(frequent_radii)
                radius      = frequent_radii(radius_ind);
                aux3        = sum( ( aux1 >= radius-Half_length )&( aux1 <= radius+Half_length )   ,  3);
                
                if (max(max(aux3)) >= repetition_Thresh)&(max(max(aux3)) == aux3(row_center , col_center))
                    selection_counter(row_ind , col_ind)    = selection_counter(row_ind , col_ind) + 1;
                    center_radius_redcd(row_ind , col_ind , selection_counter(row_ind , col_ind))   = radius;
                end
            end
            
        end
        
        
    end
end
close(h)


% simplifying the output by removing unnesessary zeros
if max(max(selection_counter)) == 0         % no circles detected
    center_radius_redcd     = [];
else
    center_radius_redcd     = center_radius_redcd(:  ,  :  ,  1 : max(max(selection_counter)));
end