function count = find_circles(domino)
    topCount = 0;
    bottomCount = 0;
    image = imcrop(domino, [0, 0, size(domino,2), size(domino, 1)/2]);
    image = boost_yellow(image);    
%     figure(); imshow(image); hold on;
    image = im2bw(image, sqrt(graythresh(image)));
    image = bwmorph(image, 'majority');
    image = 1 - image;
    blobMeasurements = regionprops(logical(image), 'BoundingBox', 'Area', 'MajorAxisLength', 'MinorAxisLength');
    numberOfBlobs = size(blobMeasurements, 1);

    for k = 1 : numberOfBlobs % Loop through all blobs.
        rects = blobMeasurements(k).BoundingBox; % Get list ofpixels in current blob.
        x1 = rects(1);
        y1 = rects(2);
        x2 = x1 + rects(3);
        y2 = y1 + rects(4);
        x = [x1, x2, x2, x1, x1];
        y = [y1, y1, y2, y2, y1];
%         plot(x, y, 'LineWidth', 2);
        axis_aspect_ratio = blobMeasurements(k).MinorAxisLength / blobMeasurements(k).MajorAxisLength;
        if blobMeasurements(k).Area < 0.02 * size(image, 1) * size(image, 2) && ...
                blobMeasurements(k).Area > 0.0012 * size(image, 1) * size(image, 2) &&...
                axis_aspect_ratio > 0.35

            topCount = topCount + 1;
        end
        
    end

    
  
    image = imcrop(domino, [0, size(domino, 1)/2, size(domino,2), size(domino, 1)/2]);
    image = boost_yellow(image);
%     figure(); imshow(image); hold on;
    image = im2bw(image, sqrt(graythresh(image)));
    %result = bwmorph(result, 'clean');
    image = bwmorph(image, 'majority');
    image = 1 - image;
    blobMeasurements = regionprops(logical(image), 'BoundingBox', 'Area', 'MajorAxisLength', 'MinorAxisLength');
    numberOfBlobs = size(blobMeasurements, 1);
    for k = 1 : numberOfBlobs % Loop through all blobs.
        rects = blobMeasurements(k).BoundingBox; % Get list ofpixels in current blob.
        x1 = rects(1);
        y1 = rects(2);
        x2 = x1 + rects(3);
        y2 = y1 + rects(4);
        x = [x1, x2, x2, x1, x1];
        y = [y1, y1, y2, y2, y1];
%         plot(x, y, 'LineWidth', 2);   
        axis_aspect_ratio = blobMeasurements(k).MinorAxisLength / blobMeasurements(k).MajorAxisLength;
        if blobMeasurements(k).Area < 0.02 * size(image, 1) * size(image, 2) && ...
                blobMeasurements(k).Area > 0.0012 * size(image, 1) * size(image, 2) &&...
                axis_aspect_ratio > 0.35
                

            bottomCount = bottomCount + 1;
        end
        
    end
    count = [topCount, bottomCount];
end