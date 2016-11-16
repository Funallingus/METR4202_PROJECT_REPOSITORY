function easy_move(pivotAngle, jointAngle1, jointAngle2, speed, DEFAULT_PORT)

moveArm(3, jointAngle1, speed, 800, DEFAULT_PORT);

moveArm(1, pivotAngle, 200, 1000, DEFAULT_PORT);

moveArm(2, jointAngle2, speed, 800, DEFAULT_PORT);

end