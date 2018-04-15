%% Multivariate Linear Regression with Reduced Features  

%% Objective
%%
% In this MATLAB script, linear regression with multiple variabes has been
% code, built on the same script used earlier, but with 3 of the features
% reduced because correlation calculations. It gives a very slightly better
% accuracy (82.9282%) compared to the previous script.

clc
clear
close all

fileToRead = 'S&Pdata';

%Training would be done on 80% of data (1:550 out of 679)
rangeTaken = 1:550;

% Import the complete spreadsheet file
[xlsObjectComplete, xlsHeads] = xlsread(fileToRead);
% xlsHeads contains the headings in the form of a string vector

% Filter just the S&P Close into a vector
SP_Close = xlsObjectComplete(rangeTaken, 22);

xlsHeads = xlsHeads(2:21);  % Remove the 'DATE' heading
completeOP = xlsObjectComplete(:, 22);
xlsObjectComplete = xlsObjectComplete(:, 2:21); % Remove the date & OP coloumn

%--------------------------------------------------------------------------
%%
% * Feature reduction
xlsObjectComplete( :, [3, 4, 8] ) = [];   % Remove 3, 4, 8 col
%--------------------------------------------------------------------------

inputMatrix = xlsObjectComplete(rangeTaken, 1:17);
% Includes ONLY the inputs

thetaWeights = zeros(17+1, 1);

% Learning rate, or rate of descent
alpha = 0.01;
iterations = 19000; % Obtained after a few hit and trials.

%--------------------------------------------------------------------------
%%
% * Normalization
%-------------------------------------------------------------------------

X = inputMatrix;
X_norm = X;
% Includes ONLY the inputs

mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));

for feature_index = 1:size(X,2)
 
    % Find mean
    feature_mean = mean(X(:,feature_index));
    % (datatpoint - mean)
    X_norm(:,feature_index) = X(:,feature_index) - feature_mean;
 
    % Find StdDev
    feature_std = std(X_norm(:,feature_index));
    % (datatpoint - mean)/(stdDev)
    X_norm(:,feature_index) = X_norm(:,feature_index) / feature_std;    
 
    sigma(feature_index) = feature_std;
    mu(feature_index) = feature_mean;
end

% Repeat the above code for getting complete normalized input matrix, with
% ALL the examples.

X = xlsObjectComplete(:, 1:17);
X_norm_Complete = X;
% Does NOT include the output

mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));

for feature_index = 1:size(X,2)
 
    % Find mean
    feature_mean = mean(X(:,feature_index));
    % (datatpoint - mean)
    X_norm_Complete(:,feature_index) = X(:,feature_index) - feature_mean;
 
    % Find StdDev
    feature_std = std(X_norm_Complete(:,feature_index));
    % (datatpoint - mean)/(stdDev)
    X_norm_Complete(:,feature_index) = X_norm_Complete(:,feature_index) / feature_std;    
 
    sigma(feature_index) = feature_std;
    mu(feature_index) = feature_mean;
end

X_norm_Complete = [ones(679, 1), X_norm_Complete];
% X_norm_Complete stores ALL the input variables of ALL features in a
% normalized manner, and a one vector is appended in the beginning. This
% will be exported to Excel/CSV later.


%--------------------------------------------------------------------------
%%
% * Gradient descent algo
%--------------------------------------------------------------------------

m = length(SP_Close);

X_norm = [ones(m, 1) X_norm];   % The normalized X
X = [ones(m, 1) inputMatrix];

y = SP_Close;

for i = 1 : iterations
    temp = thetaWeights - (alpha/m) * X_norm' * (X_norm * thetaWeights - y);
    thetaWeights = temp;
    
    jHistory(i) = (1 / (2*m) ) * sum(((X_norm * thetaWeights)-y).^2);
end

%--------------------------------------------------------------------------
%%
% * Cost function algo
%--------------------------------------------------------------------------

J = 0;
fprintf('Cost function:\n');
J = (1 / (2*m) ) * sum(((X_norm * thetaWeights)-y).^2)


%--------------------------------------------------------------------------
%%
% * Output variable (predicted)
%--------------------------------------------------------------------------
% Take the 20% (551:679) of all the output variables for testing
SP_Close_ToBePredicted = completeOP(551:679, 1);

% Preallocate yHat with zeros
yHat = zeros(129, 1);
for i = 1 : 18
    someTempVar = (thetaWeights(i) * X_norm_Complete(551:679, i));
    yHat = yHat + someTempVar;
end

difference = SP_Close_ToBePredicted - yHat;
accuracy = (difference./SP_Close_ToBePredicted)*100;
mean = mean(accuracy);

actualAccuracy = 100-mean


% Perform Outlier remover
outputX = outlierRemover(X_norm_Complete, xlsObjectComplete, 1, 1.75);
outputX = outlierRemover(X_norm_Complete, outputX, 2, 1.75);
outputX = outlierRemover(X_norm_Complete, outputX, 3, 1.45);
outputX = outlierRemover(X_norm_Complete, outputX, 4, 1.5);
outputX = outlierRemover(X_norm_Complete, outputX, 5, 1.9);
outputX = outlierRemover(X_norm_Complete, outputX, 6, 1.9);
outputX = outlierRemover(X_norm_Complete, outputX, 7, 1.4);
outputX = outlierRemover(X_norm_Complete, outputX, 8, 1.7);
outputX = outlierRemover(X_norm_Complete, outputX, 9, 1.8);
outputX = outlierRemover(X_norm_Complete, outputX, 10, 1.85);
outputX = outlierRemover(X_norm_Complete, outputX, 11, 1.7);
outputX = outlierRemover(X_norm_Complete, outputX, 12, 1.9);
outputX = outlierRemover(X_norm_Complete, outputX, 13, 1.95);
outputX = outlierRemover(X_norm_Complete, outputX, 14, 2);
outputX = outlierRemover(X_norm_Complete, outputX, 15, 2.2);
outputX = outlierRemover(X_norm_Complete, outputX, 16, 1.75);
outputX = outlierRemover(X_norm_Complete, outputX, 17, 2.5);

normalizedInputMatrix = maxNormalization(outputX);
% Export to CSV
% xlswrite('outlierOutput.xlsx', X_Outlier);