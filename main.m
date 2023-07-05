% This is the main file which should be run to produce the outputs. If this
% is your first time with MATLAB, either press F5 or click on the green
% triangular button (RUN).
%
% You should not change the content of this file. Your main task is to edit
% the functions
%
%       "direct_correlator.m",
%       "fft2_correlator.m", and
%       "circle_locator.m"
%
% located in "DSP MATLAB HW Package/Functions/". Please avoid modifying
% other files.
%
% To run each part of the excercise, change "Part_Enable" accordingly and
% then run again.

%%
% This part is to clear the command window, remove all the pre-defined
% parameters and close all open figures
clc
clear all
close all

% Adding the functions and inut-images path to matlab directory
addpath('functions');
addpath('input-images');
addpath('Subroutines');


% The path for saving the figures
Figure_path     = [pwd , '/Results/'];




Part_Enable     = 'B';     % Possible choices are:
                            %   'A1' : known circle detection in gray-scale 
                            %          images using direct-based correlation
                            %   'A2' : known circle detection in gray-scale 
                            %          images using fft2-based correlation
                            %   'A3' : known circle detection in color 
                            %          images using fft2-based correlation
                            %   'B'  : unknown circle detection in color 
                            %          images using FCD method








switch Part_Enable
    
    case 'A1'
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%               Part A.1                %%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%% Finding circles in a gray image using %%%%%
        %%%%%   direct evaluation of normalized     %%%%%
        %%%%%              correlation              %%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Reading the main image and the known circle pattern:
        im_A_1              = imread( 'im_A_1.jpg' );               % main image (possibly RGB format)
        pattern_im_A_1      = imread( 'pattern_im_A_1.jpg' );       % the known circle pattern
        
        im_A_1              = rgb2gray(  im_A_1  );                 % converting RGB to gray-scale format
        
        
        Threshold_A_1       = 0.8;      % The threshold on the value of the correlation to detect a match
        
        % Running the required procedure (you can access this script in the
        % 'subroutines' folder, however, avoid editing)
        tic
        section_A_1
        T_A1                = toc;
        disp(['!!! The time spent in Part A1 is ' , num2str(T_A1) , ' seconds !!!'])
        
        
        
        
       
    case 'A2'
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%               Part A.2                %%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%% Finding circles in a gray image using %%%%%
        %%%%%   fft2-based normalized correlation   %%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Reading the image and its pattern:
        im_A_2              = imread( 'im_A_2.jpg' );               % main image (possibly RGB format)
        pattern_im_A_2      = imread(  'pattern_im_A_2.jpg'  );     % the known circle pattern
        
        im_A_2              = rgb2gray( im_A_2 );                   % converting RGB to gray-scale format
        pattern_im_A_2      = rgb2gray(  pattern_im_A_2  );         % converting RGB to gray-scale format
        
        
        Threshold_A_2       = 0.8;      % The threshold on the value of the correlation to detect a match
        
        % Running the required procedure (you can access this script in the
        % 'subroutines' folder, however, avoid editing)
        tic
        section_A_2
        T_A2                = toc;
        disp(['!!! The time spent in Part A2 is ' , num2str(T_A2) , ' seconds !!!'])
        
        
        
        
        
    case 'A3'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%               Part A.3                %%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%% Finding circles in color images using %%%%%
        %%%%%   fft2-based normalized correlation   %%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Reading the image and its pattern:
        im_A_3_1_color      = imread( 'im_A_3.jpg' );               % main image (possibly RGB format)
        pattern_im_A_3_1    = imread(  'pattern_im_A_3.jpg'  );     % the known circle pattern
        
        im_A_3_1            = rgb2gray( im_A_3_1_color );           % converting RGB to gray-scale format
        pattern_im_A_3_1    = rgb2gray(  pattern_im_A_3_1  );       % converting RGB to gray-scale format
        
        
        Threshold_A_3       = 0.4;      % The threshold on the value of the correlation to detect a match
        
        % Running the required procedure (you can access this script in the
        % 'subroutines' folder, however, avoid editing)
        tic
        section_A_3
        T_A3                = toc;
        disp(['!!! The time spent in Part A3 is ' , num2str(T_A3) , ' seconds !!!'])
        
        
        
        
        
        
    case 'B'
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%                Part B                 %%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%% Finding circles with different sizes  %%%%%
        %%%%%  in color images using FCD algorithm  %%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        % Reading the image and its pattern:
        im_B_color          = imread( 'eye.jpg' );                  % main image (possibly RGB format)
        im_B                = rgb2gray( im_B_color );               % converting RGB to gray-scale format
        
        
        
        repetition_Thresh   = 20;       % If a point is detected as a center for less
        % than 'repetition_Thresh' pairs, then it will
        % be ignored.
        
        
        % Running the required procedure (you can access this script in the
        % 'subroutines' folder, however, avoid editing)
        tic
        section_B
        T_B                 = toc;
        disp(['!!! The time spent in Part B is ' , num2str(T_B) , ' seconds !!!'])
        
        
end