xDistance = 550;
yDistance = 350;
yOffset = 15;

abort(3);
yConv = (cnrPoints(2) + cnrPoints(4)...
    - cnrPoints(6) - cnrPoints(8))/yDistance;

xConv = (cnrPoints(3) + cnrPoints(5)...
    - cnrPoints(1) - cnrPoints(7))/xDistance;
xConv = (size(frame, 2))/550;
yConv = (size(frame, 1))/350;
start = 245 + 188;

cent = [];
for i = 1 : size(centroid, 2)
    centX = round((centroid{i}(1) - (size(frame, 2)/2))/xConv);
    centY = round((size(frame, 1) - centroid{i}(2))/yConv) + yOffset;
    LAB3(3, [0, start, 0], [centX, centY, 0]);
    abort(3);
    cent = [cent; centX, centY];
end