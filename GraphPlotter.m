clc
clear all
close all

fileToRead = 'S&Pdata';

% Import the complete spreadsheet file
[xlsObjectComplete, xlsHeads] = xlsread(fileToRead);
% xlsHeads contains the headings in the form of a string vector

% Filter just the S&P Close into a vector
SP_Close = xlsObjectComplete(:, 22);
for i = 2 : 21
    % WARNING: 19 graphs will popup at once
    figure;
    
    % Take one coloumn at a time
    array = xlsObjectComplete(:, i);
    
    % scatter(x, y)
    scatter(array, SP_Close);
    xlabel( xlsHeads(i) ); ylabel('S&P Close');
end

