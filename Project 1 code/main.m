Initalize

d1 = 169;
a2 = 170;
a3 = 170;

DHParam = [d1, a2, a3];

points_lu=[[1,1,2];[8,3,3];[10,1,4];[6,6,5];[9,4,5];[10,6,5]];
points_lu = sortrows(points_lu);

startPosition = [0, -170, 1];


%cord x from tower is y in our plane
%cord y from touwer is x in our plane
cords1 = transform_cords(points_lu(1, 2), points_lu(1, 1), points_lu(1, 3))
cords2 = transform_cords(points_lu(2, 2), points_lu(2, 1), points_lu(2, 3))
cords3 = transform_cords(points_lu(3, 2), points_lu(3, 1), points_lu(3, 3))
cords4 = transform_cords(points_lu(4, 2), points_lu(4, 1), points_lu(4, 3))
cords5 = transform_cords(points_lu(5, 2), points_lu(5, 1), points_lu(5, 3))
cords6 = transform_cords(points_lu(6, 2), points_lu(6, 1), points_lu(6, 3))
round = 0;

move_to_point(startPosition, cords1, DHParam, 1);

while round < 2;

move_to_point(cords1, cords2, DHParam, 2);

move_to_point(cords2, cords3, DHParam, 3);

move_to_point(cords3, cords4, DHParam, 4);

move_to_point(cords4, cords5, DHParam, 5);

move_to_point(cords5, cords6, DHParam, 6);

move_to_point(cords6, cords5, DHParam, 7);

move_to_point(cords5, cords4, DHParam, 7);

move_to_point(cords4, cords3, DHParam, 7);

move_to_point(cords3, cords2, DHParam, 7);

move_to_point(cords2, cords1, DHParam, 7);
round = round + 1;
end

move_to_point(cords1, startPosition, DHParam, 1);
End