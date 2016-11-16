%   for i = 1:5
%       imageFileName = sprintf('image%d.tif', i);
%       imageFileNames{i} = fullfile(matlabroot, 'toolbox', 'vision',...
%            'visiondata','calibration','webcam',imageFileName);
%   end
  imageFileNames = {'checkerboard.jpg'};
  [imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
  
    imageFileNames = imageFileNames(imagesUsed);
  for i = 1:numel(imageFileNames)
      I = imread(imageFileNames{i});
      subplot(2, 2, i);
      imshow(I); hold on; plot(imagePoints(:,1,i), imagePoints(:,2,i), 'ro');
  end