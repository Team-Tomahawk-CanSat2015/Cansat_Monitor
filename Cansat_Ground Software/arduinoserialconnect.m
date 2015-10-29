function [ waittime, ard, statusbar ] = arduinoserialconnect( comPort, freq ) %outpur and input
%   Detailed explanation goes here
%communication with arduino stuff standard procedure
delete (instrfind);
ard = serial(comPort);
set (ard, 'DataBits', 8);
set (ard, 'StopBits', 1);
set (ard, 'BaudRate', 9600);
set (ard, 'Parity', 'none');
set (ard, 'InputBufferSize', 1000000);
fopen (ard)

data(1)=(get(ard,'BaudRate'));
data(2)=(get(ard,'DataBits'));
data(3)=(get(ard, 'StopBit'));
data(4)=(get(ard, 'InputBufferSize'));


var = 1/freq;
a_time = 0;
k = log(18)* 1.05;
waittime = exp (k*var)/10;
loader = waitbar (0/waittime, 'Starting Handshake syncronization');
pause(1);  a_time = a_time+1;
while (a_time <= waittime)
 waitbar (a_time/waittime, loader, 'Syncronizing Handshake...'); 
 pause (1);
 a_time = a_time+1;
end
close (loader) ;

statusbar = msgbox (['Connected to Serial Port!' char (10) 'BaudRate= ' num2str(data(1)) char (10) 'DataBits=' num2str(data(2))  char (10) 'StopBits= ' num2str(data(3))], 'Status');
end

