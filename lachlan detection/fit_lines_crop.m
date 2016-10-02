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
blobMeasurements = regionprops(logical(BW), 'BoundingBox', 'MajorAxisLength', 'MinorAxisLength', 'Area', 'Orientation');
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
        dominoCanidateCentroid_x{index} = (x1 + x2) / 2;
        dominoCanidateCentroid_y{index} = (y1 + y2) /  2;
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
figure; imshow(currentImage);
hold on;
index = 1;
for i = 1 : size(dominoCandidate, 2)
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
       [dominoCandidatePairsSearch, status] = matchFeatures(...
                    referenceFeatures{j}, candidateFeatures);
       %%if a better match found update matches features array
       if size(dominoCandidatePairs) < size(dominoCandidatePairsSearch)
          dominoCandidatePairs = dominoCandidatePairsSearch;
          index = j;
       end
       %%check if match successful
       
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
    
    if size(dominoCandidatePairs, 2) > 0
        plot(dominoCandidateBox_x{i}, dominoCandidateBox_y{i}, 'LineWidth', 2);
        domino{index} = dominoCandidate{i};
        dominoCentroid_x{index} = dominoCanidateCentroid_x{i};
        dominoCentroid_y{index} = dominoCanidateCentroid_y{i};
        index = index + 1;
    end
end

toc;

