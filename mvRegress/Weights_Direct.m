clc;
clear variables;

fileToRead = 'S&Pdata';

%Training would be done on 80% of data (1:550 out of 679)
rangeTaken = 1:550;

% Import the complete spreadsheet file
[xlsObjectComplete, xlsHeads] = xlsread(fileToRead);
% xlsHeads contains the headings in the form of a string vector

xlsComplete = xlsObjectComplete;

xlsHeads = xlsHeads(2:21);  % Remove the 'DATE' heading
xlsObjectComplete = xlsObjectComplete(:, 2:22); % Remove the date
input = xlsObjectComplete(:, 1:20);
output = xlsObjectComplete(:, 21);

coeff = mvregress(input, output);
prediction = input(241, 1:20).*coeff';
%% 
prediction = sum(prediction);

svm_model = fitrsvm(input, output);
%% 

prediction_svm = predict(svm_model, input(300, 1:20));
prediction_svm