%% Handwritten Digit Recognition using KNN Classification
% EC-350 Artificial Intelligence and Decision Support Systems
% 
% This script implements comprehensive testing of the KNN classifier including:
% 1. Feature extraction comparison
% 2. Cross-validation analysis
% 3. Extended digit set classification
% 4. Performance visualization
%
% Author: [Your Name]
% Date: [Current Date]
% Version: 1.0

% Initialize workspace
clear all; close all; clc;
set(0,'DefaultFigureWindowStyle','docked'); % Dock all figures for better organization

% Load the main dataset
load('usps_main.mat');

% Part 1: Constructing Training Dataset for Digits 3 and 8
% Randomly select 100 examples of digits 3 and 8
rng(42);  % Set random seed for reproducibility

% Extract digit 3 and 8 data
digit3_data = [];
digit8_data = [];

% Collect 100 examples of digit 3
count_3 = 0;
for i = 1:size(maindata, 2)
    if count_3 < 100
        digit3_data = [digit3_data, getonedigit(4, i, maindata)];
        count_3 = count_3 + 1;
    else
        break;
    end
end

% Collect 100 examples of digit 8
count_8 = 0;
for i = 1:size(maindata, 2)
    if count_8 < 100
        digit8_data = [digit8_data, getonedigit(9, i, maindata)];
        count_8 = count_8 + 1;
    else
        break;
    end
end

% Reshape data and create labels
digit3_data_reshaped = reshape(digit3_data, 256, 100)';
digit8_data_reshaped = reshape(digit8_data, 256, 100)';

% Combine data and labels
training_data = [digit3_data_reshaped; digit8_data_reshaped];
training_labels = [ones(100,1) * 3; ones(100,1) * 8];

% Store original data for visualization
training_data_original = [digit3_data_reshaped; digit8_data_reshaped];

% Extract features using the new feature extraction function
disp('Extracting features from training data...');
training_data = extractmyfeatures(training_data_original);
disp(['Training data size after feature extraction: ', num2str(size(training_data))]);

% Part 2: Training Accuracy Analysis
k_values = 1:20;
training_accuracies = zeros(size(k_values));

% Perform training accuracy calculation for different K values
for k = k_values
    predictions = zeros(size(training_labels));
    
    % Classify each training example using leave-one-out strategy
    for i = 1:size(training_data, 1)
        test_sample = training_data(i, :);
        train_data = training_data([1:i-1, i+1:end], :);
        train_labels = training_labels([1:i-1, i+1:end], :);
        
        % Ensure k is not greater than the number of training samples
        k_actual = min(k, size(train_data, 1));
        k_actual = max(k_actual, 1); % Ensure k_actual is at least 1
       
        
        if ~isempty(train_data)
            predictions(i) = knearest(k_actual, test_sample, train_data, train_labels);
        else
            disp('Train data is empty, skipping knearest call.');
        end
    end
    
    % Calculate training accuracy
    training_accuracies(k) = sum(predictions == training_labels) / length(training_labels);
end

% Plot Training Accuracy
figure;
plot(k_values, training_accuracies, 'LineWidth', 2);
title('Training Accuracy vs K');
xlabel('Number of Neighbors (K)');
ylabel('Accuracy');
grid on;

% Part 3 & 4: Random Train-Test Split with Multiple Iterations
num_iterations = 2;
k_values = 1:20;
testing_accuracies = zeros(length(k_values), num_iterations);

for iteration = 1:num_iterations
    % Randomly shuffle the data
    [shuffled_data, shuffled_labels] = shufflerows(training_data, training_labels);
    
    % Split into training and testing sets
    mid_point = floor(size(shuffled_data, 1) / 2);
    test_data = shuffled_data(1:mid_point, :);
    test_labels = shuffled_labels(1:mid_point, :);
    train_data = shuffled_data(mid_point+1:end, :);
    train_labels = shuffled_labels(mid_point+1:end, :);
    
    % Perform classification for different K values
    for k_idx = 1:length(k_values)
        k = k_values(k_idx);
        predictions = zeros(size(test_labels));
        
        % Classify each test sample
        for i = 1:size(test_data, 1)
            % Ensure k is not greater than the number of training samples
            k_actual = min(k, size(train_data, 1));
            k_actual = max(k_actual, 1); % Ensure k_actual is at least 1
           
            if isempty(train_data) ~= true
                predictions(i) = knearest(k_actual, test_data(i, :), train_data, train_labels);
            else
                disp('Train data is empty, skipping knearest call.');
            end
        end
        
        % Calculate testing accuracy
        testing_accuracies(k_idx, iteration) = sum(predictions == test_labels) / length(test_labels);
    end
end

% Part 5: Plot Testing Accuracies with Error Bars
mean_accuracies = mean(testing_accuracies, 2);
std_accuracies = std(testing_accuracies, 0, 2);

figure;
errorbar(k_values, mean_accuracies, std_accuracies, 'LineWidth', 2);
title('Testing Accuracy with Error Bars');
xlabel('Number of Neighbors (K)');
ylabel('Accuracy');
grid on;

% Part 6: Extended Classification for Digits 3, 6, and 8
digits_to_classify = [3, 6, 8];
predictions = zeros(1500, 1);
true_labels = zeros(1500, 1);

% Load benchmark data
load('usps_benchmark.mat');

% Prepare data for each digit
benchmark_data = [];
benchmark_labels = [];

for i = 1:length(digits_to_classify)
    digit = digits_to_classify(i);
    digit_index = digit;
    if digit == 0
        digit_index = 10;
    end
    
    % Extract 500 examples of each digit from benchmark
    digit_data = [];
    for j = 1:500
        digit_data = [digit_data, getonedigit(digit_index, j, benchmarkdata)];
    end
    
    benchmark_data = [benchmark_data; reshape(digit_data, 256, 500)'];
    benchmark_labels = [benchmark_labels; ones(500,1) * digit];
end

% Store original data for visualization
benchmark_data_original = benchmark_data;

% Extract features using the new feature extraction function
disp('Extracting features from benchmark data...');
benchmark_data = extractmyfeatures(benchmark_data_original);
disp(['Benchmark data size after feature extraction: ', num2str(size(benchmark_data))]);

% Choose a good K value from previous experiments
best_k = 3;  % Choose based on your accuracy graphs

% Perform KNN classification
for i = 1:size(benchmark_data, 1)
    predictions(i) = knearest(best_k, benchmark_data(i, :), training_data, training_labels);
    true_labels(i) = benchmark_labels(i);
end

% Visualize results using original pixel data (show only first 64 examples)
num_display = 64; % Show 8x8 grid of digits
display_indices = round(linspace(1, size(benchmark_data_original, 1), num_display));
showdata(benchmark_data_original(display_indices,:), true_labels(display_indices), predictions(display_indices));

% Compute and visualize confusion matrix
confusion_matrix = zeros(length(digits_to_classify));
for i = 1:length(predictions)
    true_idx = find(digits_to_classify == true_labels(i));
    pred_idx = find(digits_to_classify == predictions(i));
    confusion_matrix(true_idx, pred_idx) = confusion_matrix(true_idx, pred_idx) + 1;
end

% Create confusion matrix figure
figure;
imagesc(confusion_matrix);
colormap(flipud(hot)); % Use reversed hot colormap
colorbar;

% Add labels
xlabel('Predicted Label');
ylabel('True Label');
title('Confusion Matrix');

% Add text annotations to cells
for i = 1:size(confusion_matrix, 1)
    for j = 1:size(confusion_matrix, 2)
        text(j, i, num2str(confusion_matrix(i,j)), ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'Color', 'w');
    end
end

% Set ticks to show actual digit values
xticks(1:length(digits_to_classify));
yticks(1:length(digits_to_classify));
xticklabels(digits_to_classify);
yticklabels(digits_to_classify);

% Create accuracy summary figure
figure;
subplot(2,1,1);
plot(k_values, training_accuracies, 'b-', 'LineWidth', 2);
hold on;
plot(k_values, mean_accuracies, 'r-', 'LineWidth', 2);
grid on;
xlabel('k-value');
ylabel('Accuracy');
title('Training vs Testing Accuracy');
legend('Training', 'Testing');

subplot(2,1,2);
bar([sum(confusion_matrix, 2)./500]);
set(gca, 'XTickLabel', digits_to_classify);
xlabel('Digit');
ylabel('Recognition Rate');
title('Per-Digit Recognition Rate');
ylim([0 1]);
grid on;

% Print detailed statistics
disp('Classification Statistics:');
disp('----------------------');
for i = 1:length(digits_to_classify)
    digit = digits_to_classify(i);
    correct = confusion_matrix(i,i);
    total = sum(confusion_matrix(i,:));
    disp(['Digit ' num2str(digit) ': ' num2str(correct) '/' num2str(total) ...
        ' (' num2str(100*correct/total, '%.1f') '%)']);
end
disp('----------------------');
disp(['Overall Accuracy: ', num2str(100*sum(diag(confusion_matrix))/sum(confusion_matrix(:)), '%.1f'), '%']);

% Save all figures for documentation
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
    FigHandle = FigList(iFig);
    FigName   = ['Figure_', num2str(iFig)];
    savefig(FigHandle, FigName);
    saveas(FigHandle, FigName, 'png');
end

% Export results to text file
fid = fopen('classification_results.txt', 'w');
fprintf(fid, 'Handwritten Digit Recognition Results\n');
fprintf(fid, '================================\n\n');
fprintf(fid, 'Training Accuracy Summary:\n');
fprintf(fid, 'Best K value: %d\n', best_k);
fprintf(fid, 'Maximum training accuracy: %.2f%%\n\n', max(training_accuracies)*100);
fprintf(fid, 'Confusion Matrix:\n');
% Print confusion matrix
for i = 1:size(confusion_matrix,1)
    fprintf(fid, '%d\t%d\t%d\n', confusion_matrix(i,:));
end
fprintf(fid, '\nPer-Digit Recognition Rates:\n');
% Print per-digit statistics
for i = 1:length(digits_to_classify)
    fprintf(fid, 'Digit %d: %.1f%%\n', digits_to_classify(i), ...
        100*confusion_matrix(i,i)/sum(confusion_matrix(i,:)));
end
fclose(fid);