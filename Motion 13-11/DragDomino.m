function DragDomino(Port, OriginPos, Sequence)
% To drag a domino along a path of points 
% Sequence is a set of points in a array form [[x,y,z],......[X, Y, Z]]
% OriginPos is where the are is originally (not where it starts dragging)
%[a, b, c]

%EndEffector(84, 1); % Raise the end-effector 
LAB3(Port, OriginPos, Sequence(1:3)); % go to start of path
if Sequence(1) > 0
    sign = 1;
else
    sign = -1;
end
sign
EndEffector(Port, -1, sign); % lower the end-effector over the domino

Size = size(Sequence);
%length(Sequence) = Size(2)/3; %number  of points in path Sequence
Length = length(Sequence)/3;

for x = 1:(Length-1)
    Length;
    x = 3*(x -1) +1;
    A = Sequence(x:(x+2));
    B = Sequence((x+3):(x+5));
    
    LAB3(Port, Sequence(x:(x+2)), Sequence((x+3):(x+5)));
end

EndEffector(Port, 1); % Raise the end-effector 

end

