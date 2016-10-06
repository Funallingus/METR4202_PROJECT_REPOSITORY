% extrinsics formation
% Change the formation of the camera matrix

function [extrinsics, invExtrinsics, cameraMatrix] = getCameraMatrix(...
        intrinsics, rotMatrix, transVector, f)
%% Form extrinsics matrix
extrinsics = rotMatrix;
extrinsics(4,:) = [0 0 0];
transVector(4) = 1;
extrinsics(:,4) = transVector;

%% Form inverse extrinsics matrix
invExtrinsics = transpose(rotMatrix);
% bottom row
invExtrinsics(4,:) = [0 0 0];
invExtrinsics(:,4) = transVector .* -1;
invExtrinsics(4:4) = 1;
% extrinsics = eye(4);

%% Form total intrinsics matrix K
fMatrix = eye(4);
fMatrix = fMatrix(1:3,:);
% fMatrix(1, 1) = f;
% fMatrix(2, 2) = f;

% Total matrix K = intrinsics * fMatrix (see lecture 7 slide 5)
intrinsics = transpose(intrinsics)
K = (intrinsics) * (fMatrix)
    
%% Form camera matrix K * Extrinsics
cameraMatrix = K * invExtrinsics;

end