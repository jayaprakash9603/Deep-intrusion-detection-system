clc;
close all;

%  TCP/IP test
t = tcpclient("192.168.0.192",137)
data = uint8('a');
write(t, data)
t.BytesAvailable

% % dataout=read(t)
t
clear t