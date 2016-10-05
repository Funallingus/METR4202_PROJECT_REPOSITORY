%creates calibration images file
mkdir('calibrationImages')

%triggers data acquisition
try

    for i = 1:25
        %Trigger a frame request
        trigger([colorVid depthVid])

        % Get the color frame and metadata.
        [colorIm, colorTime, colorMeta] = getdata(colorVid);
        [depthIm, depthTime, depthMeta] = getdata(depthVid);
        imwrite(colorIm, strcat('calibrationImages/test', int2str(i), '.jpeg'));
        disp(strcat('saving image ', int2str(i)))
        pause(0.25);
    end
    
    % Calibrate last frame to obtain true extrinsics matrix
    disp('Zhang, get the checkerboards ass in the plane. count down starting')
    disp('in 5')
    pause(1);
    disp('in 4')
    pause(1);
    disp('in 3')
    pause(1);
    disp('in 2')
    pause(1)
    disp('in 1')
    pause(1);
    
    for i = 26:30
        trigger([colorVid depthVid])
        [colorIm, colorTime, colorMeta] = getdata(colorVid);
        [depthIm, depthTime, depthMeta] = getdata(depthVid);
        imwrite(colorIm, strcat('calibrationImages/test', int2str(i), '.jpeg'));
        disp(strcat('saving images in plane: ', int2str(i)))
        pause(0.25);
    end 
    
    
catch ME
    fprintf('Error thrown processing frames: %s - %s\n', ME.identifier, ME.message);
end

disp('now calibrating.....')
getCameraParams;
matSize = size(cameraParams.TranslationVectors);
lastIndex = matSize(1);
cameraParams.RotationMatrices(:,:,lastIndex)
cameraParams.TranslationVectors(lastIndex,:)
cameraMatrix = getCameraMatrix(cameraParams.IntrinsicMatrix,...
    cameraParams.RotationMatrices(:,:,lastIndex),...
    cameraParams.TranslationVectors(lastIndex,:),...
    cameraParams.FocalLength(1))
rmdir('calibrationImages', 's');

