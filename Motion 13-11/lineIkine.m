function lineIkine(a1, a2, c, port)
%%%% uses the current position of the motors to calculate the distance
%%%% needed to travel to reach a point on the centre line at distance c,
%%%% for an arm of lengths a1 and a2, serially connected to port.
%%%% after computing, the moves move the tip to the point.




cos_alpha1 = (a2^2 - c^2 - a1^2)/(-2*c*a1);
alpha1 = abs(acos(cos_alpha1));
sin_alpha2 = (c*sin(alpha1)/a2);
alpha2 = abs(asin(sin_alpha2));

alpha1 = abs(alpha1*180/pi);
alpha2 = abs(alpha2*180/pi);
A = [alpha1, alpha2]

torque = 1000;
speed = 200;
loadlibrary('dynamixel', 'dynamixel.h');
libfunctions('dynamixel');
DEFAULT_BAUDNUM = 1;        % Baud rate
DEFAULT_PORTNUM = port;     % Port on computer
P_PRESENT_POSITION = 36;    % Dynamixal port for present pos
P_GOAL_POSITION = 30;       % Dynamixal port for setting goal pos
P_SPEED = 32;
P_TORQUE = 34;
P_VEL = 38;
calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);
% calllib('dynamixel','dxl_write_word',1, P_TORQUE, torque); %USUALLY 500
% calllib('dynamixel','dxl_write_word',1, P_SPEED, speed); %USUALLY max 1023
% calllib('dynamixel','dxl_write_word',2, P_TORQUE, torque); %USUALLY 500
% calllib('dynamixel','dxl_write_word',2, P_SPEED, speed); %USUALLY max 1023
incr = 2;
% 

presentPos1 = int32(calllib( 'dynamixel', 'dxl_read_word', 1, P_PRESENT_POSITION))
presentPos2 = int32(calllib( 'dynamixel', 'dxl_read_word', 2, P_PRESENT_POSITION))

if c > 340
    
    
    if presentPos1 > 512
        stepDiff1 = -((presentPos1-512)-(alpha1*1024/300))
    else
        stepDiff1 = (512 - presentPos1)-(alpha1*1024/300)
    end
    delta1 = stepDiff1*300/1024
    %moveArm(1, delta1, 50, 1000, port)
    
    
    if presentPos2 > 512
        stepDiff = -((presentPos2-512)-(alpha2*1024/300))
    else
        stepDiff = (512 - presentPos2)-(alpha2*1024/300)
    end
    delta2 = stepDiff*300/1024
    %moveArm(2, delta2, 50, 1000, port)
    
    
%     if presentPos1 > 512
%         theta1 = (512 - presentPos1)*300/1024
%         delta1 = alpha1 - theta1
%     else
%         theta1 = (512 - presentPos1)*300/1024
%         delta1 = theta1 - alpha1
%     end
%     moveArm(1, delta1, 40, 1000, port);
%     
%     alpha2 = 180 - alpha2
%     if presentPos2 > 512
%         theta2 = (512 - presentPos2)*300/1024
%         delta2 = 180 - (alpha2 - theta2)
%     else
%         theta2 = (512 - presentPos2)*300/1024
%         delta2 = (theta2 - alpha2)
%     end
%     moveArm(2, delta2, 40, 1000, port);
else 
%     % presentPos1 = 361;
%     % presentPos2 = 735;
    
    
    if presentPos1 > 512
        GOAL1 = (512 + alpha1*1024/300)
    else
        GOAL1 = (512 - alpha1*1024/300)
    end
    
    if presentPos1 > 512
        calcPos1 = 512 + alpha1*1024/300
        deltaPos = calcPos1 - presentPos1%presentPos1 - calcPos1;
    else
        calcPos1 = 512 - alpha1*1024/300
        deltaPos = calcPos1 - presentPos1%presentPos1 - calcPos1;
    end
    delta1 = deltaPos*300/1024
    
    alpha2 = 180-abs(alpha2)
    if presentPos2 > 512
        calcPos2 = 512 + alpha2*1024/300
        deltaPos = calcPos2 - presentPos2%presentPos2 - calcPos2;
    else
        calcPos2 = 512 - alpha2*1024/300
        deltaPos = calcPos2 - presentPos2%presentPos2 - calcPos2;
    end
    % delta2 = 180 + deltaPos*300/1024
    delta2 = deltaPos*300/1024
    
    

    
%     if delta1 > 6
%         moveArm(1, delta1/2, 1000, port);
%     end    
%         moveArm(2, detla
%     moveArm(1, delta1, 40, 1000, port);
%     moveArm(2, delta2, 40, 1000, port);
end

detla1 = delta1;
detla2 = delta2;

if delta1 > 5 && delta2 > 5
    
    moveArm(1, delta1/2, 40, 1000, port);
    moveArm(2, detla2/2, 40, 1000, port);
    moveArm(1, delta1/2, 40, 1000, port);
    moveArm(2, detla2/2, 40, 1000, port);
elseif delta1 > 5
    moveArm(1, delta1/2, 40, 1000, port);
    moveArm(2, detla2, 40, 1000, port);
    moveArm(1, delta1/2, 40, 1000, port);
elseif delta2 > 5
    moveArm(2, delta2/2, 40, 1000, port);
    moveArm(1, detla1, 40, 1000, port);
    moveArm(2, delta2/2, 40, 1000, port);
else
    moveArm(1, detla1, 40, 1000, port);
    moveArm(2, detla2, 40, 1000, port);
end


















%
%
% if presentPos1 > 512
%     if abs((512 - presentPos1)*300/1024) > alpha1
%         delta1 = abs(abs((512 - presentPos1)*300/1024) - alpha1)
%     else 
%         delta1 = abs((512 - presentPos1)*300/1024) - alpha1
%         %delta1 = -1*delta1
%     end
% else
%     abs((512 - presentPos1)*300/1024)
%     delta1 = abs((512 - presentPos1)*300/1024) - alpha1;
%     delta1 = -1*delta1
% end
% 
% %moveArm(1, delta1, 100, 1000, port);
% 
% if presentPos2 < 512
%     currentAngle1 = abs((512 - presentPos2)*300/1024)
%     delta2 = -(abs((512 - presentPos2)*300/1024) - (180-alpha2))
% else
%     abs((512 - presentPos2)*300/1024)
%     delta2 = abs((512 - presentPos2)*300/1024) - (180-alpha2)
% end
% 
% %moveArm(2, delta2, 100, 1000, port);
% 
% 
% 
% 
% % presentPos = int32(calllib( 'dynamixel', 'dxl_read_word', 1, P_PRESENT_POSITION));
% % % while ((presentPos < (GOAL1-incr))||(presentPos > (GOAL1+incr)))
% % %     calllib('dynamixel', 'dxl_write_word', 1, P_GOAL_POSITION, GOAL1);
% % %     presentPos = int32(calllib('dynamixel', 'dxl_read_word', 1,P_PRESENT_POSITION));
% % % end
% % 
% % if presentPos2 > 512
% %     GOAL2 = 512 + alpha2*1024/300;
% % else
% %     GOAL2 = 512 - alpha2*1024/300;
% % end
% % presentPos = int32(calllib( 'dynamixel', 'dxl_read_word', 2, P_PRESENT_POSITION));
% % while ((presentPos < (GOAL2-incr))||(presentPos > (GOAL2+incr)))
% %     calllib('dynamixel', 'dxl_write_word', 1, P_GOAL_POSITION, GOAL2);
% %     presentPos = int32(calllib('dynamixel', 'dxl_read_word', 2,P_PRESENT_POSITION));
% end

