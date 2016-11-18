%Dominos and coresponding position
%start at (275, 12.5, 0)mm
%2nd row starts (225, 12.5, 0)mm
%every 25mm going up  y axis (SPACING)

%14 dominos per row

Positions = [];

for i = 0:13
    Positions = [Positions; [275, 12.5+25*i, 0]];
end

for i = 0:13
    Positions = [Positions; [225, 12.5+25*i, 0]];
end





