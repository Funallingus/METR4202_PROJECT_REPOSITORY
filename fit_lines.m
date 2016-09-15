%% Adds bounding box to all of the objects (rectangles) found
%%by the edge detection toolbox
%%
BW = E;

[B,L,N,A] = bwboundaries(BW);
figure; imshow(BW); hold on;
for k=1:length(B),
    if(~sum(A(k,:)))
       boundary = B{k};
     plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);hold on;
    end
end
%%
%%Plot bouding boxes found via bwboudnaries
blobMeasurements = regionprops(logical(BW), 'BoundingBox');
numberOfBlobs = size(blobMeasurements, 1);


rects = [];
for k = 1 : numberOfBlobs % Loop through all blobs.
rects = blobMeasurements(k).BoundingBox; % Get list ofpixels in current blob.
x1 = rects(1);
y1 = rects(2);
x2 = x1 + rects(3);
y2 = y1 + rects(4);
x = [x1 x2 x2 x1 x1];
y = [y1 y1 y2 y2 y1];
plot(x, y, 'LineWidth', 2);
end