function showdata(data, labels, guess)
    % Visualize digit images with optional error highlighting
    % Input:
    %   data - digit image data
    %   labels - true labels
    %   guess - predicted labels (optional)
    
    % Sort digits
    [labels, sortorder] = sort(labels);
    data = data(sortorder,:);
    
    % Handle predictions
    testing = true;
    if ~exist('guess','var')
        guess = labels;
        testing = false;
    else
        guess = guess(sortorder);
    end
    
    % Check data format
    if size(data,2) ~= 256
        error('Can only display original pixel data.');
    end
    
    % Determine grid size
    numexamples = size(data,1);
    side = ceil(sqrt(numexamples));  % Dynamically adjust grid size
    
    % Display parameters
    border = 3;
    framewidth = 16 + (2*border);
    
    % Create display matrix
    m = zeros(side*framewidth, side*framewidth);
    
    % Populate display matrix
    n = 1;
    mistakes = 0;
    for row = 1:framewidth:(side*framewidth)-1
        for col = 1:framewidth:(side*framewidth)-1
            % Check if we still have examples to display
            if n > numexamples
                break;
            end
            
            % Extract and frame digit
            digit = reshape(data(n,:), 16, 16);
            frame = zeros(framewidth);
            frame(border:(border+15), border:(border+15)) = digit;
            
            % Highlight mistakes
            if labels(n) ~= guess(n)
                frame(border, border:(framewidth-border)) = 255;
                frame(framewidth-border, border:(framewidth-border)) = 255;
                frame(border:(framewidth-border), border) = 255;
                frame(border:(framewidth-border), framewidth-border) = 255;
                mistakes = mistakes + 1;
            end
            
            % Place in display matrix
            m(row:(row+(framewidth-1)), col:(col+(framewidth-1))) = frame;
            
            % Move to next digit
            n = n + 1;
        end
    end
    
    % Display image
    imagesc(m);
    colormap gray;
    axis off;
    axis square;
    
    % Add title with error rate
    if testing
        rate = ceil((mistakes / numexamples) * 10000) / 100;
        title([num2str(mistakes) ' errors from ' num2str(numexamples) ' (' num2str(rate) '%)'], 'FontSize', 16);
    end
end
