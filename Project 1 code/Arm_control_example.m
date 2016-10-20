function move_to_point(oldCords, newCords)

d1 = 170;
a2 = 185;
a3 = 180;

oldAngles = ikineChur(oldCords(1), oldCords(2), oldCords(3), d1, a2, a3)

%%convert lego cords to mm and shift the frame to the base of
%%the lego arm


%%find new angles
newAngles = ikineChur(newCords(1), newCords(2), newCords(3), d1, a2, a3)

%find change in angle between current and desired position
delta_a1 = newAngles(1) - oldAngles(1)
delta_a2 = newAngles(2) - oldAngles(2)
delta_a3 = newAngles(3) - oldAngles(3)

%send angles to motor
InputAngles(delta_a1, delta_a2, delta_a3, 50)

%InputAngles(-delta_a1, -delta_a2, -delta_a3, 50)

End