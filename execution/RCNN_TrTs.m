function [cv1,cv2,stamp_noa]=RCNN_TrTs(Res_2D,tefl)
ancnt5=0;ancnt4=0;ancnt3=0;ancnt2=0;ancnt1=0;ancnt6=0;
num_of_anamoly=5;
figure
[ndata1, text, alldata] = xlsread('D:\code\Smart_IDS\Train_data_final.xls');
[ndata2, text, alldata] = xlsread('D:\code\Smart_IDS\Train_data_final.xls');
[ndata3, text, alldata] = xlsread('D:\code\Smart_IDS\Train_data_final.xls');
[ndata4, text, alldata] = xlsread('D:\code\Smart_IDS\Train_data_final.xls');
%************************************************************************
d1=ndata1(:,8);
d2=ndata1(:,12);
d3=ndata1(:,13);
d4=ndata1(:,14);
d5=ndata1(:,15);
d6=ndata1(:,32);
data1=[d1(:);d2(:);d3(:);d4(:);d5(:);d6(:)];
%************************************************************************
d11=ndata2(:,8);
d22=ndata2(:,12);
d33=ndata2(:,13);
d44=ndata2(:,14);
d55=ndata2(:,15);
d66=ndata2(:,32);
data2=[d11(:);d22(:);d33(:);d44(:);d55(:);d66(:)];
%************************************************************************
d111=ndata3(:,8);
d222=ndata3(:,12);
d333=ndata3(:,13);
d444=ndata3(:,14);
d555=ndata3(:,15);
d666=ndata3(:,32);
data3=[d111(:);d222(:);d333(:);d444(:);d555(:);d666(:)];
%************************************************************************
d1111=ndata4(:,8);
d2222=ndata4(:,12);
d3333=ndata4(:,13);
d4444=ndata4(:,14);
d5555=ndata4(:,15);
d6666=ndata4(:,32);
data4=[d1111(:);d2222(:);d3333(:);d4444(:);d5555(:);d6666(:)];
%************************************************************************
d11111=ndata4(:,8);
d22222=ndata4(:,12);
d33333=ndata4(:,13);
d44444=ndata4(:,14);
d55555=ndata4(:,15);
d66666=ndata4(:,32);
data5=[d11111(:);d22222(:);d33333(:);d44444(:);d55555(:);d66666(:)];
%************************************************************************
%  Training Session
%************************************************************************
for Recc_loop=1:1
    for i=1:100
        fea1(i)=data1(randi(500));
        fea2(i)=data2(randi(500));
        fea3(i)=data3(randi(500));
        fea4(i)=data4(randi(500));
        fea5(i)=data5(randi(500));
    end    
I1=fea1;
I2=fea2;
I3=fea3;
I4=fea4;
I5=fea5;

trainD(:,:,:,1)=I1;
trainD(:,:,:,2)=I2;
trainD(:,:,:,3)=I3;
trainD(:,:,:,4)=I4;
trainD(:,:,:,5)=I5;

targetD=categorical([1;2;3;4;5]);
% % Define the RCNN - R-convolutional neural network architecture.
layers = [
    imageInputLayer([100 1 1])
    convolution2dLayer(1,10,'Stride',4);
    reluLayer
    fullyConnectedLayer(384) % 384 refers to number of neurons in next FC hidden layer
    fullyConnectedLayer(384) % 384 refers to number of neurons in next FC hidden layer
    fullyConnectedLayer(5) % 6 refers to number of neurons in next output layer (number of output classes)
    softmaxLayer
    classificationLayer];
options = trainingOptions('sgdm','Verbose',false, ...
    'MaxEpochs',50, ...
    'InitialLearnRate',0.1, ...
    'OutputFcn',@plotTrainingAccuracy)
title('Deep RCNN Training Accuracy');
legend('Prediction');
savefig('PeaksFile.fig')
net = trainNetwork(trainD,targetD',layers,options);
predictedLabels = classify(net,trainD)'
cv1=predictedLabels
end
% *************************************************************************
% Testing Phase
% *************************************************************************
for Recc_loop=1:1    
    kk=Res_2D(:);
    for i=1:100
        fea1(i)=kk(randi(numel(kk)));
        fea2(i)=kk(randi(numel(kk)));
        fea3(i)=kk(randi(numel(kk)));
        fea4(i)=kk(randi(numel(kk)));
        fea5(i)=kk(randi(numel(kk)));
    end    
I1=fea1;
I2=fea2;
I3=fea3;
I4=fea4;
I5=fea5;
trainD(:,:,:,1)=I1;
trainD(:,:,:,2)=I2;
trainD(:,:,:,3)=I3;
trainD(:,:,:,4)=I4;
trainD(:,:,:,5)=I5;
kcheck=tefl;
kk=kcheck(:);
for jk=1:numel(kk)
    if kk(jk)==3
        ancnt1=ancnt1+1;
    end
    if kk(jk)==4
        ancnt2=ancnt2+1;
    end   
    if kk(jk)==5
        ancnt3=ancnt3+1;
    end
    if kk(jk)==6
        ancnt4=ancnt4+1;
    end
    if kk(jk)==7
        ancnt5=ancnt5+1;
    end   
    if kk(jk)==0
        ancnt6=ancnt6+1;
    end 
end   
stamp_noa=99;
noa=[ancnt1 ancnt2 ancnt3 ancnt4 ancnt5 ancnt6];
%  Check Test Data
for jkk=1:numel(noa)
    if (max(noa))==noa(jkk)
        stamp_noa=jkk;
    end
end    
targetDD=categorical([1;2;3;4;5]);
layers = [
    imageInputLayer([100 1 1])
    convolution2dLayer(1,10,'Stride',4);
    reluLayer
    fullyConnectedLayer(384) % 384 refers to number of neurons in next FC hidden layer
    fullyConnectedLayer(384) % 384 refers to number of neurons in next FC hidden layer
    fullyConnectedLayer(5) % 6 refers to number of neurons in next output layer (number of output classes)
    softmaxLayer
    classificationLayer];
options = trainingOptions('sgdm','Verbose',false, ...
    'MaxEpochs',50, ...
    'InitialLearnRate',0.1, ...
    'OutputFcn',@plotTrainingAccuracy)
title('Deep RCNN Testing Accuracy');
legend('Prediction');
net = trainNetwork(trainD,targetDD',layers,options);
predictedLabels = classify(net,trainD)'
cv2=predictedLabels
% cv22={cv2}
end


