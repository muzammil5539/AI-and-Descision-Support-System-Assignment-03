%% Custom Feature Extraction for Handwritten Digits
% This function implements a block-based feature extraction method
% that reduces the 256-dimensional input (16x16 pixels) to 64 features
% by computing the mean intensity of 4x4 pixel blocks.
%
% The rationale behind this approach:
% 1. Dimensionality reduction (256 -> 64 dimensions)
% 2. Local intensity averaging reduces noise
% 3. Preserves spatial relationships in the digit image
% 4. Computationally efficient
%
% Input: digdata - Nx256 matrix where each row is a flattened 16x16 digit image
% Output: x - Nx64 matrix of features

%% Utility Function: Custom Feature Extraction
function x = extractmyfeatures(digdata)
    % Custom feature extraction from digit image
    % Input: Nx256 matrix of digit images or 16x16 single image
    % Output: NxM feature matrix where M is number of features
    
    % Validate input dimensions
    if size(digdata, 2) ~= 256
        error('Input data must have 256 dimensions (16x16 pixels)');
    end
    
    % Debug information
    disp(['Input data size: ', num2str(size(digdata))]);
    
    % Extract features (e.g., mean of 4x4 blocks)
    num_samples = size(digdata, 1);
    features = zeros(num_samples, 64); % 64 blocks of 4x4
    
    for i = 1:num_samples
        img = reshape(digdata(i,:), 16, 16);
        feat_idx = 1;
        for r = 1:4:16
            for c = 1:4:16
                block = img(r:r+3, c:c+3);
                features(i, feat_idx) = mean(block(:));
                feat_idx = feat_idx + 1;
            end
        end
    end
    
    % Debug information
    disp(['Output features size: ', num2str(size(features))]);
    
    x = features;
end