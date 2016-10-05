% Distance between two points 

function dist = distance2(point1, point2)

%% Compute the distance between given points

dist = int64(sqrt(double((point1(1)-point2(1))^2 + (point1(2)-point2(2))^2 + ...
            (point1(3)-point2(3))^2)));