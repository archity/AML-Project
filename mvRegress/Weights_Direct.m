clc;
clear variables;

fileToRead = 'S&Pdata';

%Training would be done on 80% of data (1:550 out of 679)
rangeTaken = 1:550;

% Import the complete spreadsheet file
[xlsObjectComplete, xlsHeads] = xlsread(fileToRead);
% xlsHeads contains the headings in the form of a string vector

xlsComplete = xlsObjectComplete;

% Filter just the S&P Close into a vector
SP_Close_ToBePredicted = xlsObjectComplete(:, 22);

xlsHeads = xlsHeads(2:21);  % Remove the 'DATE' heading
xlsObjectComplete = xlsObjectComplete(:, 2:22); % Remove the date
input = xlsObjectComplete(:, 1:20);
output = xlsObjectComplete(:, 21);

coeff = mvregress(input, output);
% Returns the estimated coefficients for a multivariate normal regression 

prediction = input(1:679, 1:20).* coeff';
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

