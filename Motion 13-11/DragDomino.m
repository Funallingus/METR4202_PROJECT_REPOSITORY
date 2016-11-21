%function DragDomino(Port, Sequence)
function DragDomino(Port, OriginPos, Sequence)
% To drag a domino along a path of points 
% Sequence is a set of points in a array form [[x,y,z],......[X, Y, Z]]
% OriginPos is where the are is originally (not where it starts dragging)
%[a, b, c]
%OriginPos = getCoords(Port);

%EndEffector(84, 1); % Raise the end-effector
    
if Sequence(1)/abs(Sequence(1)) > 0
    Sequence(1+1) = Sequence(1+1) + 7;
    Sequence(1) = Sequence(1)-3;
end
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
%     
%     if Sequence(x)/abs(Sequence(x)) > 0
%         Sequence(x+1) = Sequence(x+1) + 7;
%     end
    
    %A = Sequence(x:(x+2));
    %B = Sequence((x+3):(x+5));
    %currentPos = getCoords(Port);
    %LAB3(Port, Sequence(x:(x+2)), Sequence((x+3):(x+5)));
    count = count + 1;
    currentPos = getCoords(Port);
    currentPos(3) = 0;
    hypotenuse = sqrt(currentPos(1)^2+currentPos(2)^2);
    %if mod(count, 5) == 4
    %if (Sequence(x) > 40 || Sequence(x) < 40) && (mod(count, 5) == 4)
    
    %%%%swapped these two
    if mod(count, 4) == 3 && currentPos(1) > 20 && hypotenuse < (194+257)
        if currentPos(1)/abs(currentPos(1)) == Sequence(1)/abs(Sequence(1))
            LAB3(Port, currentPos, Sequence((x+3):(x+5)));
        else
        LAB3(Port, Sequence(x:(x+2)), Sequence((x+3):(x+5)));
        end
    elseif Sequence(x) > 25 && (mod(count, 4)== 2 || mod(count, 4) == 3) && currentPos(1) > 20 && hypotenuse < (194+257)
    %if abs(Sequence(x)) > 40 && mod(count, 3) == 2 && ...
    %        currentPos(1) > 25 && ...
    %        (abs(abs(Sequence(x)) - abs(currentPos(1)))) < 80
        
        %LAB3(Port, Sequence(x:(x+2)), Sequence((x+3):(x+5)));
%         currentPos = getCoords(Port);
%         if currentPos(1)/abs(currentPos(1)) ~= Sequence(1)/abs(Sequence(1))
%             LAB3(Port, Sequence(x:(x+2)), Sequence((x+3):(x+5)));
%             C = getCoords(Port);
%             LAB3(Port, C, Sequence((x+3):(x+5)));
%         else
        if currentPos(1)/abs(currentPos(1)) == Sequence(1)/abs(Sequence(1))
            LAB3(Port, currentPos, Sequence((x+3):(x+5)));
        else
        LAB3(Port, Sequence(x:(x+2)), Sequence((x+3):(x+5)));
        end
    else
        LAB3(Port, Sequence(x:(x+2)), Sequence((x+3):(x+5)));
    end
end

%EndEffector(Port, 1, sign); % Raise the end-effector 

end

