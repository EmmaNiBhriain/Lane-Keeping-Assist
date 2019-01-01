I  = imread('images/unmarked_road_2.jpg');
imshow(I) %display original image
title('Original Image')
%--------------------------------------------------------------------------
%            Convert Image to Birdseye view
%
% This was done using the documentation on the transformImage function
% available at https://uk.mathworks.com/help/driving/ref/birdseyeview.transformimage.html#bvh354t-1-birdsEye
%--------------------------------------------------------------------------
focalLength    = [309.4362, 344.2161]; %Define camera intrinsics
principalPoint = [318.9034, 257.5352];
imageSize      = [480, 640];           

camIntrinsics = cameraIntrinsics(focalLength, principalPoint, imageSize);

%Set the area in front of the camera too be converted into a birdseye view
%i.e. 3 to 20m with 6m on either side of the camera
distAhead = 20; 
spaceToOneSide = 6;
bottomOffset = 3;
outView = [bottomOffset,distAhead,-spaceToOneSide,spaceToOneSide];

height = 2.1798;    % height of camera from the ground (m)
pitch  = 14;        % pitch of the camera in degrees
sensor = monoCamera(camIntrinsics,height,'Pitch',pitch); %set camera configuration

imageSize = [NaN, 400]; % width = 250 pixels, NaN allows for automatic calculation of height to maintain aspect ratio
birdsEye = birdsEyeView(sensor,outView,imageSize); %initialise birdsEyeView object

BEV = transformImage(birdsEye,I); %Transform image to birdseye view

%--------------------------------------------------------------------------
%       Detect edges of the road and display on birdseye view image
%--------------------------------------------------------------------------

BEVG = rgb2gray(BEV); %Convert to black and white image

BW = edge(BEVG,'sobel'); %Detect edges in image

[H,T,R] = hough(BW, 'RhoResolution',0.5,'Theta',-88:88); 
P  = houghpeaks(H,2,'threshold',ceil(0.3*max(H(:))),'NHoodSize',[95 95]);

lines = houghlines(BW,T,R,P,'FillGap',40,'MinLength',40);
figure, imshow(BEV), hold on
[rows, columns]=size(I);
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end
title('Birdseye View');

