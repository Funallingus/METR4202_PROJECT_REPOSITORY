%Input depth image and colour image  as well as calibration data
%IMPORTANT:use aligned flipped image for all processing and for finding any
%points for the pixel_real() function

%http://au.mathworks.com/help/vision/ref/aligncolortodepth.html
%http://au.mathworks.com/help/supportpkg/kinectforwindowsruntime/examples/preview-color-and-depth-streams-simultaneously-from-the-kinect-v2.html?searchHighlight=depth%20image%20kinect%20matlab
%depthVid = videoinput('kinect',2)
function depthImage(depthImage, colorImage, depthDevice, u, v, focal_length)
[alignedFlippedImage,flippedDepthImage] = alignColorToDepth(depthImage,colorImage,depthDevice);

%depthDevice — Video input object
%videoinput object | imaq.VideoDevice object
%Video input object, specified as either a videoinput object or an imaq.VideoDevice object configured for Kinect for Windows.


%find the point of interest u, v

pixel_real(u, v, flippedDepthImage, focal_length); %RUN FUNCTION

% re

