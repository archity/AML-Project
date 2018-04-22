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
%--------------------------------------------------------------------------
%-------------------APPLYING Z NORMALIZATION TO ORIGINAL MATRIX------------
%--------------------------------------------------------------------------

indexToIterate = [3, 4, 6:14];  % indices to iterate over
minMaxMatrix = [-2.75, 2.6; -2.125, 3.50; -2, 3.4; -1, 3.75; -0.63, 3.38; -1.4, 3.28; -0.9, 2.9; -1.75, 1.99; -1.4, 2.95; -1.3, 2.85; -1.56, 2.89];
% This will form a matrix just like the one @Anoushkrit made it in the
% spreadsheet file which he gave to @Archit.

count = 0;
% To keep a count on how many values in the original file will be are
% modified.

for i = 1 : size(indexToIterate)    % 1:11
    for j = 1 : 679
        if( X_norm( j, indexToIterate(i) ) < minMaxMatrix(i, 1) || X_norm( j, indexToIterate(i) ) > minMaxMatrix(i, 2))
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
%--------------------------------------------------------------------------

% Now xlsObjectComplete will be completely modified using the formulaue of
% {xi-min(xi)} / {max(xi)-min(xi)}

for i = 1 : size( xlsObjectComplete, 2 )
    
    minValue = min(xlsObjectComplete(:, i));
    % Get the min value of ith coloumn
    
    maxValue = max(xlsObjectComplete(:, i));
    % Get the min value of ith coloumn
    
    for j = 1 : 679
        xlsObjectComplete(j, i) = ( xlsObjectComplete(j, i) - minValue ) / ( maxValue - minValue );
    end
end

xlswrite('zFactorToSome_Plus_NormalizationToAll.xls', xlsObjectComplete);