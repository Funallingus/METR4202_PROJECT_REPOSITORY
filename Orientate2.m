function Orientate2(Port, EndPosition)
%Assuming end effector starts raised above domino 
%Domino starts pushed up against wall (approximately either 90 or 0 degrees
%to horizontal)
%EndPostition - Last Postition in sequence for drag domino
Sequence = [];
Top = EndPosition(2) + 30; 
Left = EndPosition(1) - 30;

angle = 20;

moveArm(3, -angle, 200, 800, Port); % Raise Arm

%Move to Top Left
betweenPoints(Port, [EndPosition, 0], [Left, Top, 0]);

%Lower End effector to Sweep level
moveArm(3, angle, 200, 800, Port);
% moveArm(3, 15, 200, 800, Port);
% moveArm(3, 15, 200, 800, Port);
% moveArm(3, 4, 100, 800, Port);

%Sweep Down 75mm and 25mm in line
LAB3(Port, [Left, Top, 0], [Left+25, Top-80, 0])

% % %Sweep Down 75mm
% % Sequence = [];
% %     for i = 1:80
% %     Sequence = [[Sequence], Left, (Top - i*10), 0];
% %     end
% % runSequence(Port, Sequence);
% %     
% % %Sweep Left to right 25mm
% % Sequence = [];
% %     for i = 1:5
% %     Sequence = [[Sequence], (Left - i*5), (Top - 80), 0];
% %     end
% %     Sequence
% % runSequence(Port, Sequence);
    
%Move back to left 25mm
betweenPoints(Port, [(Left+25), Top-80, 0], [Left, Top-80, 0]);

%raise end effector
moveArm(3, -angle, 200, 800, Port);

%Move to position 12.5 to the left and 50mm bellow Position
betweenPoints(Port, [Left, Top-80, 0], [Left+12.5, Top-100, 0]);


%lower end effector
moveArm(3, angle, 200, 800, Port);

%push up 100mm
Sequence = [];
    for i = 1:10
        Sequence = [[Sequence], (Left+12.5), ((Top-100) + i*10), 0];
    end
runSequence(Port, Sequence);
    
%raise end effector
moveArm(3, 60000, 200, 200, Port);
end
