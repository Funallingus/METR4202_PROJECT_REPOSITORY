function C = transform_cords(x, y, z)
%Transform cords from lego units to mm
%and also shift origin from spec sheet (front left corner)
%to manipulator location
x = x * 32 - 16;
y = y * 32 - 16;
z = z * 20;
C(1) = x + 57;
C(2) = y - 165;
C(3) = z;


end