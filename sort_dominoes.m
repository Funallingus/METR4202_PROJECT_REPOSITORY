function [domino, dominoBoxDimensions, centroid] = sort_dominoes(oldDomino, ...
        oldDominoBoxDimensions, oldCentroid, dotCount)
totalPip = []; 
for i = 1 : size(dotCount, 1)
   totalPip = [totalPip; sum(dotCount(i, :))];   
end
totalPip
[B, I] = sort(totalPip, 'descend')

for i = 1 : size(oldDomino, 2)
    domino{i} = oldDomino{I(i)};
    dominoBoxDimensions{i} = oldDominoBoxDimensions{I(i)};
    centroid{i} = oldCentroid{I(i)};
end
end