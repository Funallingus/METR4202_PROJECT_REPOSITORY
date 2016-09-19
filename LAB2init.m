%% Initialize color video device
tic;
%Get videoinput (vi) object
colorVid = videoinput('kinect', 1, 'RGB_640x480');

%Set input settings
colorVid.FramesPerTrigger = 1;  %Only request one frame per trigger call
colorVid.TriggerRepeat = Inf;   %Tell vi object to allow inf trigger calls


%% Initialize color video device
depthVid = videoinput('kinect', 2, 'Depth_640x480');

%Set input settings
depthVid.FramesPerTrigger = 1;  %Only request one frame per trigger call
depthVid.TriggerRepeat = Inf;   %Tell vi object to allow inf trigger calls


%% Set trigger config for vi objects
triggerconfig([colorVid depthVid], 'manual');


%% Start vi devices
start([colorVid depthVid]);


