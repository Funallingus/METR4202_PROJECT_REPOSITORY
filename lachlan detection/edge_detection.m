function [domino, dominoBoxDimensions, dominoMatch, dominoPose] = ...
                edge_detection(currentImage, model, referenceLibrary, compositeLibrary, dice)
%close all
%%function takes in a 1980x1020 image
%%
%%%unpack data from reference image library%%%
referenceImages = referenceLibrary{1};
%referencePoints = referenceLibrary{2};
referenceFeatures = referenceLibrary{3};

compositeImages = compositeLibrary{1};
compositeFeatures = compositeLibrary{3};



%%

%scale image down to improve processing time
resize = 0.25;
% load
%currentImage = imread('test.jpg');
%currentImage = imread('Tracking sequence 1/sequence_1.jpg');
disp('Detect edges from image');
tic; 
J = imresize(currentImage, resize);
K = imsharpen(J, 'Radius',3, 'Amount', 2);

F = edgesDetect(K, model); 
thresh = adaptthresh(F, 0.2);
BW = imbinarize(F, thresh);

toc;

%figure(1); im(F);
%figure(2); im(K);
%figure(3); im(BW);

%% Adds bounding box to all of the objects (rectangles) found
%%by the edge detection toolbox
%%
%{
[B,L,N,A] = bwboundaries(BW);
figure; imshow(currentImage); hold on;
for k=1:length(B),
    if(~sum(A(k,:)))
      boundary = B{k};
     plot(boundary(:,2)/resize,boundary(:,1)/resize,'r','LineWidth',2);hold on;
    end
end
%}
%%
%%Plot bouding boxes found via bwboudnaries
disp('Filter bad candidates');
tic;
blobMeasurements = regionprops(logical(BW), 'BoundingBox', 'MajorAxisLength', 'MinorAxisLength', 'Area');
numberOfBlobs = size(blobMeasurements, 1);

%%crop domino candidates out of original image
%%some preprocessing by filtering boxes that are too small/large
rects = [];
index = 1;
for k = 1 : numberOfBlobs % Loop through all blobs.
    rects = blobMeasurements(k).BoundingBox; % Get list ofpixels in current blob.
    x1 = rects(1)/resize;
    y1 = rects(2)/resize;
    x2 = x1 + rects(3)/resize;
    y2 = y1 + rects(4)/resize;
    width = rects(3)/resize;
    height = rects(4)/resize;
    axis_aspect_ratio = blobMeasurements(k).MinorAxisLength / blobMeasurements(k).MajorAxisLength;
    if  (axis_aspect_ratio > 0.25)  && (width* height) > 100 &&...
       (width * height) < (size(currentImage, 1) * size(currentImage, 2) * 0.1);
        x = [x1, x2, x2, x1, x1];
        y = [y1, y1, y2, y2, y1];
        dominoCanidate_box_dimensions{index} = [x1, y2, width, height];
        croppedImage = imcrop(currentImage, [x1, y1, width, height]);
        dominoCandidate{index} = croppedImage;
        dominoCandidateBox_x{index} = x;
        dominoCandidateBox_y{index} = y;
        index = index + 1;
        %plot(x, y, 'LineWidth', 2);
    end
end
%hold off

%%
%%SURF matching of candidates cropped out of original image
figure(20); imshow(currentImage);
hold on;
count = 1;
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
    for j = 1 : size(compositeImages, 2)
%%compare candidates to reference image library  
       [dominoCandidatePairsSearch, status] = matchFeatures(...
                    compositeFeatures{j}, candidateFeatures);
       %%if a better match found update matches features array
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
        plot(dominoCandidateBox_x{i}, dominoCandidateBox_y{i}, 'LineWidth', 2, 'Color', 'g');
        domino{count} = dominoCandidate{i};
        dominoBoxDimensions{count} = dominoCanidate_box_dimensions{i};
        %dominoMatch{count} = compositeImages{index};
        [match, pose] = identify_domino(candidateFeatures, ...
                                            index, referenceImages, referenceFeatures);
        dominoMatch{count} = match;
        dominoPose{count} = pose;
        count = count + 1;
    end
    
    if isDice
        plot(dominoCandidateBox_x{i}, dominoCandidateBox_y{i}, 'LineWidth', 2, 'Color', 'r');
    end
end

toc;

end

