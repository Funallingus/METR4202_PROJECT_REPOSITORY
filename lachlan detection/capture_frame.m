function [frame, time, meta] = capture_frame(colorVid, depthVid);
trigger([colorVid depthVid]);
[frame, time, meta] = getdata(colorVid);
end