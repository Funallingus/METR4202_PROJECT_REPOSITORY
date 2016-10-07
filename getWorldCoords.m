%% Called with every pixel point
%% COmputes the x and y coordinates from pixel coordinates

function worldCoords = getWorldCoords(pixelCoords, depthIm)

camMatrix = evalin('base', 'camMatrix');
intrinsics = evalin('base', 'cameraParams.IntrinsicMatrix');
intrinsics = transpose(intrinsics);
cameraParams = evalin('base', 'cameraParams');
extrinsics = evalin('base', 'extrinsics')
fx = cameraParams.FocalLength(1);
fy = cameraParams.FocalLength(2);

%%Parameters of the IR/Depth Camera
fx_depth = 366; % pixel units
fy_depth = 366; % pixel units
u_depth = 355; % pixel units
v_depth = 306; % pixel units

F_depth = 365.7; % mms

% X_from_depth = (uint32(pixelCoords(1)) * ... 
%                 uint32(depthIm(pixelCoords(1), pixelCoords(2))))  / F_depth
% Y_from_depth = (uint32(pixelCoords(2)) * ...
%                 uint32(depthIm(pixelCoords(1), pixelCoords(2)))) / F_depth
% Z_from_depth = depthIm(pixelCoords(1), pixelCoords(2))


% Z coordinate
z = double(depthIm(pixelCoords(1), pixelCoords(2)))

pixelCoords

pixelCoords1 = double(pixelCoords(1));
pixelCoords2 = double(pixelCoords(2));
camMat14 = (camMatrix(1,4));
camMat13 = (camMatrix(1,3));
camMat24 = (camMatrix(2,4));
camMat23 = (camMatrix(2,3));

rhs1 = (pixelCoords1 - camMatrix(1,4) - camMatrix(1,3)*z)
rhs2 = (pixelCoords2 - camMatrix(2,4) - camMatrix(2,3)*z)

syms x y

% Break matrix down into two equations to solve for X and Y in world
% coordinates given u and v pixel coordinates
eqn1 = camMatrix(1,1)*x + camMatrix(1,2)*y  == rhs1;
    
eqn2 = camMatrix(2,1)*x + camMatrix(2,2)*y  == rhs2;

eqn3 = camMatrix(3,1)*x + camMatrix(3,2)*y == 1;

sol = solve([eqn1, eqn2], [x, y]);
[A,B] = equationsToMatrix([eqn1, eqn2], [x, y]);
X = linsolve(A, B);

% worldCoords(1) = sol.x;
% worldCoords(2) = sol.y;
% worldCoords(3) = z;

%% Pinhole then transformation using extrinsics
pinHoleCoords(1) = (pixelCoords1 / fx) * z;
pinHoleCoords(2) = (pixelCoords2 / fy) * z;
pinHoleCoords(3) = z;

pinHoleCoords(4) = 1;

pinHoleCoords

% Relative to the camera origin
% worldCoords = pinHoleCoords;

% Apply the transformation matrix
worldCoords = extrinsics * pinHoleCoords';

% Transform to placed frame using inv(extrinsics) matrix (transformation matrix)
class pinHoleCoords
% worldCoords = extrinsics * pinHoleCoords';


%% Using complete camera model (equations are above)

% worldCoords(1) = double(X(1))
% worldCoords(2) = double(X(2))
% worldCoords(3) = z;
% worldCoords(1) = round(sol.x);
% worldCoords(2) = round(sol.y);
% Pin hole model
% worldCoords(1) = (pixelCoords(1) / f) * z;
% worldCoords(2) = (pixelCoords(2) / f) * z;
% x y coordinates from depth camera

% worldCoords(3) = z; %%THIS IS WHAT WE ARE GOING TO NEED TO FIX. 

end