function [ modifiedMatrix ] = outlierRemover( X_Outlier, X, index, value )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
   % X(:, 1) = [];
   X_Outlier(:, 1) = [];
   
    for i = 1 : 679
        if X_Outlier(i, index) >= value
            X(i, index) = mean( X(:, index) );
        end
    end
    
    modifiedMatrix = X;

end

