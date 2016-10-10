diceImage = rgb2gray(imread('Dice library/dice_composite.jpg'));
dicePoints = detectSURFFeatures(diceImage);
[diceFeatures, dicePoints] = extractFeatures(...
        diceImage, dicePoints);
dice = {dicePoints, diceFeatures};