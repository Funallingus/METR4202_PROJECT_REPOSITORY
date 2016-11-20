function [domino, dominoBoxDimensions, obstructionMap, centroid, turnTableCentroid, dotCount] = ...
                edge_detection(currentImage, model, referenceLibrary, dice)
%close all
%%function takes in a 1980x1020 image
%%
%%%unpack data from reference image library%%%
 referenceImages = referenceLibrary{1};
 referencePoints = referenceLibrary{2};
 referenceFeatures = referenceLibrary{3};
% 
% compositeImages = compositeLibrarySURF{1};
% compositeFeaturesSURF = compositeLibrarySURF{3};
% 
% compositeFeaturesMSER = compositeLibraryMSER{3};


%%

%scale image down to improve processing time
resize = 1;
% load
%currentImage = imread('test.jpg');
%currentImage = imread('Tracking sequence 1/sequence_1.jpg');
fprintf('Detect edges from image...');

J = imresize(currentImage, resize);
K = imsharpen(J, 'Radius',3, 'Amount', 2);

F = edgesDetect(K, model); 
BW = im2bw(F, graythresh(F));



%figure(1); im(F);
%figure(2); im(K);
%figure(3); im(BW);

%% Adds bounding box to all of the objects (rectangles) found
%%by the edge detection toolbox
turnTableCentroid= {};
%{
[B,L,N,A] = bwboundaries(BW);
figure; imshow(currentImage); hold on;
for k=1:length(B),
    if(~sum(A(k,:)))
      boundary = B{k};
     plot(boundary(:,2)/resize,boundary(:,1)/resize,'r','LineWidth',2);hold on;
    end
end
% hold off;
%}
obstructionMap = ones(size(BW, 2) - 1, size(BW, 1) - 1);
size(BW)
size(obstructionMap);

%%
%%Plot bouding boxes found via bwboudnaries
fprintf('Done\n');
fprintf('Filter bad candidates...');

blobMeasurements = regionprops(logical(BW), 'BoundingBox', 'MajorAxisLength', 'MinorAxisLength', 'Area', 'Orientation');
numberOfBlobs = size(blobMeasurements, 1);

%%crop domino candidates out of original image
%%some preprocessing by filtering boxes that are too small/large
rects = [];
index = 1;
Turntable = [0, 0, 0, 0];
turnTableSize = 0;
frameSize = size(BW, 1) * size(BW, 2)/20;
for k = 1 : numberOfBlobs % Loop through all blobs.
    rects = blobMeasurements(k).BoundingBox; % Get list ofpixels in current blob.
    x1 = rects(1)/resize;
    y1 = rects(2)/resize;
    x2 = x1 + rects(3)/resize;
    y2 = y1 + rects(4)/resize;

    width = rects(3)/resize;
    height = rects(4)/resize;
    x = [x1, x2, x2, x1, x1];
    y = [y1, y1, y2, y2, y1];
    plot(x, y, 'LineWidth', 2);
    axis_aspect_ratio = blobMeasurements(k).MinorAxisLength / blobMeasurements(k).MajorAxisLength;
    if  (axis_aspect_ratio > 0.25)  && (width* height) > 100 &&...
       (width * height) < (size(currentImage, 1) * size(currentImage, 2) * 0.025) &&...
       (width * height) > (size(currentImage, 1) * size(currentImage, 2) * 0.005);
        angle = 90 - blobMeasurements(k).Orientation;
        dominoCentroid{index} = [(x1 + x2)/2, (y1 + y2)/2];
        x = [x1, x2, x2, x1, x1];
        y = [y1, y1, y2, y2, y1];
        dominoCanidate_box_dimensions{index} = [x1, y2, width, height];
        croppedImage = imcrop(currentImage, [x1, y1, width, height]);
        %dominoCandidate{index} = croppedImage;
        dominoCandidate{index} = imrotate(croppedImage, angle);
        dominoCandidateBox_x{index} = x;
        dominoCandidateBox_y{index} = y;
        index = index + 1;
    else (width * height) < (size(currentImage, 1) * size(currentImage, 2) * 0.1) && ...
            width * height > (size(currentImage, 1) * size(currentImage, 2) * 0.005);
        for a = x1 : x2
            for b = y1: y2
                obstructionMap(round(a), round(b)) = 0;
            end
        end        
    end
    if blobMeasurements(k).Area > 1000
        blobMeasurements(k).Area/frameSize
    end
    if blobMeasurements(k).Area/frameSize > turnTableSize
%         x = [x1, x2, x2, x1, x1];
%         y = [y1, y1, y2, y2, y1];
%         plot(x, y, 'LineWidth', 2);
        Turntable = [x1, y1, x2, y2];
        turnTableSize = blobMeasurements(k).Area/frameSize;
    end
end
obstructionMap = obstructionMap';
%figure; imshow(obstructionMap);

%%
%%SURF matching of candidates cropped out of original image
figure(20); imshow(currentImage);
hold on;
count = 1;
turnTableCount = 1;
dotCount = [];
for i = 1 : size(dominoCandidate, 2)
    isDomino = 0;
    isDice = 0;
%%loop through domino candidates
    candidateGray = rgb2gray(dominoCandidate{i});
%%extract canidate features
    candidatePoints = detectSURFFeatures(candidateGray);
    [candidateFeatures, candidatePoints] = extractFeatures(...
                    candidateGray, candidatePoints);
    
%{
    if size(candidatePoints, 1) > 0
        figure; imshow(candidateGray);
        hold on;
        plot(selectStrongest(candidatePoints, 100));
        hold off;
    end
%}
    dominoCandidatePairs = [];
    index = 0; %%index of matched image in referenceImage array
    for j = 1 : size(referenceImages, 2)
%%compare candidates to reference image library  
%        [dominoCandidatePairsSURF, status] = matchFeatures(...
%                     compositeFeaturesSURF{j}, candidateFeatures);
       [dominoCandidatePairsMSER, status] = matchFeatures(...
                    referenceFeatures{j}, candidateFeatures);
       %%if a better match found update matches features array
       dominoCandidatePairsSearch = dominoCandidatePairsMSER;
       if size(dominoCandidatePairs) < size(dominoCandidatePairsSearch)
          dominoCandidatePairs = dominoCandidatePairsSearch;
          index = j;
          isDomino = 1;
       end
       %%check if match successful
       
    end
    
    
   [dominoCandidatePairsSearch, status] = matchFeatures(dice{2}, candidateFeatures);
   if size(dominoCandidatePairs) < size(dominoCandidatePairsSearch)
       isDomino = 0;
       isDice = 1;
       dominoCandidatePairs = dominoCandidatePairsSearch;
   end
%{
    if size(dominoCandidatePairs, 2) > 0
        matchedBoxPoints = referencePoints{index}(dominoCandidatePairs(:, 1), :);
        matchedScenePoints = candidatePoints(dominoCandidatePairs(:, 2), :);
        figure;
        showMatchedFeatures(referenceImages{index}, dominoCandidate{i}, matchedBoxPoints, ...
        matchedScenePoints, 'montage');
        title('Putatively Matched Points (Including Outliers)');
    end
%}
    
    if size(dominoCandidatePairs, 2) > 1 && isDomino
        if dominoCentroid{i}(1) > Turntable(1) && dominoCentroid{i}(1) < Turntable(3) &&...
                dominoCentroid{i}(2) > Turntable(2) && dominoCentroid{i}(2) < Turntable(4)
            turnTableCentroid{turnTableCount} = dominoCentroid{i};
            turnTableCount = turnTableCount + 1;
        end
        domino{count} = dominoCandidate{i};
        dominoBoxDimensions{count} = dominoCanidate_box_dimensions{i};
        centroid{count} = dominoCentroid{i};
        
        plot(dominoCandidateBox_x{i}, dominoCandidateBox_y{i}, 'LineWidth', 2, 'Color', 'g');
        dotCount = [dotCount; find_circles(domino{count})];
        strmax = sprintf('Domino= %g:%g', dotCount(end, 1), dotCount(end, 2));
        text(dominoCanidate_box_dimensions{i}(1), dominoCanidate_box_dimensions{i}(2),strmax,'HorizontalAlignment','left', ...
           'FontSize', 8);
        drawnow; 
        
        count = count + 1;
    end
    
    if isDice
        plot(dominoCandidateBox_x{i}, dominoCandidateBox_y{i}, 'LineWidth', 2, 'Color', 'r');
    end
end
fprintf('Done\n');


end