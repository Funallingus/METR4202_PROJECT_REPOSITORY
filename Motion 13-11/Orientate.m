function Orientate(Port, DominoBox, Orientation)
%Takes the location and orientation angle of the Domino 
%Moves the Domino into correct orientation

%Domino's  are always bottom as we are stacking to the top of the arms
%reference frame
%DominoBox = [180, 130, 60, 48]
x = DominoBox(1)
y = DominoBox(2)
w = DominoBox(3)
h = DominoBox(4)
%[x, y, w, h] = DominoBox;
Sequence = [];
c = 0.30; %correction factor
b = 1-c; %from pos to neg
%Sequence = [[x+3w, y, 0], [x+3w, y, 0]];
if w == 2h
    %Do Nothing orientation correct
    %maybe push centre
    return;
elseif Orientation == 90
    d = b - 0.05;
    %orientate 90 degrees
    %orientate 90 degrees
%     Sequence = [[Sequence], x+w+50, y-(0.5*h), 0]; %start position
%     Sequence = [[Sequence], x+w+25, y-(0.5*h), 0];
% %     Sequence = [[Sequence], x+(w/2), y, 0]; %mid position
% %     Sequence = [[Sequence], x, y, 0];  % end position
%     %DragDomino(Port, Sequence);
%     % when orientation > 90
%     Sequence = [[Sequence], x+w, y +(0.8*h), 0]; %start position 
%     Sequence = [[Sequence], x+w/2, y +(0.8*h), 0]; %start position 
%     Sequence = [[Sequence], x-10, y +(0.8*h), 0]; %mid position
%     Sequence = [[Sequence], x-10, y +((1.3*h)), 0];  % end position
%     Sequence = [[Sequence], x-10, y +((2*h)), 0];
%     %DragDomino(Port, Sequence);
    a = 40; %width
    b = 45; %height
    Sequence = [[Sequence], x+a, y-b, 0]; %start position
    Sequence = [[Sequence], x+a, y-b, 0];
    Sequence = [[Sequence], x+a/2, y-b, 0];
    Sequence = [[Sequence], x, y-b, 0];
    Sequence = [[Sequence], x-a/2, y-b, 0];
    
    Sequence = [[Sequence], x, y-b/2, 0];
    Sequence = [[Sequence], x, y, 0];

    
elseif Orientation < 90
    
    Sequence = [[Sequence], x+(c*w), y-1.2*h, 0]; %start position
    Sequence = [[Sequence], x+(c*w), y-1.2*h, 0]; 
    Sequence = [[Sequence], x+(c*w), y-(h/2), 0]; %mid position
    Sequence = [[Sequence], x+(c*w), y-25, 0];  % end position
    %DragDomino(Port, Sequence);
    
    
else    
    % when orientation > 90
    Sequence = [[Sequence], x+(b*w), y-1.2*h, 0]; %start position
    Sequence = [[Sequence], x+(b*w), y-1.2*h, 0];
    Sequence = [[Sequence], x+(b*w), y-(h/2), 0]; %mid position
    Sequence = [[Sequence], x+(b*w), y-25, 0];  % end position
    %DragDomino(Port, Sequence);
end
runSequence(Port, Sequence);
%DragDomino(Port, Sequence);
%CurrentPos = getCoords(Port);
end













































