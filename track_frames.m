function track_frames(referenceData, referenceImage, colorVid, depthVid)
close all;

% [index, numDomino] = size(referenceData);
% knownLoc = referenceData{1};
% for i = 2:numDomino
%     knownLoc = [knownLoc;referenceData{i}];
% end

%knownLoc = [870, 805, 155, 85; 820, 553, 115, 95; 970, 375, 60, 85; 1180, 415, 93, 70];
newLocation1 = [11,   253,   122,    71];
newLocation2 = [];
allLoc = newLocation1;%knownLoc;

imagefiles = dir('data/*.png');
%imagefiles = dir('data/*.png');    
nfiles = length(imagefiles);    % Number of files found

images = cell(1, nfiles);       % 1xnfiles array
for i=1:nfiles
    currentfilename = fullfile('data', imagefiles(i).name); %dir data/domino_track_test_011
    currentimage = imread(currentfilename);  %get the image
    %currentimage = rgb2gray(currentimage);
    images{i} = currentimage;
end

figure('Position', [100, 100, 1000, 700]); %sets the figure window size for all im
set(gca,'units','pixels');
sz = size(images{1});
cim = image(...
    [1 sz(2)],...
    [1 sz(1)],...
    zeros(sz(1), sz(2), 1),...
    'CDataMapping', 'scaled'...
);
colormap gray;
axis image;

set(cim, 'cdata', images{1});
drawnow;

for i = 2: 36%nfiles
    previousIm = images{i-1};%currentIm;
    currentIm = images{i};%rgb2gray(imread('data_3/sequence_7.jpg'));
    %[frame, time, meta] = capture_frame(colorVid, depthVid);
    %currentIm = frame;
    [newLocation2] = track_image(newLocation1,previousIm,currentIm)
    allLoc = [allLoc; newLocation1];
    set(cim, 'cdata', images{i});
    hold on; result = scatter(newLocation2(1,1), newLocation2(1,2), 'filled'); hold off;
    drawnow;
    newLocation1 = newLocation2;
end

%[frame, time, meta] = capture_frame(colorVid, depthVid);
%currentIm = frame;

% currentIm = rgb2gray(imread('data_3/sequence_4.jpg'));
% [newLocation] = track_image(knownLoc,referenceImage,currentIm)
% allLoc = [allLoc;newLocation];
% 
% previousIm = currentIm;
% currentIm = rgb2gray(imread('data_3/sequence_6.jpg'));
% %[frame, time, meta] = capture_frame(colorVid, depthVid);
% %currentIm = frame;
% [newLocation1] = track_image(newLocation,previousIm,currentIm)
% allLoc = [allLoc; newLocation1];
% 
% previousIm = currentIm;
% currentIm = rgb2gray(imread('data_3/sequence_7.jpg'));
% %[frame, time, meta] = capture_frame(colorVid, depthVid);
% %currentIm = frame;
% [newLocation2] = track_image(newLocation1,previousIm,currentIm)
% allLoc = [allLoc; newLocation2];
% 
% previousIm = currentIm;
% currentIm = rgb2gray(imread('data_3/sequence_8.jpg'));
% %[frame, time, meta] = capture_frame(colorVid, depthVid);
% %currentIm = frame;
% [newLocation3] = track_image(newLocation2,previousIm,currentIm)
% allLoc = [allLoc; newLocation3];
% 
% previousIm = currentIm;
% currentIm = rgb2gray(imread('data_3/sequence_9.jpg'));
% %[frame, time, meta] = capture_frame(colorVid, depthVid);
% %currentIm = frame;
% [newLocation4] = track_image(newLocation3,previousIm,currentIm)
% allLoc = [allLoc; newLocation4];
% 
% previousIm = currentIm;
% currentIm = rgb2gray(imread('data_3/sequence_10.jpg'));
% %[frame, time, meta] = capture_frame(colorVid, depthVid);
% %currentIm = frame;
% [newLocation5] = track_image(newLocation4,previousIm,currentIm)
% allLoc = [allLoc; newLocation5];
% 
% allLoc

end