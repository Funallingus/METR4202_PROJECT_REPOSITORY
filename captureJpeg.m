%% Captures an image with the Kinect and saves it with the given filename

function [colorIm, depthIm] = captureJpeg
    
    colorVid = evalin('base', 'colorVid');
    depthVid = evalin('base', 'depthVid');
    
    %Trigger a frame request
    trigger([colorVid depthVid])

    % Get the color frame and metadata.
    [colorIm, colorTime, colorMeta] = getdata(colorVid);
    [depthIm, depthTime, depthMeta] = getdata(depthVid);
    
    % Crop colour image
    colorIm = imcrop(colorIm,[308 0 1304 1080]);
    
    % Scale up depth image by new aspect ratio
    depthIm = imresize(depthIm, 2.5471698113);
    
%     % Crop depth again 
%     depthIm = imcrop(depthIm, [44 72 1141 946]);
%     depthIm = imresize(depthIm, [size(colorIm,1) size(colorIm,2)]);

end