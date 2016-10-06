function [dominoMatch, dominoPose] = identify_domino(candidateFeatures, index, referenceImages, referenceFeatures)
    dominoCandidatePairs = [];
    dominoPose = 2;
    
    dominoMatch = referenceImages{index};
    
for i = 1 : 78
%match lieing down
    [dominoCandidatePairsSearch, status] = matchFeatures(...
            referenceFeatures{i}, candidateFeatures);
%%if a better match found update matches features array
    if size(dominoCandidatePairs) < size(dominoCandidatePairsSearch)
        dominoCandidatePairs = dominoCandidatePairsSearch;
        dominoMatch = referenceImages{i};
        dominoPose = ceil(i/26);
    end
end
 
end
%%check 