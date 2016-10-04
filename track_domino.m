function [ coordX, coordY ] = track_domino(width, height, range)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
tic;


% close all;
% previousIm = rgb2gray(imread('data_3/sequence_2.jpg'));
% currentIm = rgb2gray(imread('data_3/sequence_4.jpg'));
% [frame, time, meta] = capture_frame();
% tic;
% x = 1120;
% y = 400;
% width = 120;
% height = 90;
% 
% 
% 
%     %previous(y:(y+height),x:(x+width),:) = current(y:(y+height),x:(x+width),:);
%     %black = poly2mask(881, 767, 97, 173);%a bw image at 881,767, width, height
%     %blackMeasurements = regionprops(black, 'BoundingBox');
% 
%     %figure; imshow(current); hold on;
% sub = imsubtract(previousIm, currentIm);
%     %figure; imshow(sub); hold on;
% bw = im2bw(sub);
% bw = bwmorph(bw, 'thicken');
%     %diff = imabsdiff(previous, current);
%     %figure; imshow(bw); hold on;
% 
%     %sub = imsubtract(previous, diff);
%     %figure; imshow(sub); hold on;
% rangeX = width/3;
% rangeY = height/3;
% range = bw((y-rangeY):(rangeY*2+height+y),(x-rangeX):(x+rangeX*2+width),:);
    %range(rangeY:(rangeY+height), rangeX:(rangeX+width),:) = 0;
    %figure;imshow(range);
max = 400;
current = 0;
coord = [0,0];
%range = im2bw(range);
range = bwmorph(range, 'thicken');
figure; imshow(range); hold on;
%(rangeX*3+width);
%(rangeY*3+height);
%thresh = 40;
status = 0;
coord1 = [0, 0];

while current < max
    i = randi([1,width]);%rangeX*3+width]);
    j = randi([1,height]);%rangeY*3+height]);
    intensity = impixel(range, j, i);
    if intensity(1) > 0
        coord = [j,i];
        break;
    end
    current = current + 1;
end
toc;
current
coord
max

coordX = coord(1);
coordY = coord(2);


scene = range;

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

place = scatter(coordX, coordY);
hold off;
drawnow;




end
%globalCoord = [x+coord(1)-rangeX, y+coord(2)-rangeY]
%end


% for i = 1:(rangeX*3+width)
%    if status == 1
%        break;
%    end
%    rowAve = 0;
%     for j = 1:(rangeY*3+height)
%        intensity = impixel(range, j, i);
%        if intensity(1) > max
%            max = intensity(1);
%            coord = [i,j];
%        end
%        if max > 120
%            status = 1;
%            break
%        end
%        if intensity(1) < thresh
%            j = j + 10;
%            
%        end
%         if intensity(1) > rowAve
%             rowAve = intensity(1);
%         end
%     end
%    if rowAve < 50
%        i = i + 2;
%    end
% end



% %crop = imcrop(previous, blackMeasurements.BoundingBox);
% %figure; imshow(crop, []);
% scene = currentIm;
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
% 
% place = scatter(globalCoord(1), globalCoord(2));
% hold off;
% drawnow;
% 
% %end

