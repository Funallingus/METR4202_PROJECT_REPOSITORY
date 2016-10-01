
close all
scene = imread('Kinect 2 test.jpg');
fiducial = imread('camera_calibration_fiducial.png');
fiducialGray = rgb2gray(fiducial);
fiducialPoints = detectSURFFeatures(fiducialGray);


disp('rgb2gray conversion and detect features');
tic;
sceneGray = rgb2gray(scene);
scenePoints = detectSURFFeatures(sceneGray);
toc;

figure;
imshow(scene);
title('300 Strongest Feature Points from Scene Image');
hold on;
plot(selectStrongest(scenePoints, 300));


disp('Extract features');
tic;
[fiducialFeatures, fiducialPoints] = extractFeatures(fiducialGray, fiducialPoints);
[sceneFeatures, scenePoints] = extractFeatures(sceneGray, scenePoints);

disp('Match features');
tic;
boxPairs = matchFeatures(fiducialFeatures, sceneFeatures);

matchedFiducialPoints = fiducialPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);
figure;
showMatchedFeatures(fiducialGray, sceneGray, matchedFiducialPoints, ...
    matchedScenePoints, 'montage');
title('Putatively Matched Points (Including Outliers)');




[tform, inlierFiducialPoints, inlierScenePoints] = ...
    estimateGeometricTransform(matchedFiducialPoints, matchedScenePoints, 'similarity');
boxPolygon = [1, 1;...                           % top-left
        size(fiducial, 2), 1;...                 % top-right
        size(fiducial, 2), size(fiducial, 1);... % bottom-right
        1, size(fiducial, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon
newBoxPolygon = transformPointsForward(tform, boxPolygon);
toc;

figure;
imshow(scene);
hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
title('Detected Box');


