%Dominos and coresponding position
%start at (275, 12.5, 0)mm
%2nd row starts (225, 12.5, 0)mm
%every 25mm going up  y axis (SPACING)

%14 dominos per row

Positions = [];

columnSpace = 25; 
rowSpace = 50;

for j = 0:3

for i = 1:6
    Positions = [Positions; [(515 - columnSpace*j), (20 + rowSpace*i), 0]];
end
end


% Positions
% length(Positions)



