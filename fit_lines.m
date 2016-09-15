%%
% Create the Hough transform using the binary image.
BW = E;

[H,T,R] = hough(BW);

%%
% Find peaks in the Hough transform of the image.
P  = houghpeaks(H,15,'threshold',ceil(0.5*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
%plot(x,y,'s','color','white');
%%
% Find lines and plot them.
lines = houghlines(BW,T,R,P,'FillGap',20,'MinLength',30);
figure, imshow(I), hold on
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
%%
% Highlight the longest line segment by coloring it cyan.
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');