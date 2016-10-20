function O = clear_board(C)
%lift motor 'B' 80 degrees to clear pieces

moveArm('B', 50, 80, 'HoldBrake')
O(2) = C(2) + 80;
O(1) = C(1);
O(3) = C(3);
end