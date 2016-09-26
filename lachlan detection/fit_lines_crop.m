%% Adds bounding box to all of the objects (rectangles) found
%%by the edge detection toolbox
%%
[B,L,N,A] = bwboundaries(BW);
figure; imshow(J); hold on;
for k=1:length(B),
    if(~sum(A(k,:)))
       boundary = B{k};
     plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);hold on;
    end
end
%%
%%Plot bouding boxes found via bwboudnaries
blobMeasurements = regionprops(logical(BW), 'BoundingBox', 'MajorAxisLength', 'MinorAxisLength', 'Area', 'Extrema');
numberOfBlobs = size(blobMeasurements, 1);


rects = [];
for k = 1 : numberOfBlobs % Loop through all blobs.
rects = blobMeasurements(k).BoundingBox; % Get list ofpixels in current blob.
x1 = rects(1);
y1 = rects(2);
x2 = x1 + rects(3);
y2 = y1 + rects(4);
width = blobMeasurements(k).Extrema(4) - blobMeasurements(k).Extrema(6);
height = blobMeasurements(k).Extrema(2) - blobMeasurements(k).Extrema(8);
extrema_aspect_ratio = width/height;
axis_aspect_ratio = blobMeasurements(k).MinorAxisLength / blobMeasurements(k).MajorAxisLength;
if  (axis_aspect_ratio > 0.3) && (axis_aspect_ratio < 0.7) && ...
            (blobMeasurements(k).Area > 10 && blobMeasurements(k).Area < 10^5)
    x = [x1 x2 x2 x1 x1];
    y = [y1 y1 y2 y2 y1];
    plot(x, y, 'LineWidth', 2);
end

end