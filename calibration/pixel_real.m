
function [X, Y, Z] = pixel_real(u, v, img_depth, f)
%This function will take 1 (u, v) pixel input This should be the 
%center of dommino or any consistant referance point 
%must be maintained for project)

%%%%% img_rgb, img_depth are the relevant rgb and depth image

%f - This is a output from the intrinsic parameters of 
%the 

%Transformation extrincit matrix will be necessary to transform the 
%output of this function into the desired coordinate system.


%find Z (depth distance) for pixel u, v
Z = img_depth(u, v)

%find X and Y using simplified projection model
X = u*(Z/f)
Y = v*(Z/f)
end

