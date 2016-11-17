abort(3);
moveArm(1, 110, 100, 500, 3);
moveArm(2, 100, 100, 500, 3);
for i = 1 : 5
  frame = snapshot(cam);  
end

[frame, cnrPoints, allPoints, tform] = detect_checkerboard(frame);
abort(3);