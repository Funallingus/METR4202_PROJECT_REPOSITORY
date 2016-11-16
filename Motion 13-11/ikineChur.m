function A = ikineChur(x, y, z, d1, a1, a2, setting)
% takes in a set of coordinates, a set of arm parameter values, and a
% setting which determines which solution to return (based on the quadrants
% of the starting and ending points)

K = (x^2+y^2-a1^2-a2^2)/(2*a1*a2);

if setting <=0
    % solution 1
    theta2 = acos(K);
    C_theta1 = (x*(a1+a2*cos(theta2))+y*a2*sin(theta2))/(a1^2+a2^2+2*a1*a2*cos(theta2));
    S_theta1 = (-x*a2*sin(theta2)+y*(a1+a2*cos(theta2)))/(a1^2+a2^2+2*a1*a2*cos(theta2));

    theta1 = atan2(S_theta1, C_theta1)*180/pi;
    theta2 = theta2*180/pi;
    A = [theta1, theta2];
elseif setting > 0
    % solution 2
    theta2 = -acos(K);
    C_theta1 = (x*(a1+a2*cos(theta2))+y*a2*sin(theta2))/(a1^2+a2^2+2*a1*a2*cos(theta2));
    S_theta1 = (-x*a2*sin(theta2)+y*(a1+a2*cos(theta2)))/(a1^2+a2^2+2*a1*a2*cos(theta2));

    theta1 = atan2(S_theta1, C_theta1)*180/pi;
    theta2 = theta2*180/pi;
    A = [theta1, theta2];
end
% return a matrix A containing the arm's angle values for the given point
%A = [theta1, theta2];

%% old function
% l1 = a2;
% l2 = a3;
% 
% theta = atan2(y,x);
% l3 = (x^2+y^2)^.5;
% a3 = acos((l3^2 - (l2^2 + l1^2))/(-2*l1*l2));
% a1 = asin(l1*sin(a3)/l3);
% theta2 = (a3 - a1)*180/pi;
% theta1 = (180 - theta - a1)*180/pi;
% 
% A = [theta1, theta2];


% alpha = tan(114/135)*360/(2*pi);
% 
% 
% A(1) = (atan2(y,x)) * (180/pi()); %theta1 in degrees
% D = (x^2 + y^2 + (z - d1)^2 - a2^2 - a3^2) / (2*a2*a3)
% A(3) = atan2(D, sqrt(1-D^2));
% A(2) = (atan2((z - d1), sqrt(x^2+y^2)) - ...
%         atan2(a3*sin(A(3)), a2 + a3*cos(A(3)))) * (180/pi());
% A(3) = A(3) * (180/pi());
% A(3) = A(3)+ alpha;


end