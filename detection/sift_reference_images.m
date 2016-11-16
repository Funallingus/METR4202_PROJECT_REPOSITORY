
%%load all images into an array
referenceImages{1} = imread('MSER_image_library/domino_00.jpg');
referenceImages{2} = imread('MSER_image_library/domino_01.jpg');
referenceImages{3} = imread('MSER_image_library/domino_03.jpg');
referenceImages{4} = imread('MSER_image_library/domino_05.jpg');
referenceImages{5} = imread('MSER_image_library/domino_06.jpg');
referenceImages{6} = imread('MSER_image_library/domino_11.jpg');
referenceImages{7} = imread('MSER_image_library/domino_12.jpg');
referenceImages{8} = imread('MSER_image_library/domino_13.jpg');
referenceImages{9} = imread('MSER_image_library/domino_14.jpg');
referenceImages{10} = imread('MSER_image_library/domino_15.jpg');
referenceImages{11} = imread('MSER_image_library/domino_16.jpg');
referenceImages{12} = imread('MSER_image_library/domino_22.jpg');
referenceImages{13} = imread('MSER_image_library/domino_23.jpg');
referenceImages{14} = imread('MSER_image_library/domino_24.jpg');
referenceImages{15} = imread('MSER_image_library/domino_25.jpg');
referenceImages{16} = imread('MSER_image_library/domino_26.jpg');
referenceImages{17} = imread('MSER_image_library/domino_33.jpg');
referenceImages{18} = imread('MSER_image_library/domino_34.jpg');
referenceImages{19} = imread('MSER_image_library/domino_35.jpg');
referenceImages{20} = imread('MSER_image_library/domino_36.jpg');
referenceImages{21} = imread('MSER_image_library/domino_44.jpg');
referenceImages{22} = imread('MSER_image_library/domino_45.jpg');
referenceImages{23} = imread('MSER_image_library/domino_46.jpg');
referenceImages{24} = imread('MSER_image_library/domino_55.jpg');
referenceImages{25} = imread('MSER_image_library/domino_56.jpg');
referenceImages{26} = imread('MSER_image_library/domino_66.jpg');



for i = 1 : size(referenceImages, 2);
    referenceImages{i} = rgb2gray(referenceImages{i});
    domino_Points = detectSURFFeatures(referenceImages{i});
    [domino_Features, domino_Points] = extractFeatures(...
            referenceImages{i}, domino_Points);
    referenceFeatures{i} = domino_Features;
    referencePoints{i} = domino_Points;
end

referenceLibrary = {referenceImages, referencePoints, referenceFeatures};




