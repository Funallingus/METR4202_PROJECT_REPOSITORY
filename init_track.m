close all;
previousIm = rgb2gray(imread('data_3/sequence_4.jpg'));
currentIm = rgb2gray(imread('data_3/sequence_7.jpg'));
%[frame, time, meta] = capture_frame();
tic;

locations = [870, 805, 155, 85; 820, 553, 115, 95; 970, 375, 60, 85; 1180, (415), 93, 70]

sub = imsubtract(previousIm, currentIm);
imshow(sub); hold on;
for i = 1:length(locations)
    x = locations(i, 1);
    y = locations(i, 2);
    width = locations(i, 3);
    height = locations(i, 4);
    rangeX = width/3;
    rangeY = height/3;
    %sub(y:(y+height),x:(x+width),:) = 0;
    range = sub((y-rangeY):(rangeY*2+height+y),(x-rangeX):(x+rangeX*2+width),:);
    range = im2bw(range);
    [coordX1, coordY1] = track_domino(rangeX*3+width, rangeY*3+height, range);
    globalCoord = [x+coordX1-rangeX, y+coordY1-rangeY]
    locations(i, 1) = globalCoord(1);
    locations(i, 2) = globalCoord(2);
end

locations


scene = imabsdiff(previousIm, currentIm);

%% Get and display 200 frames from vi devices
figure('Position', [100, 100, 1000, 700]); %sets the figure window size for all im


% There are many ways to plot an image
% 'imshow' tends to be the easiest how ever it is slow
% the following constructs an image object that can
% have its data overwritten directly improving image display
% performance

% Setup plot
set(gca,'units','pixels');
% Aquire size of video image format
sz = size(scene);

% Construct image display object
cim = image(...
    [1 sz(2)],...
    [1 sz(1)],...
    zeros(sz(1), sz(2), 1),...
    'CDataMapping', 'scaled'...
);

% Ensure axis is set to improve display
colormap gray;
axis image;

set(cim, 'cdata', scene);

hold on;
place = scatter(870+(locations(1,3)/2), 805+(locations(1,4)/2), 'filled');
hold off;
drawnow;

hold on;
place = scatter(locations(1, 1), locations(1, 2), 'filled');
hold off;
drawnow;

hold on;
place = scatter(820+(locations(2,3)/2), 553+(locations(2,4)/2), 'filled');
hold off;
drawnow;

hold on;
place = scatter(locations(2, 1), locations(2, 2), 'filled');
hold off;
drawnow;

hold on;
place = scatter(970+(locations(3,3)/2), 375+(locations(3,4)/2), 'filled');
hold off;
drawnow;

hold on;
place = scatter(locations(3, 1), locations(3, 2), 'filled');
hold off;
drawnow;

hold on;
place = scatter(1180+(locations(4,3)/2), 415+(locations(4,4)/2), 'filled');
hold off;
drawnow;

hold on;
place = scatter(locations(4, 1), locations(4, 2), 'filled');
hold off;
drawnow;
%     x = 1120;
% y = 400;
% width = 120;
% height = 90;
% previous(y:(y+height),x:(x+width),:) = current(y:(y+height),x:(x+width),:);
% black = poly2mask(881, 767, 97, 173);%a bw image at 881,767, width, height
% blackMeasurements = regionprops(black, 'BoundingBox');
% 
% %figure; imshow(current); hold on;
% sub = imsubtract(previousIm, currentIm);
% %figure; imshow(sub); hold on;
% bw = im2bw(sub);
% bw = bwmorph(bw, 'thicken');
% %diff = imabsdiff(previous, current);
% %figure; imshow(bw); hold on;
% 
% %sub = imsubtract(previous, diff);
% %figure; imshow(sub); hold on;
% rangeX = width/3;
% rangeY = height/3;
% range = bw((y-rangeY):(rangeY*2+height+y),(x-rangeX):(x+rangeX*2+width),:);
% 
% [coordX1, coordY1] = track_domino( [crop] )
% 
% 
