%LAB2init;
close all
Port = 18;
abort(Port);
moveArm(1, -110, 100, 500, Port);
moveArm(2, -100, 100, 500, Port);

% clear cam;

% init_webcam
% pause(5);

%initalize_system;
%captureJpeg('MSER_image_library/domino_66a.jpg', colorVid, depthVid);
%stop([colorVid depthVid]);

%image = imread('SIFT_TEST/cluttered.jpeg');
%[frame, depthIm, time, meta] = capture_frame(colorVid, depthVid);
%imwrite(frame, 'workspace.jpg');
% snapshot(cam);
for i = 1 : 5
  frame = snapshot(cam);  
end
d = clock();
% [frame, cnrPoints, allPoints, tform] = detect_checkerboard(frame);
frame = crop_frame(frame, cnrPoints, allPoints, tform);
%[boxPolygon, centroid] = find_fiducial(frame, depthIm);
[domino, dominoBoxDimensions, obstructionMap, centroid, turnTableCentroid, dotCount] = edge_detection(frame, ...
            model, compositeLibrarySURF, dice);

[domino, dominoBoxDimensions, centroid] = sort_dominoes(domino, ...
        dominoBoxDimensions, centroid, dotCount);

%test_move_dominoes;