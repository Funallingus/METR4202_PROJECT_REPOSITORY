function abort(port)
%% takes in a serial port number for the motor connection
% uses a simplified function of moving the arm; individually moves each
% joint to the desired angle.
% an angle >9000 will never be used in the lab, so any angle this large is
% defined to make the motors move to their centre positions
% set up to move the arm into a starting position

% moveArm(2, -50, 60, 200, port);
% moveArm(3, -45, 60, 200, port);

% make all the arms point straight
easy_move(10000, 10000, 10000, 100, port);

% easy_move(90, 60000, 60000, 50, port);
% easy_move(1, 75, 600, 50, port);

% lower the end-effector over the domino
%moveArm(3, 53, 60, 512, port);
end