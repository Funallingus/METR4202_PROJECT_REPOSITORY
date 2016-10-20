%ikineChur
%A,B,C = theta1, theta2, theta3 respectively
%x,y,z = xyz coordinate of robot
%d is the link offset between motor A and motor B

function A = ikineChur(x, y, z, d1, a2, a3)

A(1) = (atan2(y,x)) * (180/pi()); %theta1 in degrees
D = (x^2 + y^2 + (z - d1)^2 - a2^2 - a3^2) / (2*a2*a3);
A(3) = atan2(D, sqrt(1-D^2));
A(2) = (atan2((z - d1), sqrt(x^2+y^2)) - ...
        atan2(a3*sin(A(3)), a2 + a3*cos(A(3)))) * (180/pi());
A(3) = A(3) * (180/pi());
A(3) = A(3) + 90;
end
