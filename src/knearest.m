%% K-Nearest Neighbor Classification
% Efficient implementation of KNN classification using vectorized operations
% for distance calculations and mode finding.
%
% Performance optimizations:
% 1. Vectorized distance calculation
% 2. Efficient sorting using sortrows
% 3. Fast mode computation for label prediction
%
% Parameters:
%   k - number of neighbors (automatically adjusted if too large)
%   x - test sample (1xN feature vector)
%   data - training data (MxN feature matrix)
%   datalabels - training labels (Mx1)

function y = knearest(k, x, data, datalabels)
    % Input validation with detailed error messages
    validateattributes(k, {'numeric'}, {'positive', 'integer', 'scalar'});
    validateattributes(x, {'numeric'}, {'row'});
    validateattributes(data, {'numeric'}, {'2d'});
    validateattributes(datalabels, {'numeric'}, {'vector'});

    % Validate inputs
    [numtrain, numfeatures] = size(data);
    
    if isempty(data) || isempty(datalabels)
        error('Training data or labels are empty');
    end
    
    if size(x, 2) ~= numfeatures
        error(['Test data dimensions (' num2str(size(x,2)) ') do not match train data dimensions (' num2str(numfeatures) ').']);
    end
    
    if k > numtrain
        k = numtrain;
        disp(['Reducing k to number of training samples: ' num2str(k)]);
    end
    
    % Ensure datalabels is a column vector
    if size(datalabels, 2) > 1
        datalabels = datalabels'; % Transpose to column vector if needed
    end
    
    % Compute distances
    distances = sqrt(sum((data - x).^2, 2)); % Column vector of distances
    
    % Combine distances with labels
    distances_with_labels = [distances, datalabels]; % Ensure both are column vectors
    
    % Sort distances and extract top-k neighbors
    sorted = sortrows(distances_with_labels, 1); % Sort by distance
    
    % Ensure k is at least 1
    k = max(k, 1);
    top_k_labels = sorted(1:k, 2);              % Top-k labels
    
    % Predict label as the mode of the top-k labels
    y = mode(top_k_labels);
    
end
