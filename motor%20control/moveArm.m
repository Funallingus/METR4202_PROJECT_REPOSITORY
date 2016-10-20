function moveArm(MotorPort, Steps, Speed, Torque)
%Port = motor port (argument = 'A', 'B', 'C')  ABC, 123
%Power = power to feed to motor (+/- to specify direction)
%Steps = count in degrees (whole interger)
%ActionAtLimit = 'Coast', 'Brake', 'HoldBrake'

calllib('dynamixel','dxl_write_word',MotorPort, 30, Steps);
calllib('dynamixel','dxl_write_word',MotorPort, 34, Torque); %USUALLY 500
calllib('dynamixel','dxl_write_word',MotorPort, 32, Speed); %USUALLY max 1023

%NXTMotor(Port, 'Power', Power, 'TachoLimit', Steps, 'ActionAtTachoLimit', ActionAtLimit, 'SmoothStart', true);
%motor.SendToNXT();
%motor.WaitFor();

end