function move_to_point(oldCords, newCords, DHParam, move)

oldAngles = ikineChur(oldCords(1), oldCords(2), oldCords(3), DHParam(1),...
        DHParam(2), DHParam(3));

%%convert lego cords to mm and shift the frame to the base of
%%the lego arm


bMotorScalar = 0; %exp(0.07*move);
cMotorScalar = 0; %exp(0.2*move);
aMotorScalar = 0; %exp(0.02*move);


%%find new angles
newAngles = ikineChur(newCords(1), newCords(2), newCords(3), DHParam(1),...
        DHParam(2), DHParam(3));

%find change in angle between current and desired position
delta_a1 = newAngles(1) - oldAngles(1);
delta_a2 = newAngles(2) - oldAngles(2);
delta_a3 = newAngles(3) - oldAngles(3);

if delta_a2 < 0;
    delta_a2 = delta_a2 - bMotorScalar;
else
    delta_a2 = delta_a2 + bMotorScalar;
end
if delta_a3 < 0;
    delta_a3 = delta_a3 - cMotorScalar;
else
    delta_a3 = delta_a3 + cMotorScalar;
end
if delta_a1 < 0;
    delta_a1 = delta_a1 - aMotorScalar;
else
    delta_a1 = delta_a1 + aMotorScalar;
end


%send angles to motor
InputAngles(delta_a1, delta_a2, delta_a3, 99)

%InputAngles(-delta_a1, -delta_a2, -delta_a3, 50)

end