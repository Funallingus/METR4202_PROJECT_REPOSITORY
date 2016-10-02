

function worldCoords = getWorldCoords(pixelCoords, depthIm)

camMatrix = evalin('base', 'cameraMatrix');
cameraParams = evalin('base', 'cameraParams');
f = cameraParams.FocalLength(1);

%Z coordinate
z = double(depthIm(pixelCoords(1), pixelCoords(2)));

pixelCoords1 = double(pixelCoords(1));
pixelCoords2 = double(pixelCoords(2));

rhs1 = double(pixelCoords1 - camMatrix(1,4) - camMatrix(1,3)*z);
rhs2 = double(pixelCoords2 - camMatrix(2,4) - camMatrix(2,3)*z);

syms x y

% break matrix down into two equations
eqn1 = camMatrix(1,1)*x + camMatrix(1,2)*y  == rhs1
    
eqn2 = camMatrix(2,1)*x + camMatrix(2,2)*y  == rhs2

sol = solve([eqn1, eqn2], [x, y]);

worldCoords(1) = round(sol.x);
worldCoords(2) = round(sol.y);
% Pin hole model
% worldCoords(1) = (pixelCoords(1) / f) * z;
% worldCoords(2) = (pixelCoords(2) / f) * z;
worldCoords(3) = z;

end