I  = imread('images/road.jpg'); %read the image to be analysed

I = rgb2gray(I); %convert to greyscale

BW = edge(I,'sobel'); %use the sobel edge detection algorithm
imshow(BW) %display the edge detected image

[H,T,R] = hough(BW, 'RhoResolution',0.5,'Theta',-88:88);

P  = houghpeaks(H,2,'threshold',ceil(0.3*max(H(:))),'NHoodSize',[95 95]);

lines = houghlines(BW,T,R,P,'FillGap',40,'MinLength',40);
figure, imshow(I), hold on
[rows, columns]=size(Ic);
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];   
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end