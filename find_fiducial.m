function [boxPolygon, centroid] = find_fiducial(scene, depthIm)
%{
function takes a rgb image of a scene and attempts to 
match a checkerboard fiducial

boxPolygon is a set of 4 vetors which describe a bounding box 
of the fiducial found

centroid is a matrix of the form [x y] where x and y are the 
position in the scene of the centre of the polygon found
%}

if(~scene)
    scene = imread('fiducial_test_image.jpg');
end

fiducial_1 = imread('Fiducial image library/fiducial_calibration_image_1.png');
fiducial_2 = imread('Fiducial image library/fiducial_calibration_image_2.png');
fiducial_3 = imread('Fiducial image library/fiducial_calibration_image_3.png');
fiducial_4 = imread('Fiducial image library/fiducial_calibration_image_4.png');
fiducial_5 = imread('Fiducial image library/fiducial_calibration_image_5.png');
fiducial = {fiducial_1, fiducial_2, fiducial_3, fiducial_4, fiducial_5};

fprintf('Convert scene to grayscale and extract features...');

sceneGray = rgb2gray(scene);
scenePoints = detectSURFFeatures(sceneGray);
[sceneFeatures, scenePoints] = extractFeatures(sceneGray, scenePoints);



fprintf('Done\n');
fprintf('Extract and match fiducial features...');

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



fprintf('Done\n');
fprintf('Match features...');


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


centroid(1) = (newBoxPolygon(4, 1) + newBoxPolygon(2, 1)) / 2;
centroid(2) = (newBoxPolygon(4, 2) + newBoxPolygon(2, 2)) / 2;


figure(10);
imshow(scene);
hold on;
line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'r');
scatter(centroid(1), centroid(2), 'Marker', 'x');
title('Detected Box');

distance = depthIm(round(centroid(2)), round(centroid(1)));

fprintf('Distance to fiducial: %g mm\n', distance);

fprintf('Done\n');
end

