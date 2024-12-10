%% Utility Function: Feature Extraction
function x = extractfeatures(digdata)
    % Extract features from digit image
    % Input: 16x16 digit image
    % Output: 1D feature vector (sum of pixel values in each column)
    
    % Sum pixel values along columns
    x = sum(digdata, 1);
end

