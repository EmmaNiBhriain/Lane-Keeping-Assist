I  = imread('images/unmarked_road_2.jpg'); 
I=rgb2gray(I); 

%--------------------------------------------------------------------------
%     Apply Gaussian Filtering with various standard deviations
%--------------------------------------------------------------------------
Iblur1 = imgaussfilt(I,1); % ? = 1
Iblur2 = imgaussfilt(I,3); % ? = 3
Iblur3 = imgaussfilt(I,5); % ? = 5
Iblur4 = imgaussfilt(I,8); % ? = 8

%--------------------------------------------------------------------------
%     Detect edges on images with different ? values in the filters
%--------------------------------------------------------------------------

BW = edge(I,'sobel'); %Edge detection on unfiltered image
BW1 = edge(Iblur1,'sobel'); %Edge detection on image filtered with ? = 1
BW2 = edge(Iblur2,'sobel'); %Edge detection on image filtered with ? = 2
BW3 = edge(Iblur3,'sobel'); %Edge detection on image filtered with ? = 3
BW4 = edge(Iblur4,'sobel'); %Edge detection on image filtered with ? = 4

%--------------------------------------------------------------------------
%     Plot the edges detected on each image
%--------------------------------------------------------------------------
figure
subplot(2,2,1),imshow(BW1);
title('Filter with \sigma = 1');
subplot(2,2,2),imshow(BW2);
title('Filter with \sigma = 3');
subplot(2,2,3),imshow(BW3);
title('Filter with \sigma = 5');
subplot(2,2,4),imshow(BW4);
title('Filter with \sigma = 8');

figure
imshow(BW);
title('Unfiltered Image Edge Detection')
