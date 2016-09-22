%creates calibration images file
mkdir('calibrationImages')

%triggers data acquisition
try

    for i = 1:50
        %Trigger a frame request
        trigger([colorVid depthVid])

        % Get the color frame and metadata.
        [colorIm, colorTime, colorMeta] = getdata(colorVid);
        [depthIm, depthTime, depthMeta] = getdata(depthVid);
        imwrite(colorIm, strcat('calibrationImages/test', int2str(i), '.jpeg'));
        disp(strcat('saving image ', int2str(i)))
        pause(0.5);
    end
    
catch ME
    fprintf('Error thrown processing frames: %s - %s\n', ME.identifier, ME.message);
end

disp('now calibrating.....')
getCameraParams;
rmdir('calibrationImages', 's');

