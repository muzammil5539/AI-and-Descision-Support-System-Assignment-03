%% Utility Function: Get Single Digit
function digdata = getonedigit(n, instance, data)
    % Extract a single digit from the dataset
    % Input:
    %   n - digit number (1-9, use 10 for digit 0)
    %   instance - specific instance of the digit
    %   data - 3D data matrix
    
    % Validate inputs
    if ~exist('data', 'var')
        error('Three arguments required.');
    end
    
    if n > size(data,3)
        error('Incorrect digit argument.');
    end
    
    if instance > size(data,2)
        error('Incorrect instance argument.');
    end
    
    % Reshape and convert to double
    digdata = reshape(data(:, instance, n), 16, 16);
    digdata = double(digdata);
end

