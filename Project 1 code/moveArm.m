function moveArm(Port, Power, Steps, ActionAtLimit)
%Port = motor port (argument = 'A', 'B', 'C')
%Power = power to feed to motor (+/- to specify direction)
%Steps = count in degrees (whole interger)
%ActionAtLimit = 'Coast', 'Brake', 'HoldBrake'
if Steps == 0;
    return
end
motor = NXTMotor(Port, 'Power', Power, 'TachoLimit', Steps, 'ActionAtTachoLimit', ActionAtLimit, 'SmoothStart', true);
motor.SendToNXT();
motor.WaitFor();

end