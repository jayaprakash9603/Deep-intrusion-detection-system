clc
clear all;

% [f p]=uigetfile('*.csv');
% [ndata, text, alldata] = xlsread([p f]);
[ndata, text, alldata] = xlsread('data_1.xls');

data=ndata(:,2);
data=(data(1:1000));
[r,c]=size(data);

% Compute the mean of the data matrix "The mean of each row" (Equation (10))
m=mean(data')';

% Subtract the mean from each  [Centering the data] (Equation (11))
d=data-repmat(m,1,c);
figure,
stem(d(1:100))
title('Centering the Data');
% Compute the covariance matrix (co) (
% co=1 / (c-1)*d*d';
co=((c)*d*d');

% Compute the eigen values and eigen vectors of the covariance matrix (Equation (2))
[eigvector,eigvl]=eig(co);

% Project the original data on only two eigenvectors
Data_2D=eigvector(:,1:50)'*d;

% Project the original data on only three eigenvectors
Data_3D=eigvector(:,1:3)'*d;

evc=eigvector(1:1000);
% Reconstruction of the original data 
% Two dimensional case
Res_2D= (eigvector(:,1:50))*Data_2D;
TotRes_2D=Res_2D+repmat(m,1,c);

% Two dimensional case
Res_3D= (eigvector(:,1:3))*Data_3D;
TotRes_3D=Res_3D+repmat(m,1,c);

% Calculate the error between the original data and the reconstructed data
% (Two dimensional case)
MSE=(1/(size(data,1)*size(data,2)))*...
sum(sum(abs(TotRes_2D-double(data))))
% (Three dimensional case)
MSE=(1/(size(data,1)*size(data,2)))*...
sum(sum(abs(TotRes_3D-double(data))))

% Calculate the Robustness of the PCA space (Equation (9))
% (Two Dimensional case)
SumEigvale=diag(eigvl);
Weight_2D=sum(SumEigvale(1:2))/sum(SumEigvale);
% (Three Dimensional case)
Weight_3D=sum(SumEigvale(1:3))/sum(SumEigvale);

% Visualize the data in two dimensional space
% The first class (Setosa) in red, the second class (Versicolour) in blue, and the third class (Virginica) in
% green
for i=1:150
    for j=1:3
    Data_2D_test(j,i)=Data_2D(randi(2),1);
    end
end
figure(1),
plot(Data_2D_test(1,1:50),Data_2D_test(2,1:50),'rd'...
    ,'MarkerFaceColor','r'); hold on
plot(Data_2D_test(1,51:100),Data_2D_test(2,51:100),'bd'...
    ,'MarkerFaceColor','b'); hold on
plot(Data_2D_test(1,101:150),Data_2D_test(2,101:150),'kd'...
    ,'MarkerFaceColor','g')
xlabel('First Principal Component (PC1)')
ylabel('Second Principal Component (PC2)')
legend('Status','Closed','Running')

% Visualize the data in three dimensional space
% The first class (Setosa) in red, the second class (Versicolour) in blue, and the third class (Virginica) in
% green
figure(2),
scatter3(Data_2D_test(1,1:50),Data_2D_test(2,1:50),...
    Data_2D_test(3,1:50),'rd','MarkerFaceColor','r'); 
hold on
scatter3(Data_2D_test(1,51:100),Data_2D_test(2,51:100),...
    Data_2D_test(3,51:100),'bd','MarkerFaceColor','b'); 
hold on
scatter3(Data_2D_test(1,101:150),Data_2D_test(2,101:150),...
    Data_2D_test(3,101:150),'gd','MarkerFaceColor','k')
xlabel('First Principal Component (PC1)')
ylabel('Second Principal Component (PC2)')
zlabel('Third Principal Component (PC3)')
legend('Status','Closed','Running')

[Newdata,PCASpace,EigValues]=PCASVD(Data_2D);

% % % % figure,
% % % % stem(PCASpace(1:1000))
% % % % title('PCA Space Values');

% % % % figure
% % % % comet(evc);
% % % % title('Visualizing EigenVectors');

RCNN_TrTs(data);

