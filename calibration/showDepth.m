
function showDepth(depthIm)
depthOut = [[]];
for i = 1:size(depthIm, 1)
    for j = 1:size(depthIm, 2)
        depthOut(i,j) = round(uint8((depthIm(i,j)/1024) * 256));
    end
end

imtool(depthOut)
