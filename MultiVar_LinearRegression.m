clc
clear
close all

fileToRead = 'S&Pdata'; 

%Training would be done on 80% of data (1:550 out of 679)
rangeTaken = 1:550;

% Import the complete spreadsheet file
[xlsObjectComplete, xlsHeads] = xlsread(fileToRead);
% xlsHeads contains the headings in the form of a string

xlsHeads = xlsHeads(2:22);  % Remove the 'DATE' heading

% Filter just the S&P Close into a vector (Take the last col only)
SP_Close = xlsObjectComplete(rangeTaken, 22);

inputMatrix = xlsObjectComplete(rangeTaken, 2:21);  

thetaWeights = zeros(21, 1);

% Learning rate, or rate of descent
alpha = 0.01;
iterations = 19000; % Obtained after a few hit and trials.

%--------------------------------------------------------------------------
% Normalization
%--------------------------------------------------------------------------

X = inputMatrix;
X_norm = X;
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

% Repeat the above code for getting complete normalized input matrix

X = xlsObjectComplete(:, 2:21);
X_norm_Complete = X;
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
% Gradient descent algo
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
% Cost function algo
%--------------------------------------------------------------------------

J = 0;
J = (1 / (2*m) ) * sum(((X_norm * thetaWeights)-y).^2);

%--------------------------------------------------------------------------
% Output variable (predicted)
%--------------------------------------------------------------------------
% Take the 20% (551:679) of all the output variables for testing
SP_Close_ToBePredicted = xlsObjectComplete(551:679, 22);

% Preallocate yHat with zeros
yHat = zeros(129, 1);
for i = 1 : 21
    someTempVar = (thetaWeights(i) * X_norm_Complete(551:679, i));
    yHat = yHat + someTempVar;
end

difference = SP_Close_ToBePredicted - yHat;
accuracy = (difference./SP_Close_ToBePredicted)*100;
mean = mean(accuracy);

actualAccuracy = 100-mean

% Export the normalized input matrix file to Excel/CSV
% xlswrite('matToExcel.xlsx', X_norm_Complete);

%--------------------------------------------------------------------------
% Plot the results
%--------------------------------------------------------------------------

% Plotting the cost function
plot(1:iterations, jHistory);
xlabel('Iterations'); ylabel('J (Cost Function)');
jHistory = jHistory';

% figure;
% i = 2;  % 2nd column (feature) of input matrix
% 
% % scatter(x, y)
% scatter(inputMatrix(:, i), SP_Close);
% xlabel( xlsHeads(i) ); ylabel('S&P Close');
% 
% hTheta = inputMatrix(:, i) * thetaWeights(i);
% 
% % Plot the linear fit
% hold on; % keep previous plot visible
% plot( inputMatrix(:, i), inputMatrix(:, i) * thetaWeights(i), '-' )
% legend('Training data', 'Linear regression')
% hold off % don't overlay any more plots on this figure