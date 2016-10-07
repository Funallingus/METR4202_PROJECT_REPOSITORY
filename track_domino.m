function [ coordX, coordY ] = track_domino(range)
%SUMMMARY
%   searches for domino in cropped image 'range', described by width and
%   height. If the image is black, returns coordinates [0,0] which maps
%   back to location of previous image (domino didnt move), otherwise
%   returns the new coordinates.
[height, width] = size(range);


if sum(abs(range)) == 0
    %display('no Domino')
    coordX = 0;
    coordY = 0;
else
%     max = 400;
%     current = 0;
%     coord = [0,0];
%     range = bwmorph(range, 'thicken', 6);
%     figure; imshow(range); hold on;
%     status = 0;
%     while current < max
%         i = randi([1,width]);%rangeX*3+width]);
%         j = randi([1,height]);%rangeY*3+height]);
%         intensity = impixel(range, j, i);
%         if intensity(1) > 0
%             coord = [j,i];
%             break;
%         end
%         current = current + 1;
%     end
%     toc;
%     current;
%     coord;
%     max;
    [u,v] = find(range);
    coordY = min(u);
    coordX = min(v);
    %[coordX, coordY] = [min(u), min(v)];
    %coordX = coord(1);
    %coordY = coord(2);

end

% 
% %display the image with the point drawn on
% scene = range;
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
% place = scatter(coordX, coordY);
% hold off;
% drawnow;




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

