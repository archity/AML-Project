clc
clear
close all

fileToRead = 'S&Pdata'; 

% Import the complete spreadsheet file
[xlsObjectComplete, xlsHeads] = xlsread(fileToRead);
% xlsHeads contains the headings in the form of a string vector

% Filter just the S&P Close into a vector
SP_Close = xlsObjectComplete(:, 22);

inputMatrix = xlsObjectComplete(:, 2:21);

thetaWeights = zeros(21, 1);

% Learning rate, or rate of descent
alpha = 0.00000000000001;
iterations = 10000;

%--------------------------------------------------------------------------
% Gradient descent algo
%--------------------------------------------------------------------------

m = length(SP_Close);
X = [ones(m, 1) inputMatrix];
y = SP_Close;

for i = 1 : iterations
    temp = thetaWeights - (alpha/m) * X' * (X * thetaWeights - y);
    thetaWeights = temp;
    
    
    jHistory(i) = (1 / (2*m) ) * sum(((X * thetaWeights)-y).^2);
end

%--------------------------------------------------------------------------
% Cost function algo
%--------------------------------------------------------------------------
J = 0;
J = (1 / (2*m) ) * sum(((X * thetaWeights)-y).^2);

plot(1:iterations, jHistory);
xlabel('Iterations'); ylabel('J');

jHistory = jHistory';