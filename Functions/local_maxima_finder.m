function result = local_maxima_finder( matrix_2D )

% result = local_maxima_finder( matrix_2D )
%
% This function tries to locate the local maxima of a 2D matrix (image).
% The output is such that all entries are set to zero except those that are
% larger (or equal) than their neighbours. Here, the neighbour is defined as
% an m*m square surronding the pixel of interest.
%
% "matrix_2D":
% is a two-dimensional matrix containing the values (e.g., the pixels of an
% image).
% 
% "result":
% is the same as "matrix_2D" except that all non-local-maxima are set to 
% zero; i.e., local maxima maintain their values while the rest become zero
%
% ------------------------------------------------------------------------
% -- In this project, "matrix_2D" corresponds to the correlation values --
% -- and each local maximum indicates a possible match with the pattern --
% ------------------------------------------------------------------------


length_mask         = 9;        % "m" in the above description for determining 
                                % the neibourhood
                                % An entry is considered a local maximum if 
                                % it is not less than the entries inside an
                                % m*m square with the entry of interest in
                                % the center
Half_length         = floor(length_mask / 2);

                                
                                
[row , col]         = size(matrix_2D);
result              = zeros(row , col);

% we slide an m*m quare over the matrix to determine the local maxima
for row_ind = 1: row
    for col_ind = 1 : col
        
        % the row and column indices of the entries inside the m*m square
        row_vec     = max(1 , row_ind - Half_length) : min(row , row_ind + Half_length);
        col_vec     = max(1 , col_ind - Half_length) : min(col , col_ind + Half_length);
        
        % The maximum value inside the m*m square
        aux         = max(max( matrix_2D(row_vec , col_vec) ));
        
        % checking whether the center equals the maximum value
        if aux == matrix_2D(row_ind , col_ind)
            result(row_ind , col_ind)       = matrix_2D(row_ind , col_ind);
        end
        
        
    end
end