function [ outputMatrix ] = maxNormalization( inputMatrix )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    for i = 1 : 17
        
        inputMatrix(:, i) = inputMatrix(:, i)/max( inputMatrix(:, i) );
        
    end
    
    outputMatrix = inputMatrix;

end
