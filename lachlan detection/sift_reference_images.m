
%%load all images into an array
referenceImages{1} = imread('SURF image library/domino_00.jpg');
referenceImages{2} = imread('SURF image library/domino_01.jpg');
referenceImages{3} = imread('SURF image library/domino_03.jpg');
referenceImages{4} = imread('SURF image library/domino_05.jpg');
referenceImages{5} = imread('SURF image library/domino_06.jpg');
referenceImages{6} = imread('SURF image library/domino_11.jpg');
referenceImages{7} = imread('SURF image library/domino_12.jpg');
referenceImages{8} = imread('SURF image library/domino_13.jpg');
referenceImages{9} = imread('SURF image library/domino_14.jpg');
referenceImages{10} = imread('SURF image library/domino_15.jpg');
referenceImages{11} = imread('SURF image library/domino_16.jpg');
referenceImages{12} = imread('SURF image library/domino_22.jpg');
referenceImages{13} = imread('SURF image library/domino_23.jpg');
referenceImages{14} = imread('SURF image library/domino_24.jpg');
referenceImages{15} = imread('SURF image library/domino_25.jpg');
referenceImages{16} = imread('SURF image library/domino_26.jpg');
referenceImages{17} = imread('SURF image library/domino_33.jpg');
referenceImages{18} = imread('SURF image library/domino_34.jpg');
referenceImages{19} = imread('SURF image library/domino_35.jpg');
referenceImages{20} = imread('SURF image library/domino_36.jpg');
referenceImages{21} = imread('SURF image library/domino_44.jpg');
referenceImages{22} = imread('SURF image library/domino_45.jpg');
referenceImages{23} = imread('SURF image library/domino_46.jpg');
referenceImages{24} = imread('SURF image library/domino_55.jpg');
referenceImages{25} = imread('SURF image library/domino_56.jpg');
referenceImages{26} = imread('SURF image library/domino_66.jpg');

for i = 1 : size(referenceImages, 2);
    referenceImages{i} = rgb2gray(referenceImages{i});
    dominoPoints = detectSURFFeatures(referenceImages{i});
    [dominoFeatures, dominoPoints] = extractFeatures(...
            referenceImages{i}, dominoPoints);
    referenceFeatures{i} = dominoFeatures;
    referencePoints{i} = dominoPoints;
end




