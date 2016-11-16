diceImage = rgb2gray(imread('Fiducial image library/fiducial_calibration_image_1.png'));
dicePoints = detectSURFFeatures(diceImage);
[diceFeatures, dicePoints] = extractFeatures(...
        diceImage, dicePoints);
dice = {dicePoints, diceFeatures};