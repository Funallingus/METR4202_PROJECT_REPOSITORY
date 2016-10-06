I = rgb2gray(imread('Tracking sequence 3/sequence_2.jpg'));
J = rgb2gray(imread('Tracking sequence 3/sequence_3.jpg'));
images{1} = I;
scene = J;

%% Get and display 200 frames from vi devices
figure('Position', [100, 100, 1000, 700]); %sets the figure window size for all im
% Setup plot
set(gca,'units','pixels');
% Aquire size of video image format
sz = size(scene);

% Construct image display object
cim = image(...
    [1 sz(2)],...
    [1 sz(1)],...
    zeros(sz(1), sz(2), 1),...
    'CDataMapping', 'scaled'...
);

% Ensure axis is set to improve display
colormap gray;
axis image;

set(cim, 'cdata', scene);

%HARDCODED TEMPLATES
%REPLACE WITH MOVING AVERAGE AND DETECTION CODE
template_rect = [881, 767, 97, 173; 881, 553, 117, 117; 991, 415, 105, 77; 1141, 234, 93, 101];

tic;
[rows, columns] = size(template_rect);

%%

for j=1:rows
%CALCULATE region of interest based on size/height in img1 (the higher the
%smaller the area you need to search.)

%Find centroid 
 u = template_rect(j, 1) + template_rect(j, 3)/2;
 v = template_rect(j, 2) + template_rect(j, 4)/2;
 
 %based on height(v) pick size decrease
 %%%%%%%%%%%%%
 
 %Extra percentage
 Extra  =  1; %130
 
%add extra size to template
%%%%%%%%%
y = template_rect(j, 4)*Extra/2;
x = template_rect(j, 3)*Extra/2;
%template_rect_new;
%%%%%%%%%%%%%

%cut template out of img1 given box from detection
template{j} = I(...
    template_rect(j, 2):(template_rect(j, 2) + template_rect(j, 4)*Extra), ...
    template_rect(j, 1):(template_rect(j, 1) + template_rect(j, 3)*Extra) ...
    );

%cut out area of interest from img2 
area_of_int{j} = J(...
    template_rect(j, 2):(template_rect(j, 2) + template_rect(j, 4)*Extra ), ...
    template_rect(j, 1):(template_rect(j, 1) + template_rect(j, 3)*Extra ) ...
    );

%diff and filter
K = imabsdiff(template{j},area_of_int{j});
L = imabsdiff(K,area_of_int{j});
M = imsubtract(template{j},L);
%N = imsubtract(M, area_of_int{j});
BW = im2bw(M,graythresh(M));
%invert
%WB = imcomplement(BW);
Filtered = medfilt2(BW);

[u, v] = find(Filtered);

left_bottom  = [min(u), min(v)]
% left_top = [min(u), max(v)]
% right_bottom = [max(u), min(v)]
% right_top = [max(u), max(v)]
%globalCoord = [x+coord(1)-rangeX, y+coord(2)-rangeY]

%error check something exist
    if left_bottom ~= NaN
        globalCoord = [left_bottom(1)+ template_rect(j, 1), left_bottom(2)+ template_rect(j, 2)] 
        
        %DRAW BOX
        hold on;
        place = scatter(globalCoord(1), globalCoord(2));
        hold off;
        drawnow;
    else
%         hold on;
%         place = scatter(template_rect(j, 1), template_rect(j, 2));
%         hold off;
%         drawnow;
    end

end
toc

figure(); imshow(I);
% for j=1:rows
% K = imabsdiff(template{j},area_of_int{j});
% L = imabsdiff(K,area_of_int{j});
% M = imsubtract(template{j},L);
% %N = imsubtract(M, area_of_int{j});
% BW = im2bw(M,graythresh(M));
% %invert
% %WB = imcomplement(BW);
% Filtered = medfilt2(BW);
% figure(j+1); imshow(Filtered);  
% end

%rgb2gray(K);

%figure(); imshow(K);
%figure(); imshow(L);
%figure(); imshow(M);
%figure(); imshow(N);
%figure(); imshow(WB);
%figure(); imshow(Filtered);
