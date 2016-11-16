function A = getCoords(a1, a2, a3, port)
%%%% reads the current positions of the motors, and uses this to compute
%%%% the approximate location of the end effector relative to the axis of
%%%% the first motor, as A.


loadlibrary('dynamixel', 'dynamixel.h');
libfunctions('dynamixel');
DEFAULT_BAUDNUM = 1;        % Baud rate
DEFAULT_PORTNUM = port;     % Port on computer
P_PRESENT_POSITION = 36;    % Dynamixal port for present pos
calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);
%% current step positions
presStep1 = double(calllib( 'dynamixel', 'dxl_read_word', 1, P_PRESENT_POSITION));
presStep2 = double(calllib( 'dynamixel', 'dxl_read_word', 2, P_PRESENT_POSITION));
presStep3 = double(calllib( 'dynamixel', 'dxl_read_word', 3, P_PRESENT_POSITION));
%% current angles
theta1 = (512 - presStep1)*(pi/180)*(300/1024)
theta2 = (512 - presStep2)*(pi/180)*300/1024
theta3 = (512 - presStep3)*(-pi/180)*300/1024
%% calcs

a3_x = (a3*cos(theta3));
a2 = a2 + a3_x

z = a3*sin(theta3);

y = (a1*cos(theta1) + a2*cos(theta1 + theta2));

x = a1*sin(theta1) + a2*sin(theta1 + theta2);

% A1 = [cos(theta1), -sin(theta1), 0, a1*cos(theta1); ...
%     sin(theta1), cos(theta1), 0, a1*sin(theta1); ...
%     0, 0, 1, 0;...
%     0, 0, 0, 1 ];
% 
% A2 = [cos(theta2), -sin(theta2), 0, a2*cos(theta2); ...
%     sin(theta2), cos(theta2), 0, a2*sin(theta2); ...
%     0, 0, 1, 0;...
%     0, 0, 0, 1 ];
% 
% % A3 = [ 1, 0, 0, a3*cos(theta3); ...
% %     0, cos(theta3), -sin(theta3), a3*cos(theta3); ...
% %     0, sin(theta3), cos(theta3), 0; ...
% %     0, 0, 0, 1 ];
% 
% A3 = [cos(theta3), -sin(theta3), 0, a3*cos(theta3); ...
%     0, 0, 1, a3*sin(theta3); ...
%     -sin(theta3), -cos(theta3), 1, 0;...
%     0, 0, 0, 1 ];
% 
% T = A1*A2*A3;
% B = [a3*sin(theta3); a3*cos(theta3); 0; 1];
% %B = [a3*cos(theta3); a3*sin(theta3); 0; 1];
% 
% A = T*B;
A = [x, y, z];
end
