%Dominos and coresponding position
%start at (275, 12.5, 0)mm
%2nd row starts (225, 12.5, 0)mm
%every 25mm going up  y axis (SPACING)

%14 dominos per row

Positions = [];

for i = 0:13
    Positions = [Positions; [530, 12.5+25*i]];
end

for i = 0:13
    Positions = [Positions; [490, 12.5+25*i]];
end

% Positions = [Positions(14: -1: 1, :); Positions(28:-1:15, :)];



