function betweenPoints(Port, startPos, nextPos)
%% Lab 3 init - takes in serial port number


startPos
nextPos
% for testing, always run abort(#serial_port) first to move the arm into
% the starting position; if something goes wrong when the arm is moving,
% press ctrl-C and then immediently run the abort() function.
% to relax the motors, unplug the power supply from the motherboard (don't
% unplug the usb connection)
speed = 100;
torque = 200;
DEFAULT_PORT = Port;
P_GOAL_POSITION = 30;       % Dynamixal port for setting goal pos
DEFAULT_PORTNUM = Port;
%257
a2 = 257;   %% length (from above) from outer joint (motor2) to the endeffector tip
d1 = 115;   %% height of the arm (not used)
a1 = 194;   %% length from rotation axis of first motor to that of the second

DHParam = [d1, a1, a2];

%% set coordinates
%startPos = [0,a1+a2, 0];
%startPos = [190, 130, 0];   % this could be anything, abort() leaves the arm out stretched, so there is no x component and the y is the sum of arm lengths, z is always 0
%startPos = [-60, 200, 0];
x1 = startPos(1);            % the x component deduces the quadrant motion should happen in -> the angle solution choice from ikineChur
% startPos(2)
% nextPos(2)
quad1 = x1/abs(x1);        % quad1 will be 1 (right quadrant) or -1 (to the left); quad 1 is quadrant of the starting point
%nextPos = [160, 60, 0];
%nextPos = [60, 200, 0];    % the above steps is repeated for the next position to move to
x2 = nextPos(1);

quad2 = x2/abs(x2);

if x1 == 0
    quad1 = quad2;
end
if x2 == 0
    quad2 = quad1;
end

quad1
quad2


current = getCoords(Port)
if (quad1 < 0 && quad2 < 0)
    if startPos(1) == 0
        currentQuad = quad2;
    elseif current(1) == 0
        currentQuad = quad2;
    else
        currentQuad = current(1)/abs(current(1))
        if currentQuad ~= quad1
            startPos = [current(1), startPos(2), 0];
        end
    end
end
%% altenative way of dealing with quadrant correction
sign = 1;
% loadlibrary('dynamixel', 'dynamixel.h');
% libfunctions('dynamixel');
DEFAULT_BAUDNUM = 1;        % Baud rate
P_PRESENT_POSITION = 36;       % Dynamixal port for setting goal pos
calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);
if startPos(1) == 0
    sign = nextPos(1)/abs(nextPos(1));
else 
    if startPos(1) >= 0
        sign = 1;
    else
        sign = -1;
    end
end
%% calculate angles
if ((quad1>0) && (quad2>0))
    % the starting and point to move to are both in the right quadrant, use
    % use the first ikineChur solution
    quad = 1;
else
    % the starting point and point to move to are both in the left
    % quadrant, use the second solution
    quad = -1;
end


%%% move from start position to next position
%% calculate angles
initAngles = ikineChur(startPos(1), startPos(2), startPos(3), d1, a1, a2, quad);
nextAngles = ikineChur(nextPos(1), nextPos(2), nextPos(3), d1, a1, a2, quad);
quad;
theta1 = (nextAngles(1) - initAngles(1));
%theta2 = sign*(nextAngles(2) - initAngles(2));
theta2 = (nextAngles(2) - initAngles(2));
delta1 = theta1;
delta2 = theta2;
quad;

steps = round(theta1*1024/300);
presentPos = int32(calllib( 'dynamixel', 'dxl_read_word', 1, P_PRESENT_POSITION));
GOAL = presentPos + steps;
%if theta1 > 89
if GOAL >= 816
    delta1 = -(180-abs(theta1));
    delta2 = (270-abs(theta2));
elseif GOAL <= 200
    fprintf('small goal');
    delta1 = 180-abs(theta1);
    delta2 = -(270+abs(theta2));
end

delta1;
delta2;

%% move the determined angles
% moveAngle(motor1 angle, motor2 angle, motor3 angle, speed, serial port number)

fineAngle(delta1, delta2, 0, DEFAULT_PORTNUM);


end