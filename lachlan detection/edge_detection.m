clear all
close all
%%function takes in a 1980x1020 image


%%only do this once
train_edge_detection;


I = imread('kinect 2 test.jpg');
J = imresize(I, 0.75);
J = imsharpen(J, 'Radius', 3, 'Amount', 2);
%tic; E = edge(rgb2gray(I), 'sobel'); toc;
tic; E = edgesDetect(J, model); 
F = 1-E;
%figure(1); im(E);
%BW = E > 0;
thresh = sqrt(graythresh(F));
BW = im2bw(F, thresh);
%figure(2); im(F);
BW = bwmorph(BW, 'spur');
BW = 1-BW;
%figure(2); im(I);
%figure(3); im(BW);

fit_lines_crop;
toc;

