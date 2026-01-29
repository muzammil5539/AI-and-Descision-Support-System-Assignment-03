%% Utility Function: Show Single Digit
function showdigit(digdata)
    % Display a single digit image
    % Input: Digit image data (16x16 or 1x256)
    
    figure
    imagesc(reshape(digdata, 16, 16));
    set(gcf, 'Position', [500 500 256 256]);
    colormap gray;
    axis off;
    axis square;
end

