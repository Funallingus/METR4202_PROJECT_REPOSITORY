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
steps = round(angle*1024/300);
% loadlibrary('dynamixel', 'dynamixel.h');

%% Declarations
libfunctions('dynamixel');
DEFAULT_BAUDNUM = 1;        % Baud rate
DEFAULT_PORTNUM = port;     % Port on computer
P_PRESENT_POSITION = 36;    % Dynamixal port for present pos
P_GOAL_POSITION = 30;       % Dynamixal port for setting goal pos
P_SPEED = 32;
P_TORQUE = 34;
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
    GOAL = presentPos + steps
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
end    


presentPos = int32(calllib( 'dynamixel', 'dxl_read_word', motorPort, P_PRESENT_POSITION));
while ((presentPos < (GOAL-incr))||(presentPos > (GOAL+incr)))
    calllib('dynamixel', 'dxl_write_word', motorPort, P_GOAL_POSITION, GOAL);
    presentPos = int32(calllib('dynamixel', 'dxl_read_word', motorPort ,P_PRESENT_POSITION));
end


fprintf('Done');


end