function [ ard, statusbar ] = arduinoserialconnect( comPort ) %outpur and input
%   Detailed explanation goes here
%communication with arduino stuff standard procedure
ard = serial(comPort);
set (ard, 'DataBits', 8);
set (ard, 'StopBits', 1);
set (ard, 'BaudRate', 9600);
set (ard, 'Parity', 'none');
fopen (ard)

data(1)=(get(ard,'BaudRate'));
data(2)=(get(ard,'DataBits'));
data(3)=(get(ard, 'StopBit'));
data(4)=(get(ard, 'InputBufferSize'));

statusbar = msgbox (['Connected to Serial Port!' char (10) 'BaudRate= ' num2str(data(1)) char (10) 'DataBits=' num2str(data(2))  char (10) 'StopBits= ' num2str(data(3))], 'Status');
end

