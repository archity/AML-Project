clc
clear
close all

fileToRead = 'S&Pdata';

% Import the complete spreadsheet file
[xlsObjectComplete, xlsHeads] = xlsread(fileToRead);
% xlsHeads contains the headings in the form of a string vector

% Filter just the S&P Close into a vector
SP_Close = xlsObjectComplete(:, 22);

xlsHeads = xlsHeads(2:22);  % Remove the 'DATE' heading
xlsObjectComplete = xlsObjectComplete(:, 2:22); % Remove the date coloumn

%%
covMat = [0, 0; 0, 0];
for i = 1 :20
    for j = i+1 : 20
        % Compute the covariance of ith and jth column
        covV = cov( xlsObjectComplete(i), xlsObjectComplete(j) );
        if(i==1 && j==2)
            covMat = covV;
        else
            % Keep appending the 2x2 matrix 
            covMat = [covMat, covV];
        end
        
    end
end

%%
% Trying out hashmap
keySet = [1, 2, 3];
valueSet = { '[1, 2; 3, 4]', '5, 6; 7, 8', '[9, 10; 11, 12]' };
mapObj = containers.Map(keySet,valueSet);

str = mapObj(2);
sscanf(str,'%d, %d; %d, %d')    % Extract the 4 numbers from the string