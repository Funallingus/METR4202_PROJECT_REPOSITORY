%%find circles
close all
I = imread('Sift image library/domino_11.png');
%blobMeasurements = regionprops(logical(BW), 'BoundingBox', 'MajorAxisLength', 'MinorAxisLength', 'Area', 'Orientation');
%blobMeasurements(1).Orientation
I = imresize(I, [size(imageArray{1}, 1), size(imageArray{1}, 2)]);
image1 =  rgb2gray(I);
image2 = imageArray{1};
figure(); imshow(image1); figure(); imshow(image2);

difference = single(image1) - single(image2);
squaredError = difference .^ 2;
meanSquaredError = sum(squaredError(:)) / numel(image1);
rmsError = sqrt(meanSquaredError)
