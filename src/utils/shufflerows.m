%% Utility Function: Shuffle Rows
function [shuffleddata, shuffleddatalabels] = shufflerows(data, datalabels)
    % Randomly shuffle rows of data and corresponding labels
    % Input:
    %   data - input data matrix
    %   datalabels - corresponding labels
    
    % Generate random permutation
    permutation = randperm(size(data,1));
    
    % Shuffle data and labels
    shuffleddata = data(permutation, :);
    shuffleddatalabels = datalabels(permutation, :);
end

