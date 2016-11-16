xDistance = 550;
yDistance = 350;
yOffset = 35;

abort(3);
yConv = (cnrPoints(2) + cnrPoints(4)...
    - cnrPoints(6) - cnrPoints(8))/yDistance;

xConv = (cnrPoints(3) + cnrPoints(5)...
    - cnrPoints(1) - cnrPoints(7))/xDistance;
xConv = (size(frame, 2))/550;
yConv = (size(frame, 1))/350;
start = 194+257;

cent = [];

for i = 1 %size(centroid, 2)
    workspace = obstructionMap';
    centX = round((centroid{i}(1) - (size(frame, 2)/2))/xConv);
    centY = round((size(frame, 1) - centroid{i}(2))/yConv) + yOffset;
    if(centY < 150 && abs(centX) < 150)
        continue;
    end
    for k = 1 : size(dominoBoxDimensions, 2)
       if i == k
           continue;
       end 
       for a = dominoBoxDimensions{k}(1) : dominoBoxDimensions{k}(1) + dominoBoxDimensions{k}(3)
            for b = dominoBoxDimensions{k}(2) - dominoBoxDimensions{k}(4) : dominoBoxDimensions{k}(2)
                workspace(round(a), round(b)) = 0;
            end
       end    
    end
    cent = [cent; centX, centY];
    workspace = workspace';
%     figure(); imshow(workspace);
    
%     LAB3(3, [0, start, 0], [centX, centY, 0]);
    abort(3);
    sequence = A_Star1([centroid{i}(1) , centroid{i}(2)],...
            [1465, 345], workspace);
    array = [];
    for m = 1 : 1: size(sequence, 1)
        array = [array, [(sequence(m, 1) - (size(frame, 2)/2))/xConv, round((size(frame, 1) - sequence(m, 2))/yConv) + yOffset, 0]]
    end
    DragDomino(3, [0, start, 0], array);
end