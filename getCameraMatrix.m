% extrinsics formation

function cameraMatrix = getCameraMatrix(intrinsics, rotMatrix, ...
    transVector, f)
%% Form extrinsics matrix
extrinsics = rotMatrix;

% bottom row
extrinsics(4,:) = [0 0 0];

% right column
transVector(4) = 1;
extrinsics(:,4) = transVector;

%% Form total intrinsics matrix K
fMatrix = eye(4);
fMatrix = fMatrix(1:3,:);
fMatrix(1, 1) = f;
fMatrix(2, 2) = f;

% Total matrix K = intrinsics * fMatrix (see lecture 7 slide 5)
K = intrinsics * fMatrix;

%% Form camera matrix K * Extrinsics
cameraMatrix = K * inv(extrinsics);

end