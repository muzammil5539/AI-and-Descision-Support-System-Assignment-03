%% Utility Function: Cross-Fold Validation
function [traindata, trainlabels, testdata, testlabels] = crossfold(fold, numfolds, data, datalabels)
    % Partition data into training and testing sets
    % Input:
    %   fold - current fold number
    %   numfolds - total number of folds
    %   data - input data matrix
    %   datalabels - corresponding labels
    
    % Number of features (columns)
    numfeatures = size(data,2);
    
    % Join data and labels
    data = [data datalabels];
    
    % Calculate fold size
    foldsize = round(size(data,1) / numfolds);
    
    % Calculate start and end indices for the current fold
    startindex = (fold-1)*foldsize + 1;
    endindex = (fold-1)*foldsize + foldsize;
    
    % Handle boundary condition for last fold
    if fold == numfolds
        endindex = size(data,1);
    end
    
    % Separate training and testing indices
    trainindices = startindex:endindex;
    testindices = [ (1:startindex-1), (endindex+1):size(data,1) ];
    
    % Split data
    traindata = data(trainindices,:);
    testdata = data(testindices,:);
    
    % Separate labels
    trainlabels = traindata(:,numfeatures+1);
    traindata(:,numfeatures+1) = [];
    
    testlabels = testdata(:,numfeatures+1);
    testdata(:,numfeatures+1) = [];
end

