function turn_table(time, frame, centroid, port, correction)
% frame is picture
% 
abort(port);
moveArm(2, 110, 200, 200, port)
moveArm(1, -45, 200, 200, port);
%moveArm(3, 30, 200, 200, port)

revTime = 25.31;
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
timeOffset = radOffset/speed;
% %turnTable = [-198.7948, 203.1205, 91.6687];
moveArm(3, 60000, 200, 200, port);
moveArm(3, 15, 200, 200, port);
moveArm(3, 15, 200, 200, port);
endEff = getCoords(port);
LAB3(port, endEff, [radius - 20 - abs(turnTable(1)), turnTable(2), 70.4]);
endEff2 = getCoords(port);
LAB3(port, endEff2, [radius - 20 - abs(turnTable(1)), turnTable(2), 70.4]);
correction = correction*pi/180;
correctionTime = correction/speed;
initialTime = time(5)*60 + time(6) + timeOffset - correctionTime;
radius
radOffset

abs(turnTable(1))
start = tic;
c = clock;
currentTime = c(5)*60 + c(6);%+12
rads = 50;
range = 0.1;
mod(rads, 2*pi+radOffset)
while mod(rads, 2*pi) > (0.06) && mod(rads, 2*pi) < (2*pi-0.08) %mod(rads, 2*pi+radOffset) > 0.05
    time = toc(start) + (currentTime - initialTime)+1;
    rads = speed*time;
    mod(rads, 2*pi)
    %if mod(rads, 2*pi) < (0.15) || mod(rads, 2*pi) > (2*pi-0.15)
    %    break
    %end
end
%moveArm(3, 12, 40, 50, port);
catchDominoPlease(3, 15, 40, 50, port)
moveArm(1, -15, 200, 200, port);
moveArm(3, 60000, 200, 500, port);
end





