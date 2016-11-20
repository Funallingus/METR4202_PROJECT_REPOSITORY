function reorent(port);

C = getCoords(port);

fineAngle(3, -3, 0, port)
moveArm(3, 60000, 200, 200, port);
betweenPoints(port, C, [C(1)-35, C(2), 0]);
betweenPoints(port, [C(1)-30, C(2), 0], [C(1)-20, C(2)-15, 0]);
moveArm(3, 48, 200, 200, port);

moveArm(1, -9, 50, 100, port);
moveArm(2, 7, 50, 100, port);
moveArm(1, 4, 50, 100, port);
%C1 = getCoords(port);
%betweenPoints(port, C1, [C1(1)+30, C1(2)-10, 0]);
% moveArm(2, 5, 50, 100, port);
% moveArm(2, -7, 50, 100, port);
% C2 = getCoords(port);
% betweenPoints(port, C2, [C(2), C(2)-20, 0]);
% betweenPoints(port, C2, [C(2)+80, C(2), 0]);

end
