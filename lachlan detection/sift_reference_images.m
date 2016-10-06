
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


referenceImages{27} = imread('SURF image library/domino00_u.jpg');
referenceImages{28} = imread('SURF image library/domino01_u.jpg');
referenceImages{29} = imread('SURF image library/domino03_u.jpg');
referenceImages{30} = imread('SURF image library/domino05_u.jpg');
referenceImages{31} = imread('SURF image library/domino06_u.jpg');
referenceImages{32} = imread('SURF image library/domino11_u.jpg');
referenceImages{33} = imread('SURF image library/domino12_u.jpg');
referenceImages{34} = imread('SURF image library/domino13_u.jpg');
referenceImages{35} = imread('SURF image library/domino14_u.jpg');
referenceImages{36} = imread('SURF image library/domino15_u.jpg');
referenceImages{37} = imread('SURF image library/domino16_u.jpg');
referenceImages{38} = imread('SURF image library/domino22_u.jpg');
referenceImages{39} = imread('SURF image library/domino23_u.jpg');
referenceImages{40} = imread('SURF image library/domino24_u.jpg');
referenceImages{41} = imread('SURF image library/domino25_u.jpg');
referenceImages{42} = imread('SURF image library/domino26_u.jpg');
referenceImages{43} = imread('SURF image library/domino33_u.jpg');
referenceImages{44} = imread('SURF image library/domino34_u.jpg');
referenceImages{45} = imread('SURF image library/domino35_u.jpg');
referenceImages{46} = imread('SURF image library/domino36_u.jpg');
referenceImages{47} = imread('SURF image library/domino44_u.jpg');
referenceImages{48} = imread('SURF image library/domino45_u.jpg');
referenceImages{49} = imread('SURF image library/domino46_u.jpg');
referenceImages{50} = imread('SURF image library/domino55_u.jpg');
referenceImages{51} = imread('SURF image library/domino56_u.jpg');
referenceImages{52} = imread('SURF image library/domino66_u.jpg');


referenceImages{53} = imread('SURF image library/domino00_s.jpg');
referenceImages{54} = imread('SURF image library/domino01_s.jpg');
referenceImages{55} = imread('SURF image library/domino03_s.jpg');
referenceImages{56} = imread('SURF image library/domino05_s.jpg');
referenceImages{57} = imread('SURF image library/domino06_s.jpg');
referenceImages{58} = imread('SURF image library/domino11_s.jpg');
referenceImages{59} = imread('SURF image library/domino12_s.jpg');
referenceImages{60} = imread('SURF image library/domino13_s.jpg');
referenceImages{61} = imread('SURF image library/domino14_s.jpg');
referenceImages{62} = imread('SURF image library/domino15_s.jpg');
referenceImages{63} = imread('SURF image library/domino16_s.jpg');
referenceImages{64} = imread('SURF image library/domino22_s.jpg');
referenceImages{65} = imread('SURF image library/domino23_s.jpg');
referenceImages{66} = imread('SURF image library/domino24_s.jpg');
referenceImages{67} = imread('SURF image library/domino25_s.jpg');
referenceImages{68} = imread('SURF image library/domino26_s.jpg');
referenceImages{69} = imread('SURF image library/domino33_s.jpg');
referenceImages{70} = imread('SURF image library/domino34_s.jpg');
referenceImages{71} = imread('SURF image library/domino35_s.jpg');
referenceImages{72} = imread('SURF image library/domino36_s.jpg');
referenceImages{73} = imread('SURF image library/domino44_s.jpg');
referenceImages{74} = imread('SURF image library/domino45_s.jpg');
referenceImages{75} = imread('SURF image library/domino46_s.jpg');
referenceImages{76} = imread('SURF image library/domino55_s.jpg');
referenceImages{77} = imread('SURF image library/domino56_s.jpg');
referenceImages{78} = imread('SURF image library/domino66_s.jpg');

for i = 1 : size(referenceImages, 2);
    referenceImages{i} = rgb2gray(referenceImages{i});
    dominoPoints = detectSURFFeatures(referenceImages{i});
    [dominoFeatures, dominoPoints] = extractFeatures(...
            referenceImages{i}, dominoPoints);
    referenceFeatures{i} = dominoFeatures;
    referencePoints{i} = dominoPoints;
end

referenceLibrary = {referenceImages, referencePoints, referenceFeatures};




