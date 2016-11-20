function fineAngle(pivotAngle, jointAngle1, jointAngle2, DEFAULT_PORT)
%% takes in the angles to move each motor, moving up the arm
%   a speed for the motors, and the serial port
 ws = 'base';

assignin(ws, 'goalAngle1', pivotAngle);
assignin(ws, 'goalAngle2', jointAngle1);
assignin(ws, 'goalAngle3', jointAngle2);
torque = 1020;
speed = 80;

moveArm(3, jointAngle2/2, speed, 1020, DEFAULT_PORT);
if pivotAngle > 15 && jointAngle1 > 15
    moveArm(1, pivotAngle/6, speed*0.2, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/6, speed*0.2, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/6, speed*0.2, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/6, speed*0.2, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/6, speed*0.2, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/6, speed*0.2, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/6, speed*0.2, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/6, speed*0.2, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/6, speed*0.2, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/6, speed*0.2, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/6, speed*0.2, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/6, speed*0.2, 1000, DEFAULT_PORT);
elseif pivotAngle > 10 && jointAngle1 > 10
    moveArm(1, pivotAngle/4, speed*0.4, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/4, speed*0.4, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/4, speed*0.4, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/4, speed*0.4, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/4, speed*0.4, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/4, speed*0.4, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/4, speed*0.4, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/4, speed*0.4, 1000, DEFAULT_PORT);
elseif pivotAngle > 6 && jointAngle1 > 6
    moveArm(1, pivotAngle/3, speed*0.5, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/3, speed*0.5, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/3, speed*0.5, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/3, speed*0.5, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/3, speed*0.5, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/3, speed*0.5, 1000, DEFAULT_PORT);
elseif pivotAngle > 6
    moveArm(1, pivotAngle/3, speed*0.5, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/2, speed, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/3, speed*0.5, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/2, speed, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/3, speed*0.5, 1020, DEFAULT_PORT);
elseif jointAngle1 > 6
    moveArm(2, jointAngle1/3, speed*0.5, 1020, DEFAULT_PORT);
    moveArm(1, pivotAngle/2, speed, 1000, DEFAULT_PORT);
    moveArm(2, jointAngle1/3, speed*0.5, 1020, DEFAULT_PORT);
    moveArm(1, pivotAngle/2, speed, 1000, DEFAULT_PORT);
    moveArm(2, jointAngle1/3, speed*0.5, 1020, DEFAULT_PORT);
else
    moveArm(1, pivotAngle/2, speed*0.4, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/2, speed*0.4, 1000, DEFAULT_PORT);
    moveArm(1, pivotAngle/2, speed*0.4, 1020, DEFAULT_PORT);
    moveArm(2, jointAngle1/2, speed*0.4, 1000, DEFAULT_PORT);
end

moveArm(3, jointAngle2/2, speed, torque, DEFAULT_PORT);