function [J2, cnrPoints] = detect_checkerboard(frame)
% frame = imread('workspace_2.jpg');

close all;
width = size(frame, 2)/2;
height = size(frame, 1)/2;
sceneBottomLeft = imcrop(frame, [1, height, width, height]);
sceneBottomRight = imcrop(frame, [width, height, width, height]);
sceneTopLeft = imcrop(frame, [1, 1, width, height]);
sceneTopRight = imcrop(frame, [width, 1, width, height]);

images = {sceneTopLeft, sceneTopRight, sceneBottomLeft, sceneBottomRight};


% imshow(images{4}); hold on;
%plot(imagePoints(:,1,4), imagePoints(:,2,4), 'ro')

% images = images(imagesUsed);
cnrPoints = [];
allPoints = {};
figure(1);
for i = 1:numel(images)
    image = images{i};
    [imagePoints, boardSize, imagesUsed] = ...
    detectCheckerboardPoints(image);


    Avg = sum(imagePoints, 1)/size(imagePoints, 1);
    allPoints{i} = imagePoints;
    
    subplot(2, 2, i);
    imshow(images{i}); hold on; plot(imagePoints(:,1), imagePoints(:,2), 'ro');
    plot(Avg(1), Avg(2), 'rx', 'MarkerSize', 30);
    hold off
    cnrPoints = [cnrPoints; Avg(1), Avg(2)];

end



cnrPoints(2) = cnrPoints(2) + width;
cnrPoints(4) = cnrPoints(4) + width;
cnrPoints(7) = cnrPoints(7) + height;
cnrPoints(8) = cnrPoints(8) + height;

cnrPoints = [cnrPoints(3,:); cnrPoints(4,:); ...
        cnrPoints(2,:); cnrPoints(1,:)];

% figure(2); imshow(frame); hold on;
% plot(cnrPoints(:, 1), cnrPoints(:, 2), 'rx', 'MarkerSize', 15, 'LineWIdth', 5);
% hold off;
xmin = [allPoints{1}; allPoints{3}];
ymin = [allPoints{1}; allPoints{2}];

xmax = width + [allPoints{2}; allPoints{4}];
ymax = height + [allPoints{3}; allPoints{4}];

cropX = min(xmin(:, 1));
cropY = min(ymin(:, 2));
cropWidth = max(xmax(:, 1)) - min(xmin(:, 1));
cropHeight = max(ymax(:, 2)) - min(ymin(:, 2));
% frame = imcrop(frame, [cropX, cropY, cropWidth, cropHeight]);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% checkerCornerX = min(cnrPoints(:,1));
% checkerCornerY = min(cnrPoints(:,2));
% checkerWidth = max(cnrPoints(:,1)) - min(cnrPoints(:,1));
% checkerHeight = max(cnrPoints(:,2)) - min(cnrPoints(:,2));
% frame= imcrop(frame, [checkerCornerX, checkerCornerY,...
%         checkerWidth, checkerHeight]);

    % initial control points
A = [51 228;  51 127; 191 127; 191 228];
B = [cnrPoints(1) cnrPoints(5); cnrPoints(2) cnrPoints(6);...
        cnrPoints(3) cnrPoints(7);  cnrPoints(4) cnrPoints(8)];
A = A * 5;  
    
A = circshift(A, [1 0]);  % fix the order of points to match the picture

% input image
%I = imread('peppers.png');
%I = im2uint8(checkerboard(32,5,7));
[h,w,~] = size(frame);

% adapt control points to image size
% (basically we estimate an affine transform from 3 corner points)
aff = cp2tform(A(1:3,:), [1 1; w 1; w h], 'affine');
A = tformfwd(aff, A);
B = tformfwd(aff, B);

% estimate homography between A and B
T = cp2tform(B, A, 'projective');
T = fliptform(T);

% transform input image and show result
J = imtransform(frame, T);
J2 = J(:,end:-1:1,:);
%J2 = fliplr(J2);
figure(3)
subplot(121), imshow(frame), title('image')
subplot(122), imshow(J2), title('warped')




%%
%redetect checkerboards
width = size(J2, 2)/2;
height = size(J2, 1)/2;
sceneBottomLeft = imcrop(J2, [1, height, width, height]);
sceneBottomRight = imcrop(J2, [width, height, width, height]);
sceneTopLeft = imcrop(J2, [1, 1, width, height]);
sceneTopRight = imcrop(J2, [width, 1, width, height]);

images = {sceneTopLeft, sceneTopRight, sceneBottomLeft, sceneBottomRight};


cnrPoints = [];
allPoints = {};
% figure(5);
for i = 1:numel(images)
    image = images{i};
    [imagePoints, boardSize, imagesUsed] = ...
    detectCheckerboardPoints(image);


    Avg = sum(imagePoints, 1)/size(imagePoints, 1);
    allPoints{i} = imagePoints;
    
%     subplot(2, 2, i);
%     imshow(images{i}); hold on; plot(imagePoints(:,1), imagePoints(:,2), 'ro');
%     plot(Avg(1), Avg(2), 'rx', 'MarkerSize', 30);
%     hold off
    cnrPoints = [cnrPoints; Avg(1), Avg(2)];

end
    

xmin = [allPoints{1}; allPoints{3}];
ymin = [allPoints{1}; allPoints{2}];

xmax = width + [allPoints{2}; allPoints{4}];
ymax = height + [allPoints{3}; allPoints{4}];

cropX = min(xmin(:, 1));
cropY = min(ymin(:, 2));
cropWidth = max(xmax(:, 1)) - min(xmin(:, 1));
cropHeight = max(ymax(:, 2)) - min(ymin(:, 2));
J2 = imcrop(J2, [cropX, cropY, cropWidth, cropHeight]);

cnrPoints(1) = cnrPoints(1) - cropX;
cnrPoints(2) = cnrPoints(2) + width - cropX;
cnrPoints(3) = cnrPoints(3) - cropX;
cnrPoints(4) = cnrPoints(4) + width - cropX;
cnrPoints(5) = cnrPoints(5) - cropY;
cnrPoints(6) = cnrPoints(6) - cropY;
cnrPoints(7) = cnrPoints(7) + height - cropY;
cnrPoints(8) = cnrPoints(8) + height - cropY;

cnrPoints = [cnrPoints(3,:); cnrPoints(4,:); ...
        cnrPoints(2,:); cnrPoints(1,:)];

figure(4); imshow(J2); hold on;
plot(cnrPoints(:, 1), cnrPoints(:, 2), 'rx', 'MarkerSize', 15, 'LineWIdth', 5);
hold off;

end