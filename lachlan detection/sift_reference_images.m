
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


referenceImages{27} = imread('SURF image library/domino_00_upright.jpg');
referenceImages{28} = imread('SURF image library/domino_01_upright.jpg');
referenceImages{29} = imread('SURF image library/domino_03_upright.jpg');
referenceImages{30} = imread('SURF image library/domino_05_upright.jpg');
referenceImages{31} = imread('SURF image library/domino_06_upright.jpg');
referenceImages{32} = imread('SURF image library/domino_11_upright.jpg');
referenceImages{33} = imread('SURF image library/domino_12_upright.jpg');
referenceImages{34} = imread('SURF image library/domino_13_upright.jpg');
referenceImages{35} = imread('SURF image library/domino_14_upright.jpg');
referenceImages{36} = imread('SURF image library/domino_15_upright.jpg');
referenceImages{37} = imread('SURF image library/domino_16_upright.jpg');
referenceImages{38} = imread('SURF image library/domino_22_upright.jpg');
referenceImages{39} = imread('SURF image library/domino_23_upright.jpg');
referenceImages{40} = imread('SURF image library/domino_24_upright.jpg');
referenceImages{41} = imread('SURF image library/domino_25_upright.jpg');
referenceImages{42} = imread('SURF image library/domino_26_upright.jpg');
referenceImages{43} = imread('SURF image library/domino_33_upright.jpg');
referenceImages{44} = imread('SURF image library/domino_34_upright.jpg');
referenceImages{45} = imread('SURF image library/domino_35_upright.jpg');
referenceImages{46} = imread('SURF image library/domino_36_upright.jpg');
referenceImages{47} = imread('SURF image library/domino_44_upright.jpg');
referenceImages{48} = imread('SURF image library/domino_45_upright.jpg');
referenceImages{49} = imread('SURF image library/domino_46_upright.jpg');
referenceImages{50} = imread('SURF image library/domino_55_upright.jpg');
referenceImages{51} = imread('SURF image library/domino_56_upright.jpg');
referenceImages{52} = imread('SURF image library/domino_66_upright.jpg');


referenceImages{53} = imread('SURF image library/domino_00_sideways.jpg');
referenceImages{54} = imread('SURF image library/domino_01_sideways.jpg');
referenceImages{55} = imread('SURF image library/domino_03_sideways.jpg');
referenceImages{56} = imread('SURF image library/domino_05_sideways.jpg');
referenceImages{57} = imread('SURF image library/domino_06_sideways.jpg');
referenceImages{58} = imread('SURF image library/domino_11_sideways.jpg');
referenceImages{59} = imread('SURF image library/domino_12_sideways.jpg');
referenceImages{60} = imread('SURF image library/domino_13_sideways.jpg');
referenceImages{61} = imread('SURF image library/domino_14_sideways.jpg');
referenceImages{62} = imread('SURF image library/domino_15_sideways.jpg');
referenceImages{63} = imread('SURF image library/domino_16_sideways.jpg');
referenceImages{64} = imread('SURF image library/domino_22_sideways.jpg');
referenceImages{65} = imread('SURF image library/domino_23_sideways.jpg');
referenceImages{66} = imread('SURF image library/domino_24_sideways.jpg');
referenceImages{67} = imread('SURF image library/domino_25_sideways.jpg');
referenceImages{68} = imread('SURF image library/domino_26_sideways.jpg');
referenceImages{69} = imread('SURF image library/domino_33_sideways.jpg');
referenceImages{70} = imread('SURF image library/domino_34_sideways.jpg');
referenceImages{71} = imread('SURF image library/domino_35_sideways.jpg');
referenceImages{72} = imread('SURF image library/domino_36_sideways.jpg');
referenceImages{73} = imread('SURF image library/domino_44_sideways.jpg');
referenceImages{74} = imread('SURF image library/domino_45_sideways.jpg');
referenceImages{75} = imread('SURF image library/domino_46_sideways.jpg');
referenceImages{76} = imread('SURF image library/domino_55_sideways.jpg');
referenceImages{77} = imread('SURF image library/domino_56_sideways.jpg');
referenceImages{78} = imread('SURF image library/domino_66_sideways.jpg');

for i = 1 : size(referenceImages, 2);
    referenceImages{i} = rgb2gray(referenceImages{i});
    dominoPoints = detectSURFFeatures(referenceImages{i});
    [dominoFeatures, dominoPoints] = extractFeatures(...
            referenceImages{i}, dominoPoints);
    referenceFeatures{i} = dominoFeatures;
    referencePoints{i} = dominoPoints;
end




