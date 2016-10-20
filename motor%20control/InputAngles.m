function InputAngles(A_angle, B_angle, C_angle, speed)
% turned determined my right hand, from computerside
% positive powers
% Arm A - postive (anticlockwise looking from above
% Arm B - negative (clockwise looking side of computer)
% Arm C - positive (anticlockwise looking side of computer)
speed_A = speed;
speed_B = speed;
speed_C = speed;

%gear ratio's
%angles need to be corrected for gear ratio
 small_gear = 8;
 grey_medium_gear = 24;
 large_gear = 40;
 big_main_gear = 56;
 
 lift_height = 70;
 
 A_angle = (A_angle * big_main_gear * -1)/small_gear;
 B_angle = (B_angle * grey_medium_gear*-1)/small_gear;
 C_angle = (C_angle * large_gear *grey_medium_gear*-1)/(small_gear*small_gear);
 
if A_angle < 0;
    A_angle = A_angle * -1;
    speed_A = speed* 1;
else
    speed_A = speed*-1;
end 


if B_angle < 0;
    B_angle = B_angle * -1;
    speed_B = speed*1;
else 
    speed_B = speed*-1;
end

if C_angle < 0;
    C_angle = C_angle*-1;
else
    speed_C = speed*-1;
end


if speed_B < 0;
    temp_B_angle = B_angle + lift_height;
    moveArm('B', -speed_B, lift_height, 'HoldBrake');

    moveArm('C', speed_C, round(C_angle), 'HoldBrake');

    moveArm('A', speed_A, round(A_angle), 'HoldBrake');
    
    moveArm('B', -20, round(temp_B_angle), 'HoldBrake');

else
    temp_B_angle = B_angle + lift_height;
    moveArm('B', speed_B, round(temp_B_angle), 'HoldBrake');

    moveArm('C', speed_C, round(C_angle), 'HoldBrake');

    moveArm('A', speed_A, round(A_angle), 'HoldBrake');
    
    moveArm('B', -20, lift_height, 'HoldBrake');
end
end