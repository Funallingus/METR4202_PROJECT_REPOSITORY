
initalize_system
%%calibrate camera and find origin%%
[frame, time, meta] = capture_frame(colorVid, depthVid);
[feducialBox, feducialCentroid ] = find_fiducial(frame);
%%
%capture image
[frame, time, meta] = capture_frame(colorVid, depthVid);


%%
%find dominos
[domino, boxDimensions, match, pose] = edge_detection(frame, model,...
                    referenceLibrary, compositeLibrary, dice);

%%
%%%track domino%%%
knownLocations = [];
for i = 1 : size(boxDimensions, 2);
    knownLocation = [knownLocations; boxDimensions{i}];
end
previousImage = frame;
dominoLicationHistory = [];

for i = 1 : 10
   %do the tracking thing 
   [currentImage, time, meta] = capture_frame(colorVid, depthVid);
   
   
   [newLocation] = track_image(knownLocations,previousImage,currentImage);
   
    
   dominoLocationHistory = [dominoLocationHistory; newLocation];
   knownLocation = newLoation;
   previousImage = currentImage;
   i = i + 1;
end