function [dominoMatch, dominoPose] = identify_domino(candidateFeatures, index, referenceImages, referenceFeatures)
    dominoCandidatePairs = [];
    dominoPose = 1;
    dominoMatch = referenceImages{index};

%match lieing down
    [dominoCandidatePairsSearch, status] = matchFeatures(...
            referenceFeatures{index}, candidateFeatures);
%%if a better match found update matches features array
    if size(dominoCandidatePairs) < size(dominoCandidatePairsSearch)
        dominoCandidatePairs = dominoCandidatePairsSearch;
        dominoMatch = referenceImages{index};
        dominoPose = 1;
    end

    
%match upright
    [dominoCandidatePairsSearch, status] = matchFeatures(...
            referenceFeatures{index + 26}, candidateFeatures);
%%if a better match found update matches features array
    if size(dominoCandidatePairs) < size(dominoCandidatePairsSearch)
        dominoCandidatePairs = dominoCandidatePairsSearch;
        dominoMatch = referenceImages{index + 26};
        dominoPose = 2;
    end
 
%match sideways
        [dominoCandidatePairsSearch, status] = matchFeatures(...
            referenceFeatures{index}, candidateFeatures);
%%if a better match found update matches features array
    if size(dominoCandidatePairs) < size(dominoCandidatePairsSearch)
        dominoCandidatePairs = dominoCandidatePairsSearch;
        dominoMatch = referenceImages{index + 52};
        dominoPose = 3;
    end
    
    
    
    
end
%%check 