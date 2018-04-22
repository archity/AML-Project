clc;
clear variables;
close all;

fileToRead = 'S&Pdata_ReducedFeatures3.xlsx';

% Import the complete spreadsheet file
[xlsObjectComplete] = xlsread(fileToRead);
% xlsHeads contains the headings in the form of a string vector

%%
% Filter just the S&P Close into a vector
SP_Close_ToBePredicted = xlsObjectComplete(:, 14);

input = xlsObjectComplete(:, 1:13);
output = xlsObjectComplete(:, 14);

coeff = mvregress(input, output);
% Returns the estimated coefficients for a multivariate normal regression 

prediction = input(1:679, 1:13).* coeff';
for i = 1 : 679
    yCap(i) = sum(prediction(i, :)); 
end
yCap = yCap';

numerator = sum( (SP_Close_ToBePredicted - yCap).^2 );
denominator = sum( ( SP_Close_ToBePredicted - mean(SP_Close_ToBePredicted) ).^2 );
accu = 1 - (numerator/denominator)


mse = (1/679) * numerator

plot(1:679, SP_Close_ToBePredicted);
hold on
plot(1:679, yCap);
legend('Actual', 'Predicted');
xlabel('dataPoints'); ylabel('y');