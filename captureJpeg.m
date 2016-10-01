%% Captures an image with the Kinect and saves it with the given filename

function [colorIm, depthIm] = captureJpeg
    
    colorVid = evalin('base', 'colorVid');
    depthVid = evalin('base', 'depthVid');
    
    %Trigger a frame request
    trigger([colorVid depthVid])

    % Get the color frame and metadata.
    [colorIm, colorTime, colorMeta] = getdata(colorVid);
    [depthIm, depthTime, depthMeta] = getdata(depthVid);
    
    % Resize the Depth image
    depthIm = imresize(depthIm, [size(colorIm,1) size(colorIm,2)]);

end