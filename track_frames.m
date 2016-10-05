function track_frames(referenceData, referenceImage, colorVid, depthVid)
close all;

% [index, numDomino] = size(referenceData);
% knownLoc = referenceData{1};
% for i = 2:numDomino
%     knownLoc = [knownLoc;referenceData{i}];
% end

knownLoc = [870, 805, 155, 85; 820, 553, 115, 95; 970, 375, 60, 85; 1180, 415, 93, 70];

allLoc = knownLoc;

%for i = 2: 10
%    previousIm = currentIm;
%    currentIm = rgb2gray(imread('data_3/sequence_7.jpg'));
    %[frame, time, meta] = capture_frame(colorVid, depthVid);
%    %currentIm = frame;
%    [newLocation2] = track_image(newLocation1,previousIm,currentIm)
%    allLoc = [allLoc; newLocation];
%end
%[frame, time, meta] = capture_frame(colorVid, depthVid);
%currentIm = frame;

currentIm = rgb2gray(imread('data_3/sequence_4.jpg'));
[newLocation] = track_image(knownLoc,referenceImage,currentIm)
allLoc = [allLoc;newLocation];

previousIm = currentIm;
currentIm = rgb2gray(imread('data_3/sequence_6.jpg'));
%[frame, time, meta] = capture_frame(colorVid, depthVid);
%currentIm = frame;
[newLocation1] = track_image(newLocation,previousIm,currentIm)
allLoc = [allLoc; newLocation1];

previousIm = currentIm;
currentIm = rgb2gray(imread('data_3/sequence_7.jpg'));
%[frame, time, meta] = capture_frame(colorVid, depthVid);
%currentIm = frame;
[newLocation2] = track_image(newLocation1,previousIm,currentIm)
allLoc = [allLoc; newLocation2];

previousIm = currentIm;
currentIm = rgb2gray(imread('data_3/sequence_8.jpg'));
%[frame, time, meta] = capture_frame(colorVid, depthVid);
%currentIm = frame;
[newLocation3] = track_image(newLocation2,previousIm,currentIm)
allLoc = [allLoc; newLocation3];

previousIm = currentIm;
currentIm = rgb2gray(imread('data_3/sequence_9.jpg'));
%[frame, time, meta] = capture_frame(colorVid, depthVid);
%currentIm = frame;
[newLocation4] = track_image(newLocation3,previousIm,currentIm)
allLoc = [allLoc; newLocation4];

previousIm = currentIm;
currentIm = rgb2gray(imread('data_3/sequence_10.jpg'));
%[frame, time, meta] = capture_frame(colorVid, depthVid);
%currentIm = frame;
[newLocation5] = track_image(newLocation4,previousIm,currentIm)
allLoc = [allLoc; newLocation5];

end