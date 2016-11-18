xDistance = 550;
yDistance = 350;
yOffset = 25;
xOffset = 5;
Port = 3;
abort(Port);
Positions_generator;

% yConv = (cnrPoints(2) + cnrPoints(4)...
%     - cnrPoints(6) - cnrPoints(8))/yDistance;
% 
% xConv = (cnrPoints(3) + cnrPoints(5)...
%     - cnrPoints(1) - cnrPoints(7))/xDistance;
xConv = (size(frame, 2))/550;
yConv = (size(frame, 1))/350;
start = 194+257;

for i = 1 : size(Positions, 1);
    Positions(i, 1) = Positions(i, 1) * xConv;
    Positions(i, 2) = Positions(i, 2) * yConv;
end

cent = [];
final_coords = [size(frame, 2) - 350, 10; size(frame, 2) - 350, 200; size(frame, 2) - 350, 300];

for i = 1 : size(domino, 2)
    workspace = obstructionMap';
    centX = round((centroid{i}(1) - (size(frame, 2)/2))/xConv - xOffset);
    centY = round((size(frame, 1) - centroid{i}(2))/yConv) + yOffset;
    if(centY < 150 && abs(centX) < 150)
        continue;
    end
    for k = 1 : size(dominoBoxDimensions, 2)
       if i == k
           continue;
       end
       bottomX = dominoBoxDimensions{k}(1)* 0.8;
       bottomY = (dominoBoxDimensions{k}(2) - dominoBoxDimensions{k}(4)) * 0.9;
       topX = (dominoBoxDimensions{k}(1) + dominoBoxDimensions{k}(3)) * 1.2;
       topY = dominoBoxDimensions{k}(2) * 1.1;
       if bottomX < 1
           bottomX = 1;
       end
       if bottomY < 1
           bottomY = 1;
       end
       if topX > size(obstructionMap, 2)
           topX = size(obstructionMap, 2);
       end
       if topY > size(obstructionMap, 1)
           topY = size(obstructionMap, 1);
       end
       
       for a = bottomX : topX
            for b = bottomY : topY
                workspace(round(a), round(b)) = 0;
            end
       end    
    end
    cent = [cent; centX, centY];
    workspace = workspace';
%     figure(); imshow(workspace);
    
%     LAB3(3, [0, start, 0], [centX, centY, 0]);
    abort(Port);
    sequence = A_Star1([centroid{i}(1) , centroid{i}(2)], ...
            Positions(i,:), workspace);
    array = [];
    for m = 1 : 1: size(sequence, 1)
        array = [array, [(sequence(m, 1) - (size(frame, 2)/2))/xConv, round((size(frame, 1) - sequence(m, 2))/yConv) + yOffset, 0]]
    end
    DragDomino(Port, [0, start, 0], array);
    dominoBoxDimensions{i}(1) = sequence(end, 1) - dominoBoxDimensions{i}(3)/2;
    dominoBoxDimensions{i}(2) = sequence(end, 1) - dominoBoxDimensions{i}(4)/2;
end