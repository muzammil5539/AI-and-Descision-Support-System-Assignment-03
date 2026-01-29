# Quick Start Guide

Get up and running with the Handwritten Digit Recognition project in under 5 minutes!

## Prerequisites Check

Before starting, ensure you have:
- ✅ MATLAB R2016b or later installed
- ✅ At least 4 GB RAM available
- ✅ ~10 MB free disk space

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/muzammil5539/AI-and-Descision-Support-System-Assignment-03.git
```

### 2. Navigate to Project Directory

```bash
cd AI-and-Descision-Support-System-Assignment-03
```

### 3. Verify Data Files

Check that the `data/` directory contains:
- `usps_main.mat`
- `usps_benchmark.mat`

```bash
ls data/
```

## Running Your First Test

### Option 1: Run in MATLAB GUI

1. Open MATLAB
2. Navigate to the project directory:
   ```matlab
   cd /path/to/AI-and-Descision-Support-System-Assignment-03
   ```
3. Change to the `src` directory:
   ```matlab
   cd src
   ```
4. Run the main script:
   ```matlab
   test
   ```

### Option 2: Run from Command Line (Linux/Mac)

```bash
cd src
matlab -batch "test"
```

### Option 3: Run from Command Line (Windows)

```cmd
cd src
matlab -batch "test"
```

## What to Expect

When you run the script, you'll see:

1. **Console Output**:
   ```
   Extracting features from training data...
   Training data size after feature extraction: [200 64]
   Extracting features from benchmark data...
   Benchmark data size after feature extraction: [1500 64]
   
   Classification Statistics:
   ----------------------
   Digit 3: 450/500 (90.0%)
   Digit 6: 440/500 (88.0%)
   Digit 8: 495/500 (99.0%)
   ----------------------
   Overall Accuracy: 92.3%
   ```

2. **Generated Figures**: Multiple MATLAB figures showing:
   - Training accuracy vs K value
   - Testing accuracy with error bars
   - Confusion matrix heatmap
   - Sample digit visualizations

3. **Output Files** in `results/` directory:
   - `classification_results.txt` - Detailed statistics
   - `Figure_1.png`, `Figure_2.png`, etc. - Saved visualizations

## Execution Time

Expected runtime on typical hardware:
- **First run**: ~2-5 minutes (includes feature extraction)
- **Subsequent runs**: ~1-3 minutes (cached operations)

## Troubleshooting

### Issue: "Cannot find usps_main.mat"

**Solution**: Ensure you're in the correct directory structure:
```matlab
pwd  % Check current directory
cd src  % Should be in src/ to run test.m
```

### Issue: "Undefined function or variable"

**Solution**: The script automatically adds paths. If this fails:
```matlab
addpath('utils')
addpath('../data')
addpath('../results')
```

### Issue: "Out of memory"

**Solution**: Close other applications and try:
```matlab
clear all
close all
clc
test
```

### Issue: Figures not displaying

**Solution**: Check figure window style:
```matlab
set(0,'DefaultFigureWindowStyle','normal')  % Undock figures
```

## Next Steps

### 1. Experiment with Different K Values

Edit `src/test.m` and change:
```matlab
best_k = 3;  % Try different values: 1, 5, 7, 10
```

### 2. Test Different Digits

Modify the digits to classify:
```matlab
digits_to_classify = [0, 1, 2];  % Instead of [3, 6, 8]
```

### 3. Adjust Training Size

Change the number of training samples:
```matlab
% In test.m, modify the loop limit
for i = 1:size(maindata, 2)
    if count_3 < 200  % Change from 100 to 200
        ...
    end
end
```

### 4. Try Different Feature Extraction

Switch between feature extraction methods:
```matlab
% Option 1: Basic (column sum)
training_data = extractfeatures(training_data_original);

% Option 2: Custom (block averaging) - Default
training_data = extractmyfeatures(training_data_original);
```

## Understanding the Output

### Console Statistics

```
Digit 3: 450/500 (90.0%)
         ^^^              Correctly classified count
             ^^^          Total test samples for this digit
                  ^^^^^   Accuracy percentage
```

### Confusion Matrix

```
        Predicted
        3    6    8
True 3  450  10   40   ← 450 correctly classified as 3
     6   5  440  55   ← 440 correctly classified as 6
     8   2    3  495  ← 495 correctly classified as 8
```

**Reading the matrix:**
- Diagonal values (450, 440, 495) = Correct classifications
- Off-diagonal values = Misclassifications
- Row sums should equal 500 (test samples per digit)

### Accuracy Plots

**Training vs Testing Accuracy:**
- Training accuracy typically higher (model sees this data)
- Testing accuracy reflects real-world performance
- Gap between curves indicates overfitting

**Optimal K Selection:**
- Look for peak in testing accuracy
- Balance between bias and variance
- Usually K=3-5 works well for this dataset

## Common Use Cases

### Use Case 1: Comparing Feature Methods

Run with both feature extraction methods and compare results:

1. Edit `test.m` to use `extractfeatures`
2. Run and note accuracy
3. Edit `test.m` to use `extractmyfeatures`
4. Run and compare

### Use Case 2: Finding Optimal K

```matlab
% Add this code after loading data
k_values = 1:20;
accuracies = zeros(size(k_values));

for k = k_values
    % Test with this k value
    % Store accuracy
end

% Plot results
plot(k_values, accuracies);
xlabel('K Value');
ylabel('Accuracy');
title('K Selection Analysis');
```

### Use Case 3: Analyzing Specific Digits

Focus on a specific digit pair:

```matlab
digits_to_classify = [3, 8];  % Only digits 3 and 8
% Easier classification task - expect higher accuracy
```

## Performance Optimization Tips

### 1. Reduce Visualization Overhead

Comment out visualization lines in `test.m`:
```matlab
% showdata(benchmark_data_original(display_indices,:), ...);
```

### 2. Use Smaller Dataset for Testing

```matlab
% Reduce benchmark samples
for j = 1:100  % Instead of 1:500
    ...
end
```

### 3. Disable Figure Saving

```matlab
% Comment out figure saving loop
% for iFig = 1:length(FigList)
%     ...
% end
```

## Getting Help

If you encounter issues:

1. **Check Documentation**: Read the full [README.md](../README.md)
2. **Algorithm Details**: See [ALGORITHM.md](../docs/ALGORITHM.md)
3. **Report Issues**: Open an issue on GitHub
4. **Community**: Check existing issues for solutions

## Success Indicators

You'll know everything is working correctly when you see:

✅ No error messages in console  
✅ Multiple figures displayed  
✅ Accuracy > 80% for most digits  
✅ Files created in `results/` directory  
✅ Runtime completes in < 5 minutes  

## What's Next?

Now that you have the basic setup running:

1. 📚 Read the [full documentation](../README.md)
2. 🔬 Experiment with different parameters
3. 📊 Analyze the results in detail
4. 🚀 Try implementing improvements
5. 🤝 Contribute back to the project

---

**Happy Coding! 🎉**

*Need more help? Check the [main README](../README.md) or open an issue.*
