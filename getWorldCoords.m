

function worldCoords = getWorldCoords(pixelCoords, depthIm)

camMatrix = evalin('base', 'cameraMatrix');

disp('PIXELCOORDS:');
pixelCoords
disp('CAM MAT14 & 24')
camMatrix(1,4)
camMatrix(2,4)
pixelCoords(3) = 1;

%Z coordinate
z = depthIm(pixelCoords(2), pixelCoords(1));

syms x y

% break matrix down into two equations
eqn1 = camMatrix(1,1)*x + camMatrix(1,2)*y  == (pixelCoords(2) - camMatrix(1,4) - camMatrix(1,3)*z)
    
eqn2 = camMatrix(2,1)*x + camMatrix(2,2)*y  == (pixelCoords(1) - camMatrix(2,4) - camMatrix(2,3)*z)

sol = solve([eqn1, eqn2], [x, y]);
worldCoords(1) = round(sol.x);
worldCoords(2) = round(sol.y);
worldCoords(3) = z;
worldCoords

end