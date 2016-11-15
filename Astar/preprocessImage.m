%% preprocess grid

A = imread('zhang.png');
Imageskedoodles = im2bw(A);
Imageskies = imresize(Imageskedoodles, 0.02);
% imshow(Imageskies,'InitialMagnification','fit');