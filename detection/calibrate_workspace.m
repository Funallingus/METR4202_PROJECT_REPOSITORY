Port = 18;
% abort(Port);
% moveArm(1, 110, 100, 500, Port);
% moveArm(2, 100, 100, 500, Port);
for i = 1 : 5
  frame = snapshot(cam);  
end

[frame, cnrPoints, allPoints, tform] = detect_checkerboard(frame);
% abort(Port);