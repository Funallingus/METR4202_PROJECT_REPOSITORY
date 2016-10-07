function [locations] = track_image(locations, previousIm, currentIm)

% close all;
% previousIm = rgb2gray(imread('data_3/sequence_4.jpg'));%4
% currentIm = rgb2gray(imread('data_3/sequence_7.jpg'));%7

%%%% get new images
%[frame, time, meta] = capture_frame(colorVid, depthVid);
%currentIm = frame
%
tic;

%locations = [870, 805, 155, 85; 820, 553, 115, 95; 970, 375, 60, 85; 1180, 415, 93, 70]

%%get image of objects that moved
sub = imsubtract(previousIm, currentIm);
%figure; imshow(sub); hold on;
[maxY, maxX] = size(sub);
%%search around domnino's in moved image for white -> a moved domino
%%update location coordinates
[numDomino, points] = size(locations);
for i = 1:numDomino
    %%update these for a cell instead of 2D matrix
    x = locations(i, 1);
    y = locations(i, 2);
    width = locations(i, 3);
    height = locations(i, 4);
    extraX = width/3;
    extraY = height/3;
    %%    coord of far left corner of search box
    rangeX = x+extraX*2+width;
    rangeY = extraY*2+height+y;
    refY = y-extraY;
    refX = x-extraX;
    if refX < 0
        refX = 0;
    end
    if refY < 0
        refY = 0;
    end
    if rangeY > maxY
        rangeY = maxY;
    end
    if rangeY < 0
        rangeY = 0;
    end
    if rangeX > maxX
        rangeX = maxX;
    end
    if rangeX < 0
        rangeX = 0;
    end
    range = imcrop(sub, [refX,refY,extraX*3+width,extraY*2+height]);
    range = im2bw(range);
    [coordX1, coordY1] = track_domino(range);
    %[coordX1, coordY1] = track_domino(extraX*3+width, extraY*3+height, range);
    if coordX1 ~= 0
        %% found domino
        globalCoord = [refX + coordX1, refY+coordY1];
        locations(i, 1) = globalCoord(1);
        locations(i, 2) = globalCoord(2);
    end
    %locations;
 end




% 
% %% scene is the image to view with pixel axis
% scene = imabsdiff(previousIm, currentIm);
% 
% %% Get and display 200 frames from vi devices
% figure('Position', [100, 100, 1000, 700]); %sets the figure window size for all im
% 
% 
% % There are many ways to plot an image
% % 'imshow' tends to be the easiest how ever it is slow
% % the following constructs an image object that can
% % have its data overwritten directly improving image display
% % performance
% 
% % Setup plot
% set(gca,'units','pixels');
% % Aquire size of video image format
% sz = size(scene);
% 
% % Construct image display object
% cim = image(...
%     [1 sz(2)],...
%     [1 sz(1)],...
%     zeros(sz(1), sz(2), 1),...
%     'CDataMapping', 'scaled'...
% );
% 
% % Ensure axis is set to improve display
% colormap gray;
% axis image;
% 
% set(cim, 'cdata', scene);
% 
% hold on;
% place = scatter(870+(locations(1,3)/2), 805+(locations(1,4)/2), 'filled');
% hold off;
% drawnow;
% 
% hold on;
% place = scatter(locations(1, 1), locations(1, 2), 'filled');
% hold off;
% drawnow;
% 
% hold on;
% place = scatter(820+(locations(2,3)/2), 553+(locations(2,4)/2), 'filled');
% hold off;
% drawnow;
% 
% hold on;
% place = scatter(locations(2, 1), locations(2, 2), 'filled');
% hold off;
% drawnow;
% 
% hold on;
% place = scatter(970+(locations(3,3)/2), 375+(locations(3,4)/2), 'filled');
% hold off;
% drawnow;
% 
% hold on;
% place = scatter(locations(3, 1), locations(3, 2), 'filled');
% hold off;
% drawnow;
% 
% hold on;
% place = scatter(1180+(locations(4,3)/2), 415+(locations(4,4)/2), 'filled');
% hold off;
% drawnow;
% 
% hold on;
% place = scatter(locations(4, 1), locations(4, 2), 'filled');
% hold off;
% drawnow;
end