%% Author - Anoushkrit Goel  [AML Project]
% Dated - 23 March 2018 (5:32 PM)

%% Normal Equation 
% For Checking the Invertibility of the matrices used 
% If the matrix is invertible then the matrix doesn't contain redundant
% features or doesn't contain too many features.

clc
close all 
clear all


% The data has been imported taking each and every variable into
% consideration 

% SP_HIGH= readtable('S&Pdata.xls', 'Range', 'B2:B681');
% SP_LOW = readtable('S&Pdata.xls', 'Range', 'C2:C681');
% NYSE_ADV_ISS = readtable('S&Pdata.xls', 'Range', 'D2:D681');
% NYSE_DECL_ISS = readtable('S&Pdata.xls', 'Range', 'E2:E681');
% OTC_ADV_ISS = readtable('S&Pdata.xls', 'Range', 'F2:F681');
% OTC_DECL_ISS = readtable('S&Pdata.xls', 'Range', 'G2:G681');
% NYSE_NEW_HIGHS = readtable('S&Pdata.xls', 'Range', 'H2:H681');
% NYSE_NEW_LOWS = readtable('S&Pdata.xls', 'Range', 'I2:I681');
% OTC_NEW_HIGHS = readtable('S&Pdata.xls', 'Range', 'J2:J681');
% OTC_NEW_LOWS = readtable('S&Pdata.xls', 'Range', 'K2:K681');
% NYSE_TOT_VOL = readtable('S&Pdata.xls', 'Range', 'L2:L681');
% NYSE_ADV_VOL = readtable('S&Pdata.xls', 'Range', 'M2:M681');
% NYSE_DECL_VOL = readtable('S&Pdata.xls', 'Range', 'N2:N681');
% OTC_TOT_VOL = readtable('S&Pdata.xls', 'Range', 'O2:O681');
% OTC_ADV_VOL = readtable('S&Pdata.xls', 'Range', 'P2:P681');
% OTC_DECL_VOL = readtable('S&Pdata.xls', 'Range', 'Q2:Q681');
% SP_EARNINGS= readtable('S&Pdata.xls', 'Range', 'R2:R681');
% MOBILLS = readtable('S&Pdata.xls', 'Range', 'S2:S681');
% LNG_BONDS= readtable('S&Pdata.xls', 'Range', 'T2:T681');
% GOLD= readtable('S&Pdata.xls', 'Range', 'U2:U681');
% SP_CLOSE= readtable('S&Pdata.xls', 'Range', 'V2:V681');


cM = xlsread('S&Pdata.xls');
SP_HIGH= cM(:,1);
SP_LOW = cM(:,2);
NYSE_ADV_ISS = cM(:,3);
NYSE_DECL_ISS = cM(:,4);
OTC_ADV_ISS = cM(:,5);
OTC_DECL_ISS = cM(:,6);
NYSE_NEW_HIGHS = cM(:,7);
NYSE_NEW_LOWS = cM(:,8);
OTC_NEW_HIGHS = cM(:,9);
OTC_NEW_LOWS =cM(:,10);
NYSE_TOT_VOL = cM(:,11);
NYSE_ADV_VOL =cM(:,12);
NYSE_DECL_VOL = cM(:,13);
OTC_TOT_VOL =cM(:,14);
OTC_ADV_VOL = cM(:,15);
OTC_DECL_VOL = cM(:,16);
SP_EARNINGS= cM(:,17);
MOBILLS = cM(:,18);
LNG_BONDS= cM(:,19);
GOLD= cM(:,20);
SP_CLOSE= cM(:,21);

% for i=1:20
%     scatter(cM(:,21),cM(:,i))
%     figure
% end

X= pca(cM);
plot(X);
figure
display(X);
xlswrite('PCA_1.xlsx',X);
xlswrite('CompleteMatrix.xlsx', cM);

Y = pca(X);
xlswrite('PCA_2.xlsx',Y);
plot(Y);
figure; %Figure 2 gives 20

Z = pca(Y);
xlswrite('PCA_3.xlsx',Z)
plot(Z);
figure; % Figure 3 gives me 20
    
Z1 = pca(Z);
xlswrite('PCA_4.xlsx',Z1)
plot(Z1);%Figure 4 gives me 19 again


Z2 = pca(Z1);
xlswrite('PCA_5.xlsx',Z2)
plot(Z2);
figure; %Figure 5 gives me 19 axes


Z3 = pca(Z2);
xlswrite('PCA_6.xlsx',Z3)
plot(Z3);
figure; %Figeure 6 provides me with 18 axes

Z4 = pca(Z3);
xlswrite('PCA_7.xlsx',Z2)
plot(Z4);
figure; % Figure 7 gives me 18 axes
    
    








