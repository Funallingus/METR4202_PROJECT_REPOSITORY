%%clear all;
function lineDetection(filename)
%% edge detection via canny algorithm
close all
I = imread(filename);
%I = rgb2hsv(I);
%Isum = rgb2gray(I);
%I = rgb2hsv(I);
%I = imsharpen(I);
figure, imshow(I), hold on;
hold off;

J = rgb2gray(I);
f = fspecial('gaussian');
J = imfilter(J, f);
C = edge(J, 'sobel');
C = bwmorph(C, 'bridge', 10);
C = bwmorph(C, 'thicken', 5);
C = bwmorph(C, 'skel');
C = bwareaopen(C, 30);
figure;
imshow(C);
%%uncommited changes



rmat = I(:,:,1);
gmat = I(:,:,2);
bmat = I(:,:,3);
i1 = im2bw(rmat, 0.42);%3

i2 = im2bw(gmat, 0.42);%4

i3 = im2bw(bmat, 0.42);%4

Isum = (i1&i2&i3);
C = edge(Isum, 'canny');
figure;
imshow(C);

Isum = bwmorph(Isum, 'skel');
Isum = bwmorph(Isum, 'hbreak');
Isum = bwmorph(Isum, 'spur');
Isum = bwmorph(Isum, 'clean', Inf);
Isum = bwmorph(Isum, 'thicken', 3);
Isum = bwareaopen(Isum, 5);
Isum = bwmorph(Isum, 'bridge', 10);
%Isum = bwmorph(Isum, 'fill');
%

%Isum = medfilt2(Isum);
figure, imshow(Isum);
f = fspecial('log');
Isum = imfilter(Isum, f);
%I = medfilt2(Isum);
%BW1 = edge(I, 'canny');
BW1 = edge(Isum, 'sobel');
figure;
imshow(BW1);
%BW1 = edge(I, 'canny');
%%remove noise
BW = bwareaopen(BW1, 5);

%%increase connect lines, increase thickness
BW = bwmorph(BW, 'bridge', 5);
% BW = imcomplement(BW);
BW = bwmorph(BW, 'skel', 3);
%BW = bwmorph(BW, 'thicken', 1);
BW = bwmorph(BW, 'fill');

%figure, imshow(BW), hold 
%hold off;
%BW = bwmorph(BW1, 'bridge');
BW = bwmorph(BW, 'clean');
%figure, imshow(BW), hold on;
%hold off;
%% detection of line segments via houghlines
[H,T,R] = hough(BW);
%%%%% 5 
P  = houghpeaks(H,20,'threshold',ceil(0.3*max(H(:))));
%% changed Fillgap pixel length to 10 from 5, minlen from 7 to 15
lines = houghlines(BW,T,R,P,'FillGap',11,'MinLength',12);
figure, imshow(BW), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');

%%  Hough-circles
%I = rgb2hsv(I);
%I = rgb2gray(I);
%BW1 = edge(I, 'sobel');
end



