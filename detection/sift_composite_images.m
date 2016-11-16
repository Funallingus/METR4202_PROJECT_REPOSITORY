compositelibrary{1} = imread('SURF composite library/domino_00.jpg');
compositelibrary{2} = imread('SURF composite library/domino_01.jpg');
compositelibrary{3} = imread('SURF composite library/domino_03.jpg');
compositelibrary{4} = imread('SURF composite library/domino_04.jpg');
compositelibrary{5} = imread('SURF composite library/domino_05.jpg');
compositelibrary{6} = imread('SURF composite library/domino_06.jpg');
compositelibrary{7} = imread('SURF composite library/domino_11.jpg');
compositelibrary{8} = imread('SURF composite library/domino_12.jpg');
compositelibrary{9} = imread('SURF composite library/domino_13.jpg');
compositelibrary{10} = imread('SURF composite library/domino_14.jpg');
compositelibrary{11} = imread('SURF composite library/domino_15.jpg');
compositelibrary{12} = imread('SURF composite library/domino_16.jpg');
compositelibrary{13} = imread('SURF composite library/domino_22.jpg');
compositelibrary{14} = imread('SURF composite library/domino_23.jpg');
compositelibrary{15} = imread('SURF composite library/domino_24.jpg');
compositelibrary{16} = imread('SURF composite library/domino_25.jpg');
compositelibrary{17} = imread('SURF composite library/domino_26.jpg');
compositelibrary{18} = imread('SURF composite library/domino_33.jpg');
compositelibrary{19} = imread('SURF composite library/domino_34.jpg');
compositelibrary{20} = imread('SURF composite library/domino_35.jpg');
compositelibrary{21} = imread('SURF composite library/domino_36.jpg');
compositelibrary{22} = imread('SURF composite library/domino_44.jpg');
compositelibrary{23} = imread('SURF composite library/domino_45.jpg');
compositelibrary{24} = imread('SURF composite library/domino_46.jpg');
compositelibrary{25} = imread('SURF composite library/domino_55.jpg');
compositelibrary{26} = imread('SURF composite library/domino_56.jpg');
compositelibrary{27} = imread('SURF composite library/domino_66.jpg');

for i = 1 : size(compositelibrary, 2);
    compositelibrary{i} = rgb2gray(compositelibrary{i});
    dominoPoints = detectSURFFeatures(compositelibrary{i});
    [dominoFeatures, dominoPoints] = extractFeatures(...
            compositelibrary{i}, dominoPoints);
    compositeSURFFeatures{i} = dominoFeatures;
    compositeSURFPoints{i} = dominoPoints;
end

compositeLibrarySURF = {compositelibrary, compositeSURFPoints, compositeSURFFeatures};

