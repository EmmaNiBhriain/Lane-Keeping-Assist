%I  = imread('images/unmarked_road_2.jpg');
%I = rgb2gray(I);

I  = imread('images/um_000003.png');
I = rgb2gray(I);
%crop image
nRows = size(I, 1);
nCols = size(I, 2);

Ic = imcrop(I, [0 round(nRows/2) nCols round(nRows/2)]);
imshow(Ic)

% IG=rgb2gray(I)
BW = edge(Ic,'sobel');

[H,T,R] = hough(BW, 'RhoResolution',0.5,'Theta',-50:49.5);

P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))),'NHoodSize',[95 95]);

lines = houghlines(BW,T,R,P,'FillGap',40,'MinLength',20);
figure, imshow(Ic), hold on
[rows, columns]=size(Ic);
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   % Get the equation of the line
   x1 = xy(1,1);
   y1 = xy(1,2);
   x2 = xy(2,1);
   y2 = xy(2,2);
   slope = (y2-y1)/(x2-x1);
   xLeft = 1;
   yLeft = slope * (xLeft - x1) + y1;
   xRight = columns;
   yRight = slope * (xRight - x1) + y1;
   plot([xLeft, xRight], [yLeft, yRight], 'LineWidth',2,'Color','green');
  %xy = [lines(k).point1; lines(k).point2];
   %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end