function frame = crop_frame(frame, cnrPoints, allPoints, T)


J = imtransform(frame, T);
J2 = J(:,end:-1:1,:);
% figure; imshow(J2);
width = size(J2, 2)/2;
height = size(J2, 1)/2;



xmin = [allPoints{1}; allPoints{3}];
ymin = [allPoints{1}; allPoints{2}];

xmax = width + [allPoints{2}; allPoints{4}];
ymax = height + [allPoints{3}; allPoints{4}];

cropX = min(xmin(:, 1));
cropY = min(ymin(:, 2));
cropWidth = max(xmax(:, 1)) - min(xmin(:, 1));
cropHeight = max(ymax(:, 2)) - min(ymin(:, 2));
frame = imcrop(J2, [cropX, cropY, cropWidth, cropHeight]);


figure(4); imshow(frame); hold on;
plot(cnrPoints(:, 1), cnrPoints(:, 2), 'rx', 'MarkerSize', 15, 'LineWIdth', 5);
hold off;




end
