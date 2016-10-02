
initalize_system
%%calibrate camera and find origin%%
[frame, time, meta] = capture_frame(colorVid, depthVid);
[feducialBox, feducialCentroid ] = find_fiducial(frame);
%%
%capture image
[frame, time, meta] = capture_frame(colorVid, depthVid);


%%
%find dominos
[domino, dominoCentroid_x, dominoCentroid_y, dominoMatch] = edge_detection(frame, model, referenceLibrary);

%%
%%%track domino%%%
while 1
   %do the tracking thing 
    
end