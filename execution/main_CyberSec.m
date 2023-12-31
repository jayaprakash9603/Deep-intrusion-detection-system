clc;
close all;
clear all;
warning off;

stamp1=0;
stamp2=0;
stamp3=0;
stamp4=0;
stamp5=0;

stamp1a=0;
stamp2a=0;
stamp3a=0;
stamp4a=0;
stamp5a=0;

tic;
tstart = tic;
[f p]=uigetfile('*.xlsx');
[ndata, text, alldata] = xlsread([p f]);

d1=ndata(:,5);
d2=ndata(:,6);
d3=ndata(:,7);
d4=ndata(:,8);
d5=ndata(:,9);
d6=ndata(:,10);
d7=ndata(:,8);
d8=ndata(:,12);
d9=ndata(:,13);
d10=ndata(:,14);
d11=ndata(:,15);
d12=ndata(:,32);
d13=ndata(:,17);
test_data_in=[d7(:);d8(:);d9(:);d10(:);d11(:);d12(:)];
test_data_in_fl=d7(:);
fld_test=text(:,3);
% *************************************************************************
% Feature Extract
% *************************************************************************
[Newdata,PCASpace,EigValues]=PCASVD(d1(1:10));

figure,
subplot(3,3,1)
stem(PCASpace(1:10))
title('PCA Space Values');


[Newdata,PCASpace,EigValues]=PCASVD(d2(1:10));
subplot(3,3,2)
stem(PCASpace(1:100))
title('PCA Space Values');

[Newdata,PCASpace,EigValues]=PCASVD(d3(1:10));
subplot(3,3,3)
stem(PCASpace(1:10))
title('PCA Space Values');

[Newdata,PCASpace,EigValues]=PCASVD(d4(1:10));
subplot(3,3,4)
stem(PCASpace(1:10))
vcons1=sum(sum(PCASpace));
title('PCA Space Values');

[Newdata,PCASpace,EigValues]=PCASVD(d5(1:10));
subplot(3,3,5)
stem(PCASpace(1:10))
vcons2=sum(sum(PCASpace));
title('PCA Space Values');

[Newdata,PCASpace,EigValues]=PCASVD(d6(1:10));
subplot(3,3,6)
stem(PCASpace(1:10))
vcons3=sum(sum(PCASpace));
title('PCA Space Values');

[Newdata,PCASpace,EigValues]=PCASVD(d7(1:10));
subplot(3,3,7)
stem(PCASpace(1:10))
vcons4=sum(sum(PCASpace));
title('PCA Space Values');

% *************************************************************************
% DECISION MAKING MODEL
% *************************************************************************
% Deep CNN model called here
% *************************************************************************
[cv1,cv2,stamp_noa]=RCNN_TrTs(test_data_in,test_data_in_fl);

for kki=1:5
if uint8(cv1(kki))==1
    stamp1=stamp1+1;
end

if uint8(cv1(kki))==2
    stamp2=stamp2+1;
end
pause(1);
if uint8(cv1(kki))==3
    stamp3=stamp3+1;
end

if uint8(cv1(kki))==4
    stamp4=stamp4+1;
end

if uint8(cv1(kki))==5
    stamp5=stamp5+1;
end
end

for kki=1:5
if (uint8(cv2(kki))==1)
    stamp1a=stamp1a+1;
end

if (uint8(cv2(kki))==2)
    stamp2a=stamp2a+1;
end

if (uint8(cv2(kki))==3)
    stamp3a=stamp3a+1;
end

if (uint8(cv2(kki))==4)
    stamp4a=stamp4a+1;
end

if (uint8(cv2(kki))==5)
    stamp5a=stamp5a+1;
end
end

test_pattern=[stamp1a,stamp2a,stamp3a,stamp4a,stamp5a];
hold_indexx=77;
sa(stamp_noa);
for kjj=1:5
    if (max(test_pattern)==test_pattern(kjj))
        hold_indexx=kjj;
    end
end 
% % % % % 
check_data=test_data_in(numel(test_data_in));
for i=1:600
    check_data(i)=test_data_in(randi(numel(test_data_in)))
end    
%  REGRESSION ANALYSIS
[pred]=Regression_GrB(check_data);
figure,
plot(pred,'*-r')
hold on;title('Correlation of Actual vs Predicted values');

plot(check_data,'*-k')
toc;
telapsed = toc(tstart)

