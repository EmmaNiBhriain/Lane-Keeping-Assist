I  = imread('images/unmarked_road_2.jpg');
imshow(I) %display original image
title('Original Image')
%--------------------------------------------------------------------------
%            Convert Image to Birdseye view
%--------------------------------------------------------------------------
focalLength    = [309.4362, 344.2161]; % [fx, fy] in pixel units
principalPoint = [318.9034, 257.5352]; % [cx, cy] optical center in pixel coordinates
imageSize      = [480, 640];           % [nrows, mcols]

camIntrinsics = cameraIntrinsics(focalLength, principalPoint, imageSize);

distAhead = 30;
spaceToOneSide = 6;
bottomOffset = 3;
outView = [bottomOffset,distAhead,-spaceToOneSide,spaceToOneSide];

height = 2.1798;    % mounting height in meters from the ground
pitch  = 14;        % pitch of the camera in degrees
sensor = monoCamera(camIntrinsics,height,'Pitch',pitch);

imageSize = [NaN, 250]; % output image width in pixels; height is chosen automatically to preserve units per pixel ratio
birdsEye = birdsEyeView(sensor,outView,imageSize);

BEV = transformImage(birdsEye,I);

%--------------------------------------------------------------------------
%       Detect edges of the road and display on birdseye view image
%--------------------------------------------------------------------------

BEVG = rgb2gray(BEV);

BW = edge(BEVG,'sobel');

[H,T,R] = hough(BW, 'RhoResolution',0.5,'Theta',-88:88);

P  = houghpeaks(H,2,'threshold',ceil(0.3*max(H(:))),'NHoodSize',[95 95]);

lines = houghlines(BW,T,R,P,'FillGap',40,'MinLength',40);
figure, imshow(BEV), hold on
[rows, columns]=size(I);
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end
title('Birdseye View');

