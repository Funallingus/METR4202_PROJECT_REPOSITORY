%% Called with every pixel point
%% COmputes the x and y coordinates from pixel coordinates

function worldCoords = getWorldCoords(pixelCoords, depthIm)

camMatrix = evalin('base', 'cameraMatrix')
cameraParams = evalin('base', 'cameraParams');
f = cameraParams.FocalLength(1);


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


% Z DEPTH
Z = int64(depthIm(pixelCoords(1), pixelCoords(2)));

pixelCoords

pixelCoords1 = int64(pixelCoords(1) * Z);
pixelCoords2 = int64(pixelCoords(2) * Z);
camMat14 = int64(camMatrix(1,4));
camMat13 = int64(camMatrix(1,3));
camMat24 = int64(camMatrix(2,4));
camMat23 = int64(camMatrix(2,3));

% LET Z EQUAL 1
rhs1 = (pixelCoords1 - camMatrix(1,4) - camMatrix(1,3)*1)
rhs2 = (pixelCoords2 - camMatrix(2,4) - camMatrix(2,3)*1)

syms x y

% Break matrix down into two equations to solve for X and Y in world
% coordinates given u and v pixel coordinates
eqn1 = camMatrix(1,1)*x + camMatrix(1,2)*y  == rhs1;
    
eqn2 = camMatrix(2,1)*x + camMatrix(2,2)*y  == rhs2;

% eqn3 = camMatrix(3,1)*x + camMatrix(3,2)*y == 1;

sol = solve([eqn1, eqn2], [x, y]);

worldCoords(1) = round(sol.x);
worldCoords(2) = round(sol.y);
worldCoords(3) = 1;
% worldCoords = worldCoords .* Z;
% Pin hole model
% worldCoords(1) = (pixelCoords(1) / f) * z;
% worldCoords(2) = (pixelCoords(2) / f) * z;
% x y coordinates from depth camera

% worldCoords(3) = z; %%THIS IS WHAT WE ARE GOING TO NEED TO FIX. 

end