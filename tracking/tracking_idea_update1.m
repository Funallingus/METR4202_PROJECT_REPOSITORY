tracking = 0;
i = 1;
imagefiles = dir('Tracking sequence 3/*.jpg');      
nfiles = length(imagefiles);    % Number of files found

images = cell(1, nfiles);

currentfilename = fullfile('Tracking sequence 3', imagefiles(1).name);
currentimage = rgb2gray(imread(currentfilename));
images{1} = im2double(currentimage);
 
%nfiles = length(imagefiles);    % Number of files found
%images = cell(1, nfiles);

%HARDCODED TEMPLATES
%REPLACE WITH MOVING AVERAGE AND DETECTION CODE
template_rect = [881, 767, 97, 173; 881, 553, 117, 117; 991, 415, 105, 77; 1141, 234, 93, 101];

tic;
[rows, columns] = size(template_rect);

%% pull images in as you go\
while tracking == 0
    i = i+1;
    %import image
    currentfilename = fullfile('Tracking sequence 3', imagefiles(i).name);
    currentimage = rgb2gray(imread(currentfilename));
    images{i} = im2double(currentimage);
    %images{i} =  {images, currentimage}; %im2double(currentimage);
    %I = images{i-1};
    J = images{i};
    scene = J;
    I = images{i-1};

    %% Get and display 200 frames from vi devices
    fig = figure(30);
    fig.Position = [100, 100, 1000, 700];
    %figure('Position', [100, 100, 1000, 700]); %sets the figure window size for all im
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


    for j=1:rows
    %CALCULATE region of interest based on size/height in img1 (the higher the
    %smaller the area you need to search.)
    %Extra percentage
     Extra  =  1; %130
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
    
%     %Find centroid 
%      u = template_rect(j, 1) + template_rect(j, 3)/2;
%      v = template_rect(j, 2) + template_rect(j, 4)/2;

     %based on height(v) pick size decrease
     %%%%%%%%%%%%%


%     %add extra size to template
%     %%%%%%%%%
%     y = template_rect(j, 4)*Extra/2;
%     x = template_rect(j, 3)*Extra/2;
%     %template_rect_new;
%     %%%%%%%%%%%%%

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

    left_bottom  = [min(u), min(v)];
    % left_top = [min(u), max(v)]
    % right_bottom = [max(u), min(v)]
    % right_top = [max(u), max(v)]
    %globalCoord = [x+coord(1)-rangeX, y+coord(2)-rangeY]
   

    %error check something exist
        if left_bottom ~= NaN
            globalCoord = [left_bottom(1)+ template_rect(j, 1), left_bottom(2)+ template_rect(j, 2)]; 

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
        
    template_rect(j, 1) = globalCoord(1);
    template_rect(j, 2) = globalCoord(2);

    end
end
toc

%figure(); imshow(I);
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
