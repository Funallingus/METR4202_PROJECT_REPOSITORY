function Orientate2(Port, EndPosition)
%Assuming end effector starts raised above domino 
%Domino starts pushed up against wall (approximately either 90 or 0 degrees
%to horizontal)
%EndPostition - Last Postition in sequence for drag domino
Sequence = [];
Top = EndPosition(2) + 50; 
Left = EndPosition(1) - 50;

%Move to Top Left
betweenPoints(Port, [EndPosition, 0], [Left, Top, 0]);

%Lower End effector to Sweep level
moveArm(3, 15, 200, 200, Port);
moveArm(3, 15, 200, 200, Port);
moveArm(3, 15, 200, 200, Port);
moveArm(3, 4, 40, 200, Port);

%Sweep Down 75mm
    for i = 1:15
    Sequence = [[Sequence], Left, (Top - i*5), 0];
    end
    
%Sweep Left to right 25mm
    for i = 1:5
    Sequence = [[Sequence], (Left - i*5), (Top - 15*5), 0];
    end
    
%Move back to left 25mm
betweenPoints(Port, [(Left+25), Top-75, 0], [Left, Top-75, 0]);

%raise end effector
moveArm(3, 60000, 200, 200, Port);

%Move to position 12.5 to the left and 50mm bellow Position
betweenPoints(Port, [Left, Top-75, 0], [Left+12.5, Top-100, 0]);


%lower end effector
moveArm(3, 15, 200, 200, Port);
moveArm(3, 15, 200, 200, Port);
moveArm(3, 15, 200, 200, Port);
moveArm(3, 4, 40, 200, Port);

%push up 100mm
    for i = 1:20
        Sequence = [[Sequence], (Left-12.5), ((Top-100) + i*5), 0];
    end
    
%raise end effector
moveArm(3, 60000, 200, 200, Port);
end
