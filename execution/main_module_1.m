clc;
close all;
warning off;

[ndata, text, alldata] = xlsread('data_1.xls')
[rk ck]=size(ndata);
for loopIndex=1:rk
    bags_of_data(1,loopIndex)=(alldata(loopIndex,5));
end    




