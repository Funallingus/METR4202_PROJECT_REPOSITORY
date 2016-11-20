function  fineMove(pivotAngle, jointAngle1, speed, port)

steps1 = round(pivotAngle*1024/300);
steps2 = round(jointAngle1*1024/300);
%loadlibrary('dynamixel', 'dynamixel.h');

%% Declarations
%libfunctions('dynamixel');
DEFAULT_BAUDNUM = 1;        % Baud rate
DEFAULT_PORTNUM = port;     % Port on computer
P_PRESENT_POSITION = 36;    % Dynamixal port for present pos
P_GOAL_POSITION = 30;       % Dynamixal port for setting goal pos
P_SPEED = 32;
P_TORQUE = 34;
P_VEL = 38;
%% Calibrate Connection

if (jointAngle1 ~= 0) && (pivotAngle ~= 0)
    ratio = abs(pivotAngle/jointAngle1)
    if pivotAngle > jointAngle1
        speed1 = speed
        speed2 = speed/ratio;
    else
        speed1 = speed*ratio;
        speed2 = speed;
    end
else
    speed1 = speed;
    speed2 = speed;
end

calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);
calllib('dynamixel','dxl_write_word',1, P_TORQUE, 1000); %USUALLY 500
calllib('dynamixel','dxl_write_word',1, P_SPEED, speed1); %USUALLY max 1023
calllib('dynamixel','dxl_write_word',2, P_TORQUE, 1000); %USUALLY 500
calllib('dynamixel','dxl_write_word',2, P_SPEED, speed2); %USUALLY max 1023
incr = 3;

if pivotAngle > 9000
        GOAL1 = 512;
else 
    if steps1 == 0
        incr = 3;
    end
    presentPos1 = int32(calllib( 'dynamixel', 'dxl_read_word', 1, P_PRESENT_POSITION));
    GOAL1 = presentPos1 + steps1;
end

if jointAngle1 > 9000
        GOAL2 = 512;
else 
    if steps2 == 0
        incr = 3;
    end
    presentPos2 = int32(calllib( 'dynamixel', 'dxl_read_word', 2, P_PRESENT_POSITION));
    GOAL2 = presentPos2 + steps2;
end

% motor limits
if GOAL1 > 816
    GOAL1 = 815;
elseif GOAL1 < 200
    GOAL1 = 200;
end

if GOAL2 < 50
    GOAL2 = 50;
elseif GOAL2 > 1000
    GOAL2 = 1000;
end

GOAL3 = int32(calllib('dynamixel', 'dxl_read_word', 3, P_PRESENT_POSITION));
count = 0;
loopCount = 0;
loopVal = 0;
presentPos = int32(calllib('dynamixel', 'dxl_read_word', 1, P_PRESENT_POSITION));
while ((presentPos < (GOAL1-incr))||(presentPos > (GOAL1+incr))) && ((presentPos2 < (GOAL2-incr))||(presentPos2 > (GOAL2+incr)))
    calllib('dynamixel', 'dxl_write_word', 1, P_GOAL_POSITION, GOAL1);
    calllib('dynamixel', 'dxl_write_word', 2, P_GOAL_POSITION, GOAL2);
    calllib('dynamixel', 'dxl_write_word', 3, P_GOAL_POSITION, GOAL3);
    presentPos = int32(calllib('dynamixel', 'dxl_read_word', 1, P_PRESENT_POSITION));
    presentPos2 = int32(calllib('dynamixel', 'dxl_read_word', 2, P_PRESENT_POSITION));
end

% if (presentPos2 < (GOAL2-incr))||(presentPos2 > (GOAL2+incr))
%     count = 0;
%     loopCount = 0;
%     loopVal = 0;
%     while ((presentPos2 < (GOAL2-incr))||(presentPos2 > (GOAL2+incr)))
%         loopVal = presentPos2;
%         calllib('dynamixel', 'dxl_write_word', 2, P_GOAL_POSITION, GOAL2);
%         presentPos2 = int32(calllib('dynamixel', 'dxl_read_word', 2, P_PRESENT_POSITION));
%         if presentPos2 == loopVal;
%             loopCount = loopCount + 1;
%         else
%             loopCount = 0;
%         end
% %         if loopVal > 50
% %             fprintf('breaking');
% %             break;
% %         end
%     end
% end
end

