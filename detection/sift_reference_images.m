
%%load all images into an array
referenceImages{1} = imread('SURF image library/domino00.jpg');
referenceImages{2} = imread('SURF image library/domino01.jpg');
referenceImages{3} = imread('SURF image library/domino03.jpg');
referenceImages{4} = imread('SURF image library/domino05.jpg');
referenceImages{5} = imread('SURF image library/domino06.jpg');
referenceImages{6} = imread('SURF image library/domino11.jpg');
referenceImages{7} = imread('SURF image library/domino12.jpg');
referenceImages{8} = imread('SURF image library/domino13.jpg');
referenceImages{9} = imread('SURF image library/domino14.jpg');
referenceImages{10} = imread('SURF image library/domino15.jpg');
referenceImages{11} = imread('SURF image library/domino16.jpg');
referenceImages{12} = imread('SURF image library/domino22.jpg');
referenceImages{13} = imread('SURF image library/domino23.jpg');
referenceImages{14} = imread('SURF image library/domino24.jpg');
referenceImages{15} = imread('SURF image library/domino25.jpg');
referenceImages{16} = imread('SURF image library/domino26.jpg');
referenceImages{17} = imread('SURF image library/domino33.jpg');
referenceImages{18} = imread('SURF image library/domino34.jpg');
referenceImages{19} = imread('SURF image library/domino35.jpg');
referenceImages{20} = imread('SURF image library/domino36.jpg');
referenceImages{21} = imread('SURF image library/domino44.jpg');
referenceImages{22} = imread('SURF image library/domino45.jpg');
referenceImages{23} = imread('SURF image library/domino46.jpg');
referenceImages{24} = imread('SURF image library/domino55.jpg');
referenceImages{25} = imread('SURF image library/domino56.jpg');
referenceImages{26} = imread('SURF image library/domino66.jpg');



for i = 1 : size(referenceImages, 2);
    referenceImages{i} = rgb2gray(referenceImages{i});
    dominoPoints = detectMSERFeatures(referenceImages{i});
    [dominoFeatures, dominoPoints] = extractFeatures(...
            referenceImages{i}, dominoPoints);
    referenceFeatures{i} = dominoFeatures;
    referencePoints{i} = dominoPoints;
end

referenceLibrary = {referenceImages, referencePoints, referenceFeatures};




