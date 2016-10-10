function matches_sort = images2siftmatch_edited(ImageIn, TemplateIn)
% This function tries to find a template in a main image
% IMAGES MUST BE BW/GRAYSCALE
% Usage:
% images2siftmatch(ImageIn, TemplateIn);
%
% Example use:
% images2siftmatch(imread('p3676a.jpg'),imadjust(imread('Dominoes_6x6.gif')));
%
% (METR4202, 2016)

%% For testing with domino & vl_feat test images:
% ImageIn=imread('DominoSetup.1.jpg');
% ImageIn=imresize(ImageIn,0.25);
% TemplateIn=imread('p3676a.jpg');
% figure(10); imshow(ImageIn);

%For Testing that SIFT is working
%ImageIn=imread('p3676a.jpg');  
%TemplateIn=imadjust(imread('Dominoes_6x6.gif'));  %Imadjust to contrast adjust GIF

%For Testing with vl_feat test images
%ImageIn = imread(fullfile(vl_root,'data','roofs1.jpg')) ;
%TemplateIn = imread(fullfile(vl_root,'data','roofs2.jpg')) ;

%% ------------------------------------------------------------------------
%% PREPROSSING
% Image size
[Irows, Icolors, InumberOfColorChannels] = size(ImageIn);
[Trows, Tcolors, TnumberOfColorChannels] = size(TemplateIn);

%Convert Images to Single (Grayscale)
if InumberOfColorChannels>1     Ig = single(1 - edgesDetect(ImageIn, model)); else   Ig = single(ImageIn); end 
if TnumberOfColorChannels>1     Tg = single(1 - edgesDetect(TemplateIn, model)); else   Tg = single(TemplateIn); end
%% DEFINED CONSTANTS
NUM_SIFT_TO_SHOW = 20;

%% Compute/Extract SIFT Features & Match
% SIFT image_features, image_descriptors 
[I_f, I_d] = vl_sift(Ig) ;

% SIFT template_features, template_descriptors 
[T_f, T_d] = vl_sift(Tg) ;
%SIFT Matching
[matches, scores] = vl_ubcmatch(I_d, T_d);
[scores_sort, scores_rank] = sort(scores, 'descend') ;
matches_sort = matches(:, scores_rank(1:min([length(scores_rank) NUM_SIFT_TO_SHOW])));
%%%%%%%%%%%%%%%%%%%%%%%up to here usefull%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
use matches_sort for all 26 dominoes and then pick the 
best candidate as the domino type
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
