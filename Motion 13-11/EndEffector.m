function EndEffector(Port, RaiseLower, Sign)
% if RaiseLower >= 0 (Raise) if < 0 Lower
if RaiseLower >= 0 
    moveArm(3, -70, 60, 512, Port);
else
    %moveArm(1, Sign*(5), 80, 1000, Port);
    moveArm(3, 70, 60, 512, Port);
    %moveArm(1, Sign*(-5), 80, 1000, Port);
    
    % CHANGE FOR qUADRANT
end
       
end