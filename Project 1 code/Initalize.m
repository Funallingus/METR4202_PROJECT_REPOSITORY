function Initalize
COM_CloseNXT('all')
close all
clear all

clc
warning('off', 'all')
hNXT = COM_OpenNXT();
COM_SetDefaultNXT(hNXT);
end
