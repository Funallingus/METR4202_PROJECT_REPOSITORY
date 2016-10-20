compositeImages{1} = imread('SURF composite images/domino_00.jpg');
compositeImages{2} = imread('SURF composite images/domino_01.jpg');
compositeImages{3} = imread('SURF composite images/domino_03.jpg');
compositeImages{4} = imread('SURF composite images/domino_05.jpg');
compositeImages{5} = imread('SURF composite images/domino_06.jpg');
compositeImages{6} = imread('SURF composite images/domino_11.jpg');
compositeImages{7} = imread('SURF composite images/domino_12.jpg');
compositeImages{8} = imread('SURF composite images/domino_13.jpg');
compositeImages{9} = imread('SURF composite images/domino_14.jpg');
compositeImages{10} = imread('SURF composite images/domino_15.jpg');
compositeImages{11} = imread('SURF composite images/domino_16.jpg');
compositeImages{12} = imread('SURF composite images/domino_22.jpg');
compositeImages{13} = imread('SURF composite images/domino_23.jpg');
compositeImages{14} = imread('SURF composite images/domino_24.jpg');
compositeImages{15} = imread('SURF composite images/domino_25.jpg');
compositeImages{16} = imread('SURF composite images/domino_26.jpg');
compositeImages{17} = imread('SURF composite images/domino_33.jpg');
compositeImages{18} = imread('SURF composite images/domino_34.jpg');
compositeImages{19} = imread('SURF composite images/domino_35.jpg');
compositeImages{20} = imread('SURF composite images/domino_36.jpg');
compositeImages{21} = imread('SURF composite images/domino_44.jpg');
compositeImages{22} = imread('SURF composite images/domino_45.jpg');
compositeImages{23} = imread('SURF composite images/domino_46.jpg');
compositeImages{24} = imread('SURF composite images/domino_55.jpg');
compositeImages{25} = imread('SURF composite images/domino_56.jpg');
compositeImages{26} = imread('SURF composite images/domino_66.jpg');


for i = 1 : size(compositeImages, 2);
    compositeImages{i} = rgb2gray(compositeImages{i});
    dominoPoints = detectMSERFeatures(compositeImages{i});
    [dominoFeatures, dominoPoints] = extractFeatures(...
            compositeImages{i}, dominoPoints);
    compositeMSERFeatures{i} = dominoFeatures;
    compositeMSERPoints{i} = dominoPoints;
end

for i = 1 : size(compositeImages, 2);
    dominoPoints = detectSURFFeatures(compositeImages{i});
    [dominoFeatures, dominoPoints] = extractFeatures(...
            compositeImages{i}, dominoPoints);
    compositeSURFFeatures{i} = dominoFeatures;
    compositeSURFPoints{i} = dominoPoints;
end

compositeLibrarySURF = {compositeImages, compositeSURFPoints, compositeSURFFeatures};

compositeLibraryMSER = {compositeImages, compositeMSERPoints, compositeMSERFeatures};