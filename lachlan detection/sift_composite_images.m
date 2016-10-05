compositeImages{1} = imread('SURF composite library/domino_00.jpg');
compositeImages{2} = imread('SURF composite library/domino_01.jpg');
compositeImages{3} = imread('SURF composite library/domino_03.jpg');
compositeImages{4} = imread('SURF composite library/domino_05.jpg');
compositeImages{5} = imread('SURF composite library/domino_06.jpg');
compositeImages{6} = imread('SURF composite library/domino_11.jpg');
compositeImages{7} = imread('SURF composite library/domino_12.jpg');
compositeImages{8} = imread('SURF composite library/domino_13.jpg');
compositeImages{9} = imread('SURF composite library/domino_14.jpg');
compositeImages{10} = imread('SURF composite library/domino_15.jpg');
compositeImages{11} = imread('SURF composite library/domino_16.jpg');
compositeImages{12} = imread('SURF composite library/domino_22.jpg');
compositeImages{13} = imread('SURF composite library/domino_23.jpg');
compositeImages{14} = imread('SURF composite library/domino_24.jpg');
compositeImages{15} = imread('SURF composite library/domino_25.jpg');
compositeImages{16} = imread('SURF composite library/domino_26.jpg');
compositeImages{17} = imread('SURF composite library/domino_33.jpg');
compositeImages{18} = imread('SURF composite library/domino_34.jpg');
compositeImages{19} = imread('SURF composite library/domino_35.jpg');
compositeImages{20} = imread('SURF composite library/domino_36.jpg');
compositeImages{21} = imread('SURF composite library/domino_44.jpg');
compositeImages{22} = imread('SURF composite library/domino_45.jpg');
compositeImages{23} = imread('SURF composite library/domino_46.jpg');
compositeImages{24} = imread('SURF composite library/domino_55.jpg');
compositeImages{25} = imread('SURF composite library/domino_56.jpg');
compositeImages{26} = imread('SURF composite library/domino_66.jpg');


for i = 1 : size(compositeImages, 2);
    compositeImages{i} = rgb2gray(compositeImages{i});
    dominoPoints = detectSURFFeatures(compositeImages{i});
    [dominoFeatures, dominoPoints] = extractFeatures(...
            compositeImages{i}, dominoPoints);
    compositeFeatures{i} = dominoFeatures;
    compositePoints{i} = dominoPoints;
end

compositeLibrary = {compositeImages, compositePoints, compositeFeatures};