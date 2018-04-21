clc
clear
close all

fileToRead = 'S&Pdata';

%Training would be done on 80% of data (1:550 out of 679)
rangeTaken = 1:550;

% Import the complete spreadsheet file
[xlsObjectComplete, xlsHeads] = xlsread(fileToRead);
% xlsHeads contains the headings in the form of a string vector

xlsComplete = xlsObjectComplete;

xlsHeads = xlsHeads(2:21);  % Remove the 'DATE' heading
xlsObjectComplete = xlsObjectComplete(:, 2:21); % Remove the date & OP coloumn


% Apply Z score

X = xlsObjectComplete;
X_norm = X;
mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));

for feature_index = 3:4
 
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
    
    figure;
    hist( X_norm(:, feature_index), 15 );
end

for feature_index = 6 : 14
 
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
    
    figure;
    hist( X_norm(:, feature_index), 15 );
end

indexToIterate = [3, 4, 6:14];  % indices to iterate over
minMaxMatrix = [-2.75, 2.6; -2.31, 3.57; -2, 3.4; -1.2, 3.75; -1.2, 3.06; -1.5, 3.3; -1.4, 3.4; -1.8, 2.38; -1.6, 3.8; -1.5, 2.77; -1.8, 2.95];
% This will form a matrix just like the one @Anoushkrit made it in the
% spreadsheet file which he gave to @Archit.

count = 0;
% To keep a count on how many values in the original file will be are
% modified.

for i = 1 : size(indexToIterate)    % 1:11
    for j = 1 : 679
        if( X_norm(j, indexToIterate(i)) < minMaxMatrix(i, 1) || X_norm(j, indexToIterate(i)) > minMaxMatrix(i, 2))
            % The above condition is TRUE, ONLY IF the dataPoint lies
            % outside the range written by @Anoushkrit. 'minMaxMatrix(i,1)'
            % corresponds to minimum value of ith coloumn and
            % 'minMaxMatrix(i,2) corresponds to the max value of the ith
            % coloumn.
            
            xlsObjectComplete( j, indexToIterate(i) ) = mean( xlsObjectComplete( :, indexToIterate(i) ) );
            % The above line replaces the ORIGINAL matrix's dataPoint by
            % replacing the particular value bu the coloumn's mean.
            count = count + 1;
        end
    end
end
