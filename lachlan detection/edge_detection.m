
close all
%%function takes in a 1980x1020 image


%%only do this once
train_edge_detection;
resize = 0.25;
% load
currentImage = imread('Kinect 2 test.jpg');
%currentImage = imread('Tracking sequence 1/sequence_1.jpg');
disp('Detect edges from image');
tic; 
J = imresize(currentImage, resize);
K = imsharpen(J, 'Radius',4, 'Amount', 3);
%tic; E = edge(rgb2gray(I), 'sobel'); toc;
F = edgesDetect(K, model); 
%F = 1-F;
thresh = graythresh(F);
BW = im2bw(F, thresh);
%BW = 1-BW;
%J = imsharpen(J, 'Radius',4, 'Amount', 3);
toc;
%figure(2); im(F);
%BW = bwmorph(BW, 'spur');
%figure(1); im(F);
%figure(2); im(I);
%figure(3); im(BW);

fit_lines_crop;


