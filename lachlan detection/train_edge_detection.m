directory = pwd;
%% set opts for training (see edgesTrain.m)
opts=edgesTrain();                % default options (good settings)
opts.modelDir='models/';          % model will be in models/forest
opts.modelFnm='modelBsds';        % model name
opts.nPos=5e5; opts.nNeg=5e5;     % decrease to speedup training
opts.useParfor=1;                 % parallelize if sufficient memory

model=edgesTrain(opts);

model.opts.multiscale=1;          % for top accuracy set multiscale=1
model.opts.sharpen=2;             % for top speed set sharpen=0
model.opts.nTreesEval=1;          % for top speed set nTreesEval=1
model.opts.nThreads=4;            % max number threads for evaluation
model.opts.nms=0;                 % set to true to enable nms

cd (directory);