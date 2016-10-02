fuction [boxPolygon centroid] = 

scene = imread('fiducial_test_image.jpg');

fiducial_1 = imread('fiducial_calibration_image_1.png');
fiducial_2 = imread('fiducial_calibration_image_2.png');
fiducial_3= imread('fiducial_calibration_image_3.png');
fiducial_4 = imread('fiducial_calibration_image_4.png');

fiducial = {fiducial_1, fiducial_2, fiducial_3, fiducial_4};

disp('rgb2gray conversion and extract features');
tic;
sceneGray = rgb2gray(scene);
scenePoints = detectSURFFeatures(sceneGray);
[sceneFeatures, scenePoints] = extractFeatures(sceneGray, scenePoints);
toc;


disp('Extract and match fiducial features');
tic;
boxPairs = [];
index = 1;
%%search through fiducial library for best match
for i = 1 : size(fiducial, 2)
    fiducialGray = rgb2gray(fiducial{i});
    fiducialPoints = detectSURFFeatures(fiducialGray);
    [fiducialFeatures, fiducialPoints] = extractFeatures(fiducialGray, fiducialPoints);
    [boxPairsSearch, status] = matchFeatures(fiducialFeatures, sceneFeatures);
    if size(boxPairsSearch) > size(boxPairs)
        boxPairs = boxPairsSearch;
        index = i;
    end
end
toc;



disp('Match features');
tic;

matchedFiducialPoints = fiducialPoints(boxPairs(:, 1), :);
matchedScenePoints = scenePoints(boxPairs(:, 2), :);


%%transform box onto scene image
[tform, inlierFiducialPoints, inlierScenePoints, status] = ...
    estimateGeometricTransform(matchedFiducialPoints, matchedScenePoints, 'similarity');
boxPolygon = [1, 1;...                           % top-left
        size(fiducial{index}, 2), 1;...                 % top-right
        size(fiducial{index}, 2), size(fiducial{index}, 1);... % bottom-right
        1, size(fiducial{index}, 1);...                 % bottom-left
        1, 1];                   % top-left again to close the polygon
newBoxPolygon = transformPointsForward(tform, boxPolygon);
toc;

figure;
imshow(scene);
hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'y');
title('Detected Box');


