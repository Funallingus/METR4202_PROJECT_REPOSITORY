function moveArm(motorPort, angle, speed, torque, port)
%motorPort = motor port (argument = 1, 2, 3)
%angle = count in degrees (whole interger)
%speed = velocity to move the arm in steps/sec
%torque = applied torque
%port = serial port
% if motorPort == 1
%     steps = round(angle*4096/360);
% else 
%     steps = round(angle*1024/300);
% end
angle;
steps = round(angle*1024/300);
% loadlibrary('dynamixel', 'dynamixel.h');

%% Declarations
% libfunctions('dynamixel');
DEFAULT_BAUDNUM = 1;        % Baud rate
DEFAULT_PORTNUM = port;     % Port on computer
P_PRESENT_POSITION = 36;    % Dynamixal port for present pos
P_GOAL_POSITION = 30;       % Dynamixal port for setting goal pos
P_SPEED = 32;
P_TORQUE = 34;
P_VEL = 38;
%% Calibrate Connection
calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);

calllib('dynamixel','dxl_write_word',motorPort, P_TORQUE, torque); %USUALLY 500
calllib('dynamixel','dxl_write_word',motorPort, P_SPEED, speed); %USUALLY max 1023
incr = 5;
%% Movement
if angle > 9000
%     if motorPort == 1
%         GOAL = 1024+2048;
%     elseif motorPort == 3
%         GOAL = 742;
%     else 
        GOAL = 512;
%     end
    %incr = 2;
else 
    if steps == 0
        incr = 2;
    end
    presentPos = int32(calllib( 'dynamixel', 'dxl_read_word', motorPort, P_PRESENT_POSITION));
    GOAL = presentPos + steps;
end

% motor limits
if motorPort == 1
    if GOAL > 816
        GOAL = 815;
    elseif GOAL < 200
        GOAL = 200;
    end
    incr = 2;
elseif motorPort == 2
    if GOAL < 50
        GOAL = 50;
    elseif GOAL > 1000
        GOAL = 1000;
    end
elseif motorPort == 3
    if GOAL < 102
        GOAL = 103;
    elseif GOAL > 920
        GOAL = 919;
    end
    if angle > 0 && angle < 1000
        calllib('dynamixel','dxl_write_word',motorPort, P_TORQUE, 55); %USUALLY 500
        calllib('dynamixel','dxl_write_word',motorPort, P_SPEED, 30); %USUALLY max 1023
%     else
%         calllib('dynamixel','dxl_write_word',motorPort, P_TORQUE, 200); %USUALLY 500
%         calllib('dynamixel','dxl_write_word',motorPort, P_SPEED, 100); %USUALLY max 1023
    end
end
GOAL;
count = 0;
loopCount = 0;
loopVal = 0;
presentPos = int32(calllib( 'dynamixel', 'dxl_read_word', motorPort, P_PRESENT_POSITION));
while ((presentPos < (GOAL-incr))||(presentPos > (GOAL+incr)))
    loopVal = presentPos;
    calllib('dynamixel', 'dxl_write_word', motorPort, P_GOAL_POSITION, GOAL);
    if motorPort == 3 && angle > 29 && angle < 90 && presentPos > 650
        presentVel = int32(calllib( 'dynamixel', 'dxl_read_word', motorPort, P_VEL));
        if presentVel < 1
            count = count + 1;
            if count > 10
                break;
            end
        end
    end
    presentPos = int32(calllib('dynamixel', 'dxl_read_word', motorPort ,P_PRESENT_POSITION));
%     if presentPos == loopVal;
%         loopCount = loopCount + 1;
%     else
%         loopCount = 0;
%     end
%     if loopVal > 25
%         fprintf('breaking');
%         break;
%     end
end


fprintf('Done');


end