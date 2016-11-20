function turn_table(time, frame, centroid, port)
% frame is picture
% 
revTime = 29;
speed = (2*pi)/revTime; %rad/sec

xDistance = 550;
yDistance = 350;
yOffset = 20;
xOffset = 5;
xConv = (size(frame, 2))/550;
yConv = (size(frame, 1))/350;
turnTable = [-198.7948, 203.1205, 91.6687];
centX = round((centroid(1) - (size(frame, 2)/2))/xConv - xOffset);
centY = round((size(frame, 1) - centroid(2))/yConv) + yOffset;

radius = sqrt((turnTable(1) - centX)^2 + (turnTable(2) - centY)^2);
radOffset = pi - atan2((turnTable(2) - centY),(turnTable(1) - centX));
timeOffset = 
%turnTable = [-198.7948, 203.1205, 91.6687];
moveArm(3, 60000, 200, 200, port);
moveArm(3, 30, 200, 200, port);
endEff = getCoords(port);
LAB3(port, endEff, [radius - abs(turnTable(1)), turnTable(2), 70.4]);
initialTime = time(5)*60 + time(6)
start = tic;
c = clock;
currentTime = c(5)*60 + c(6) - timeOffset;%+12
rads = 50;
range = 0.1;
mod(rads, 2*pi+radOffset)
% while mod(rads, 2*pi) > (radOffset) || mod(rads, 2*pi) < (radOffset-0.2) %mod(rads, 2*pi+radOffset) > 0.05
%     time = toc(start) + (currentTime - initialTime)+1;
%     rads = speed*time;
%     mod(rads, 2*pi)
% end
% moveArm(3, 8, 40, 50, port);
% moveArm(1, -15, 200, 200, port);
% moveArm(3, 60000, 200, 500, port);
end





