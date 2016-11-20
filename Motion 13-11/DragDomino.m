%function DragDomino(Port, Sequence)
function DragDomino(Port, OriginPos, Sequence)
% To drag a domino along a path of points 
% Sequence is a set of points in a array form [[x,y,z],......[X, Y, Z]]
% OriginPos is where the are is originally (not where it starts dragging)
%[a, b, c]
%OriginPos = getCoords(Port);

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
count = 0;
for x = 1:(Length-1)
    %Length;
    x = 3*(x -1) +1;
    %A = Sequence(x:(x+2));
    %B = Sequence((x+3):(x+5));
    %currentPos = getCoords(Port);
    %LAB3(Port, Sequence(x:(x+2)), Sequence((x+3):(x+5)));
    count = count + 1;
    currentPos = getCoords(Port);
    %if mod(count, 5) == 4
    %if (Sequence(x) > 40 || Sequence(x) < 40) && (mod(count, 5) == 4)
    if Sequence(x) > 40 && mod(count, 4) == 3 && currentPos(1) > 25
        %LAB3(Port, Sequence(x:(x+2)), Sequence((x+3):(x+5)));
        currentPos = getCoords(Port);
        LAB3(Port, currentPos, Sequence((x+3):(x+5)));
    else
        LAB3(Port, Sequence(x:(x+2)), Sequence((x+3):(x+5)));
    end
end

EndEffector(Port, 1, sign); % Raise the end-effector 

end

