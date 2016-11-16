function LAB3_INIT(Port)
%% Lab 3 init - takes in serial port number

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
P_LOAD = 40;

a2 = 245;   %% length (from above) from outer joint (motor2) to the endeffector tip
d1 = 115;   %% height of the arm (not used)
a1 = 188;   %% length from rotation axis of first motor to that of the second

DHParam = [d1, a1, a2];

%% set coordinates
%startPos = [0,a1+a2, 0];
%startPos = [190, 130, 0];   % this could be anything, abort() leaves the arm out stretched, so there is no x component and the y is the sum of arm lengths, z is always 0
startPos = [-60, 200, 0];
x1 = startPos(1);            % the x component deduces the quadrant motion should happen in -> the angle solution choice from ikineChur

quad1 = x1/abs(x1);        % quad1 will be 1 (right quadrant) or -1 (to the left); quad 1 is quadrant of the starting point
%nextPos = [160, 60, 0];
nextPos = [60, 200, 0];    % the above steps is repeated for the next position to move to
x2 = nextPos(1);

quad2 = x2/abs(x2);

if x1 == 0
    quad1 = quad2;
end
if x2 == 0
    quad2 = quad1;
end

%% altenative way of dealing with quadrant correction
sign = 1;
loadlibrary('dynamixel', 'dynamixel.h');
libfunctions('dynamixel');
DEFAULT_BAUDNUM = 1;        % Baud rate
P_PRESENT_POSITION = 36;       % Dynamixal port for setting goal pos
calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);
if nextPos(1) >= 0
    sign = 1;
else
    sign = -1;
end
%% calculate angles
if ((quad1>0) && (quad2>0))
    % the starting and point to move to are both in the right quadrant, use
    % use the first ikineChur solution
    quad = 1;
elseif ((quad1<0)&&(quad2<0))
    % the starting point and point to move to are both in the left
    % quadrant, use the second solution
    quad = -1;
else
    % using the quadrant of the starting position, move to the midpoint
    % between quadrants, recalculate and reset the quadrant to the one to
    % move into, move to the proposed location.
    fprintf('in else');
    
    %% move to the middle position    
    midPos = [5, 250, 0];   % defined mid position
    quad = quad1;           % use ikineChur solution determined by the quadrant of the starting position
    
    % using the start and mid points, calculate the change in angle to move the motors
    initAngles = ikineChur(startPos(1), startPos(2), startPos(3), d1, a1, a2, quad);    %quad is a parameter to ikine
    nextAngles = ikineChur(midPos(1), midPos(2), midPos(3), d1, a1, a2, quad);
    
    theta1 = (nextAngles(1) - initAngles(1));
    theta2 = sign*(nextAngles(2) - initAngles(2));
    
    delta1 = theta1
    delta2 = theta2
    % if the solution given is beyond the bounds of which motor1 can move,
    % create a new solution within quadrant 1 or 2 using the results (new set of angles)
    
    
    steps = round(theta1*1024/300);
    presentPos = int32(calllib( 'dynamixel', 'dxl_read_word', 1, P_PRESENT_POSITION));
    GOAL = presentPos + steps
    if GOAL >= 816
        delta1 = -(180-abs(theta1));
        delta2 = (270-abs(theta2));
    elseif GOAL <= 200
        delta1 = 180-abs(theta1);
        delta2 = -(270+abs(theta2));
    end
    moveAngle(delta1, delta2, 0, 100, DEFAULT_PORTNUM);

    % need to move from midpoint to next position, the quadrant of choice is
    % the opposite to the starting position
    %startPos = [0, 220, 0];
    
    %% rearrange arm
    %moveArm(2, sign*10, 50, 200, DEFAULT_PORTNUM);
    moveArm(3, -30, 100, 200, DEFAULT_PORTNUM);
    incr = 3;
    presentPos1 = int32(calllib( 'dynamixel', 'dxl_read_word', 1, P_PRESENT_POSITION));
    if presentPos1 >= 512
        GOAL = 502 - (presentPos1 - 512);
    else
        GOAL = 522 + (512-presentPos1);
    end
    while ((presentPos1 < (GOAL-incr))||(presentPos1 > (GOAL+incr)))
        calllib('dynamixel', 'dxl_write_word', 1, P_GOAL_POSITION, GOAL);
        presentPos1 = int32(calllib('dynamixel', 'dxl_read_word', 1 ,P_PRESENT_POSITION));
    end
    presentPos2 = int32(calllib( 'dynamixel', 'dxl_read_word', 2, P_PRESENT_POSITION));
    if presentPos2 >= 512
        GOAL = 502 - (presentPos2 - 512);
    else
        GOAL = 522 + (512 - presentPos2);
    end
    while ((presentPos2 < (GOAL-incr))||(presentPos2 > (GOAL+incr)))
        calllib('dynamixel', 'dxl_write_word', 2, P_GOAL_POSITION, GOAL);
        presentPos2 = int32(calllib('dynamixel', 'dxl_read_word', 2 ,P_PRESENT_POSITION));
    end
    moveArm(2, sign*5, 50, 200, DEFAULT_PORTNUM);
    moveArm(3, 30, 100, 200, DEFAULT_PORTNUM);
    moveArm(2, (-1)*sign*5, 50, 200, DEFAULT_PORTNUM);
    %% move the determined angles
    %moveAngle(delta1, delta2, 0, 100, DEFAULT_PORTNUM);

    % need to move from midpoint to next position, the quadrant of choice is
    % the opposite to the starting position
    startPos = [5, 250, 0];

    quad1 = quad2;
    if ((quad1>0) && (quad2>0))
        quad = 1;
    elseif ((quad1<0)&&(quad2<0))
        quad = -1;
    end
end

%%% move from start position to next position
%% calculate angles
initAngles = ikineChur(startPos(1), startPos(2), startPos(3), d1, a1, a2, quad);
nextAngles = ikineChur(nextPos(1), nextPos(2), nextPos(3), d1, a1, a2, quad);

theta1 = (nextAngles(1) - initAngles(1));
theta2 = sign*(nextAngles(2) - initAngles(2));

delta1 = theta1
delta2 = theta2

steps = round(theta1*1024/300);
presentPos = int32(calllib( 'dynamixel', 'dxl_read_word', 1, P_PRESENT_POSITION));
GOAL = presentPos + steps
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
delta2
% if theta1 > 89
%     delta1 = -(theta1 - 90);
%     delta2 = -theta2;
% elseif theta1 < -89
%     delta1 = -(theta1 + 90);
%     detla2 = -theta2;
% end
%% move the determined angles
% moveAngle(motor1 angle, motor2 angle, motor3 angle, speed, serial port number)
moveAngle(delta1, delta2, 0, 100, DEFAULT_PORTNUM);


end