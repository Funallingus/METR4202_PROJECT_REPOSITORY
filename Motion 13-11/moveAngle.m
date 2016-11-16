function moveAngle(pivotAngle, jointAngle1, jointAngle2, speed, DEFAULT_PORT)
%% takes in the angles to move each motor, moving up the arm
%   a speed for the motors, and the serial port
 ws = 'base';

%thresholds:
% motorPort 1: 2 degrees
% motorPort 2: 2 degrees
% motorPort 3: 5 degrees
% motor1 = 0;
% motor2 = 0;
% motor3 = 0;
% 
% jointSign1 = pivotAngle/abs(pivotAngle);
% jointSign2 = jointAngle1/abs(jointAngle1);
% jointSign3 = jointAngle2/abs(jointAngle2);
% 
assignin(ws, 'goalAngle1', pivotAngle);
assignin(ws, 'goalAngle2', jointAngle1);
assignin(ws, 'goalAngle3', jointAngle2);
torque = 800;

%moveArm(2, jointAngle1, speed, torque, DEFAULT_PORT);
moveArm(1, pivotAngle, speed, 1020, DEFAULT_PORT);
moveArm(2, jointAngle1, speed, torque, DEFAULT_PORT);
moveArm(3, jointAngle2, speed, torque, DEFAULT_PORT);

%% old code
% curAngle1 = 0;
% curAngle2 = 0;
% curAngle3 = 0;
% deltaAngle1 = 5* jointSign1;%(pivotAngle) / 25%25
% deltaAngle2 = 5* jointSign2;%(jointAngle1) / 10%deltaAngle1
% deltaAngle3 = 5* jointSign3;%(jointAngle2) / 10%deltaAngle1
% 
% while ((~(motor1))||(~(motor2))||(~(motor3)))%((abs(curAngle1-2) < abs(pivotAngle ))||(abs(curAngle2-2) < abs(jointAngle1))||(abs(curAngle3-2) < abs(jointAngle2)))
%     if abs(curAngle1) < abs(pivotAngle-2)
%             moveArm(1, (deltaAngle1), speed, torque, DEFAULT_PORT);
%             curAngle1 = curAngle1 + deltaAngle1;
%     else
%         fprintf('motor 1 reached');
%         motor1 = 1;
%         curAngle1 = curAngle1 + 1;
%         %moveArm(1, 0, speed, torque, DEFAULT_PORT);
%     end
%     if abs(curAngle2) < abs(jointAngle1-2)
%         moveArm(3, (deltaAngle2), speed, torque, DEFAULT_PORT);
%         curAngle2 = curAngle2 + deltaAngle2;
%     else
%         fprintf('motor 3 reached');
%         motor3 = 1;
%         curAngle2 = curAngle2 + 1;
%         %moveArm(3, 0, speed, torque, DEFAULT_PORT);
%     end
%     if abs(curAngle3) < abs(jointAngle2-2)
%             moveArm(2, (deltaAngle3), speed, torque, DEFAULT_PORT);
%             curAngle3 = curAngle3 + deltaAngle3;
%     else
%         fprintf('motor 2 reached');
%         motor2 = 1;
%         curAngle3  = curAngle3 + 1;
%         %moveArm(2, 0, speed, torque, DEFAULT_PORT);
%     end
% end    
% % A1 = pivotAngle / 10;
% % A2 = jointAngle1 / 10;
% % A3 = jointAngle2 /10;
% % 
% % for i = 1:10
% %     moveArm(1, A1, speed, 512, DEFAULT_PORT);
% %     moveArm(3, A2, speed, 512, DEFAULT_PORT);
% %     moveArm(2, A3, speed, 512, DEFAULT_PORT);
% % end

%% when moving to a point
% if pivotAngle < 15
%     sign = pivotAngle/abs(pivotAngle);
%     moveArm(1, sign*30, 200, 1020, DEFAULT_PORT);
%     moveArm(1, -1*sign*30-abs(pivotAngle), 200, 1020, DEFAULT_PORT);
% else
%     moveArm(1, pivotAngle, 200, 1020, DEFAULT_PORT);
% end




end