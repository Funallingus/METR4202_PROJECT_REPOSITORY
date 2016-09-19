%% Captures an image with the Kinect and saves it with the given filename

function captureJpeg(filename, colorVid, depthVid)
    
    %Trigger a frame request
    trigger([colorVid depthVid])

    % Get the color frame and metadata.
    [colorIm, colorTime, colorMeta] = getdata(colorVid);
    [depthIm, depthTime, depthMeta] = getdata(depthVid);
    imwrite(colorIm, filename);
%     imwrite(depthIm, filename);
end