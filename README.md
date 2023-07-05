# Image-Pattern-Detection
Detecting provided patterns in a given image implemented in MATLAB. This project is the final project of DSP course of Sharif University of Technology at semester 14012.

## Introduction
In many image processing applications we are seeking for pattern detection. In this project the pattern is circle which is not sensitive to rotation. One of the application of circle detection is detecting circle like cells in microscopic images.

## Project contents
In this project, we will use two different approach for circle detection :
- The radius of the circle is known. In this case we are looking for circles with same size of the pattern. Other circles with different size should not be detected.
- The circle radius is unknown. We are looking for all circles with different sizes.

In the first approach, the locations where the pattern matches the original image will be computed using correlation. In order to implement correlation we have used both direct formula of correlation and the faster method FFT and IFFT.

In the second approach, we have used the Gradient pairs method to detect circles.

## How to run the project
In order to run different parts and subroutins of the project, you should simply modify the "Part_Enable" variable in line 37 of "main.m" 

### Attachments
There is also a pdf file which contains the report of the project and all the explenation of the code.
