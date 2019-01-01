location = 1; % 1 = Germany, 2 = Ireland
I  = imread('images/road.jpg'); %read the image to be analysed

Ig = rgb2gray(I); %convert to greyscale

BW = edge(Ig,'sobel'); %use the sobel edge detection algorithm
imshow(BW) %display the edge detected image

[H,T,R] = hough(BW, 'RhoResolution',0.5,'Theta',-88:88);

P  = houghpeaks(H,2,'threshold',ceil(0.3*max(H(:))),'NHoodSize',[95 95]);

lines = houghlines(BW,T,R,P,'FillGap',40,'MinLength',40);
figure, imshow(I), hold on
[rows, columns]=size(I);
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   disp(xy)
   % Get the equation of the line
   x1 = xy(1,1);
   y1 = xy(1,2);
   x2 = xy(2,1);
   y2 = xy(2,2);
   slope = (y2-y1)/(x2-x1);
   disp("Slope")
   disp(slope)
   xLeft = 2;
   yLeft = slope * (xLeft - x1) + y1; %y=mx+c
   disp('OOOOO')
   disp(yLeft)
   xRight = columns;
   yRight = slope * (xRight - x1) + y1;
   plot([xLeft, xRight], [yLeft, yRight], 'LineWidth',2,'Color','green');
end




%--------------------------------------------------------------------------
%            New Point 1
%--------------------------------------------------------------------------
% Find the y value of line 1 when x=1 (ans = -123)
% Find the x value of line 2 when y = -123
% Find the x value halfway between these points to calculate a point on the
% line that separates the two lines
xy = [lines(1).point1; lines(1).point2];
disp(xy)
   % Get the equation of the line
x1 = xy(1,1);
y1 = xy(1,2);
x2 = xy(2,1);
y2 = xy(2,2);
slope = (y2-y1)/(x2-x1);
disp("Slope")
disp(slope)
disp(slope)
xLeft = 1;
yLeft = slope * (xLeft - x1) + y1; %y=mx+c
xRight = columns;
yRight = slope * (xRight - x1) + y1;
existingLine = line([xLeft, xRight], [yLeft, yRight]);
set(existingLine, 'LineWidth',2,'Color','green')
calculatedx1 = (0-y1)/slope + x1;
disp('CALCULATED X')
disp(calculatedx1)
%plot([xLeft, xRight], [yLeft, yRight], 'LineWidth',2,'Color','green');

xy = [lines(2).point1; lines(2).point2];
disp(xy)
   % Get the equation of the line
x1 = xy(1,1);
y1 = xy(1,2);
x2 = xy(2,1);
y2 = xy(2,2);
slope = (y2-y1)/(x2-x1);
disp("Slope")
disp(slope)
calculatedx = (0-y1)/slope + x1;
disp('CALCULATED X')
disp(calculatedx)

NewPoint1X = (calculatedx1+calculatedx)/2;
NewPoint1 = [NewPoint1X, 0];
disp('NewPoint1:');
disp(NewPoint1X)

%Get an equation for line 2, used to calculate area to be shaded
xLeft = 1;
yLeft = slope * (xLeft - x1) + y1; %y=mx+c
xRight = columns;
yRight = slope * (xRight - x1) + y1;
line2 = line([xLeft, xRight], [yLeft, yRight]);
%set(line2, 'LineWidth',2,'Color','green')


%--------------------------------------------------------------------------
%            New Point 2 
%--------------------------------------------------------------------------
xy = [lines(2).point1; lines(2).point2];
disp(xy)
   % Get the equation of the line
x1 = xy(1,1);
y1 = xy(1,2);
x2 = xy(2,1);
y2 = xy(2,2);
slope = (y2-y1)/(x2-x1);
disp("Slope")
disp(slope)
xLeft = 1;
NOTEDYVALUE2 = slope * (xLeft - x1) + y1; %y=mx+c
disp("New noted value")
disp(NOTEDYVALUE2)
xRight = columns;
yRight1 = slope * (xRight - x1) + y1;


xy = [lines(1).point1; lines(1).point2];
disp(xy)
   % Get the equation of the line
x1 = xy(1,1);
y1 = xy(1,2);
x2 = xy(2,1);
y2 = xy(2,2);
slope = (y2-y1)/(x2-x1);
disp("Slope")
disp(slope)
newcalculatedx = (NOTEDYVALUE2-y1)/slope + x1;
disp('CALCULATED X')
disp(newcalculatedx)


NewPoint2X = (1+newcalculatedx)/2;
NewPoint2 = [NewPoint2X, NOTEDYVALUE2];
disp('NewPoint2:');
disp(NewPoint2X)

%Create new line using calculated points and plot on image

xy = [NewPoint1; NewPoint2];
disp(xy)
   % Get the equation of the line
x1 = xy(1,1);
y1 = xy(1,2);
x2 = xy(2,1);
y2 = xy(2,2);
slope = (y2-y1)/(x2-x1);
disp("Slope")
disp(slope)
xLeft = 1;
yLeft = slope * (xLeft - x1) + y1; %y=mx+c
xRight = columns;
yRight = slope * (xRight - x1) + y1;
calculatedLine = line([xLeft, xRight], [yLeft, yRight]);
set(calculatedLine, 'LineWidth',2,'Color','green')
%plot([xLeft, xRight], [yLeft, yRight], 'LineWidth',2,'Color','green');


%disp(existingLine) [x1,x2][y1,y2]: [1 3537] [-123.8991 888.2404]
disp(calculatedLine) %[x1,x2][y1,y2]: [1 3537] [-780.3535 4.1086e+03]
disp(line2) %[x1,x2][y1,y2]: [1 3537] [339.9770 -1.3874e+03]



if(location == 1)
    patch([1 1 3537 3537], [-123.8991 -780.3535 4.1086e+03 888.2404],'r')
elseif(location == 2)
    fill([1 1 3537 3537], [-780.3535 339.9770 -1.3874e+03 4.1086e+03],'r')
end


set_steering_angle = 30;
open_system('simple_steering')
set_param('simple_steering/Set_steering_angle','Value','25')