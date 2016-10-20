function [frame, depthIm, time, meta] = capture_frame(colorVid, depthVid)
trigger([colorVid depthVid]);
[frame, time, meta] = getdata(colorVid);
[depthIm, depthTime, depthMeta] = getdata(depthVid);
%frame = imcrop(frame,[308 0 1305 1080]);
    
    % Scale up depth image by new aspect ratio
depthIm = imresize(depthIm, 2.5471698113);
end