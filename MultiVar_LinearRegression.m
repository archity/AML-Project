clc
clear
close all

fileToRead = 'S&Pdata'; 

rangeTaken = 1:100;

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
iterations = 1000;

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

% plot(1:iterations, jHistory);
% xlabel('Iterations'); ylabel('J');

jHistory = jHistory';


%--------------------------------------------------------------------------
% Plot the results
%--------------------------------------------------------------------------

figure;
i = 2;  % 2nd column (feature) of input matrix

% scatter(x, y)
scatter(inputMatrix(:, i), SP_Close);
xlabel( xlsHeads(i) ); ylabel('S&P Close');

hTheta = inputMatrix(:, i) * thetaWeights(i);

% Plot the linear fit
hold on; % keep previous plot visible
plot( inputMatrix(:, i), inputMatrix(:, i) * thetaWeights(i), '-' )
legend('Training data', 'Linear regression')
hold off % don't overlay any more plots on this figure