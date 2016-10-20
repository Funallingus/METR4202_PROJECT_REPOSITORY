function LAB3_INIT(Port)
%% Lab 3 init
loadlibrary('dynamixel', 'dynamixel.h')

%% Display Functions
libfunctions('dynamixel')
DEFAULT_BAUDNUM = 1; %
DEFAULT_PORTNUM = Port; % port on computer
%calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM)
calllib('dynamixel', 'dxl_initialize', DEFAULT_PORTNUM, DEFAULT_BAUDNUM);


%% Example code to move the motor
%% 30 = move to end position
%% calllib('dynamixel', 'dxl_write_word', motorID, Function, Magnitude of movement)
%calllib('dynamixel', 'dxl_write_word', 3, 30, 900)
end