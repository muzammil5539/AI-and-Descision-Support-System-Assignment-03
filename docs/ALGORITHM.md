# Algorithm Documentation

## K-Nearest Neighbors (KNN) Algorithm

### Overview

The K-Nearest Neighbors algorithm is a non-parametric, instance-based learning algorithm used for classification and regression. In this project, we implement KNN for handwritten digit classification.

## Table of Contents

1. [Algorithm Theory](#algorithm-theory)
2. [Implementation Details](#implementation-details)
3. [Feature Extraction](#feature-extraction)
4. [Performance Optimization](#performance-optimization)
5. [Cross-Validation](#cross-validation)
6. [Parameter Selection](#parameter-selection)

---

## Algorithm Theory

### Core Concept

KNN classifies a data point based on the classes of its K nearest neighbors in the feature space. The algorithm assumes that similar data points exist in close proximity.

### Mathematical Foundation

Given:
- Training set: D = {(x₁, y₁), (x₂, y₂), ..., (xₙ, yₙ)}
- Test sample: x_test
- Number of neighbors: K

**Step 1: Distance Calculation**

Euclidean distance between test sample and each training sample:

```
d(x_test, xᵢ) = √(Σⱼ(x_test[j] - xᵢ[j])²)
```

**Step 2: Neighbor Selection**

Select K training samples with minimum distances to x_test.

**Step 3: Classification**

Assign the most frequent class label among the K neighbors:

```
ŷ = mode({y₁, y₂, ..., yₖ})
```

### Algorithm Properties

**Advantages:**
- Simple and intuitive
- No training phase (lazy learning)
- Naturally handles multi-class problems
- Non-parametric (no assumptions about data distribution)

**Disadvantages:**
- Computationally expensive for large datasets
- Sensitive to irrelevant features
- Requires appropriate distance metric
- Memory intensive (stores entire training set)

---

## Implementation Details

### 1. Distance Calculation

**Vectorized Implementation:**

```matlab
% Efficient vectorized distance calculation
distances = sqrt(sum((data - x).^2, 2));
```

This approach:
- Broadcasts test sample across all training samples
- Computes squared differences element-wise
- Sums along feature dimension
- Takes square root for Euclidean distance

**Complexity:** O(n × m) where n = training samples, m = features

### 2. Neighbor Selection

```matlab
% Combine distances with labels
distances_with_labels = [distances, datalabels];

% Sort by distance
sorted = sortrows(distances_with_labels, 1);

% Extract top K neighbors
top_k_labels = sorted(1:k, 2);
```

**Complexity:** O(n log n) for sorting

### 3. Classification Decision

```matlab
% Majority voting
y = mode(top_k_labels);
```

**Complexity:** O(k)

### Total Time Complexity

O(n × m + n log n) ≈ O(n log n) for typical cases where m << n

---

## Feature Extraction

### Problem Statement

Raw pixel data (16×16 = 256 dimensions) contains:
- High dimensionality
- Redundant information
- Noise
- Computational overhead

### Solution: Block-Based Feature Extraction

#### Method 1: Column Sum (Basic)

```matlab
function x = extractfeatures(digdata)
    % Sum pixel values along columns
    x = sum(digdata, 1);
end
```

**Output:** 16 features (one per column)

**Characteristics:**
- Simple and fast
- Reduces dimensionality by 93.75%
- Loses spatial information within columns
- Good for preliminary testing

#### Method 2: Block Averaging (Custom)

```matlab
function x = extractmyfeatures(digdata)
    num_samples = size(digdata, 1);
    features = zeros(num_samples, 64);
    
    for i = 1:num_samples
        img = reshape(digdata(i,:), 16, 16);
        feat_idx = 1;
        
        % Divide into 4×4 blocks
        for r = 1:4:16
            for c = 1:4:16
                block = img(r:r+3, c:c+3);
                features(i, feat_idx) = mean(block(:));
                feat_idx = feat_idx + 1;
            end
        end
    end
    
    x = features;
end
```

**Output:** 64 features (4×4 grid of block averages)

**Characteristics:**
- Reduces dimensionality by 75%
- Preserves 2D spatial structure
- Noise reduction through local averaging
- Better discriminative power

#### Visual Representation

```
Original Image (16×16):          Block Features (4×4):
┌────────────────┐              ┌──────┐
│ █████░░░░█████ │              │ 2 0 2│
│ ████░░░░░░████ │              │ 2 0 2│
│ ░░░░░░░░░░░░░░ │    ──→       │ 0 0 0│
│ ░░░░█████░░░░░ │              │ 1 2 1│
│ ░░░░█████░░░░░ │              └──────┘
└────────────────┘
```

### Feature Normalization

Consider normalization for improved performance:

```matlab
% Z-score normalization
features = (features - mean(features, 2)) ./ std(features, 0, 2);

% Min-Max normalization
features = (features - min(features, [], 2)) ./ ...
           (max(features, [], 2) - min(features, [], 2));
```

---

## Performance Optimization

### 1. Vectorization

**Before (Loop-based):**
```matlab
for i = 1:size(data, 1)
    distances(i) = sqrt(sum((data(i,:) - x).^2));
end
```

**After (Vectorized):**
```matlab
distances = sqrt(sum((data - x).^2, 2));
```

**Speedup:** ~10-100× faster depending on data size

### 2. Distance Computation Optimization

Alternative: Avoid sqrt when only comparing distances:
```matlab
% Squared distances sufficient for comparison
distances_squared = sum((data - x).^2, 2);
```

### 3. Memory Optimization

For large datasets, consider:
- Batch processing
- Approximate nearest neighbor methods
- KD-trees or Ball trees for faster neighbor search

### 4. Parallel Processing

```matlab
% Parallel loop for multiple test samples
parfor i = 1:size(test_data, 1)
    predictions(i) = knearest(k, test_data(i,:), train_data, train_labels);
end
```

---

## Cross-Validation

### K-Fold Cross-Validation

**Purpose:** Evaluate model performance on unseen data

**Process:**
1. Divide data into K equal folds
2. For each fold:
   - Use fold as test set
   - Use remaining K-1 folds as training set
   - Compute accuracy
3. Average accuracy across all folds

**Implementation:**

```matlab
function [traindata, trainlabels, testdata, testlabels] = ...
    crossfold(fold, numfolds, data, datalabels)
    
    foldsize = round(size(data,1) / numfolds);
    startindex = (fold-1)*foldsize + 1;
    endindex = min(fold*foldsize, size(data,1));
    
    testindices = startindex:endindex;
    trainindices = [1:startindex-1, endindex+1:size(data,1)];
    
    traindata = data(trainindices, :);
    trainlabels = datalabels(trainindices);
    testdata = data(testindices, :);
    testlabels = datalabels(testindices);
end
```

### Leave-One-Out Cross-Validation (LOOCV)

Special case where K = n (number of samples):
- Each sample used as test set once
- Maximum use of training data
- High computational cost
- Low bias, high variance

---

## Parameter Selection

### Choosing K Value

**Small K (K=1):**
- Pros: Low bias, captures fine details
- Cons: High variance, sensitive to noise, overfitting

**Large K:**
- Pros: Low variance, smooth decision boundaries
- Cons: High bias, underfitting, computational cost

**Optimal K Selection:**

1. **Visual Analysis**: Plot accuracy vs K
2. **Elbow Method**: Look for accuracy plateau
3. **Cross-Validation**: Use validation set performance
4. **Rule of Thumb**: K = √n (n = training samples)

**Example Results:**

```
K=1:  Training: 100%  |  Testing: 85%  (Overfitting)
K=3:  Training: 97%   |  Testing: 92%  (Good balance)
K=5:  Training: 95%   |  Testing: 90%  (Slight underfitting)
K=10: Training: 90%   |  Testing: 85%  (Underfitting)
```

**Recommendation for this dataset:** K = 3-5

### Distance Metric Selection

**Euclidean Distance** (Current implementation):
- Works well for continuous features
- Sensitive to feature scaling
- Appropriate for pixel-based features

**Alternative Metrics:**

**Manhattan Distance:**
```matlab
distances = sum(abs(data - x), 2);
```

**Minkowski Distance (Generalized):**
```matlab
p = 3;  % Parameter
distances = sum(abs(data - x).^p, 2).^(1/p);
```

**Cosine Similarity:**
```matlab
% Appropriate for sparse features
similarity = (data * x') ./ (vecnorm(data, 2, 2) * norm(x));
```

---

## Performance Metrics

### Accuracy
```
Accuracy = (Correct Predictions) / (Total Predictions)
```

### Per-Class Metrics

**Precision:**
```
Precision = TP / (TP + FP)
```

**Recall:**
```
Recall = TP / (TP + FN)
```

**F1-Score:**
```
F1 = 2 × (Precision × Recall) / (Precision + Recall)
```

### Confusion Matrix Analysis

Example for digits 3, 6, 8:

```
          Predicted
          3    6    8
True  3  [450   0   50]
      6  [ 10  440  50]
      8  [  5   0  495]
```

Insights:
- Digit 8: Best performance (495/500 = 99%)
- Digit 3: Confused with digit 8
- Digit 6: Moderate performance

---

## Future Improvements

### 1. Algorithm Enhancements
- Weighted KNN (distance-based weighting)
- Adaptive K selection per query
- Local feature weighting

### 2. Feature Engineering
- Deep learning features (CNN embeddings)
- Histogram of Oriented Gradients (HOG)
- SIFT/SURF descriptors

### 3. Computational Efficiency
- Approximate nearest neighbors (ANN)
- Locality-Sensitive Hashing (LSH)
- KD-tree or Ball-tree indexing

### 4. Ensemble Methods
- Bagging multiple KNN classifiers
- Feature subset ensembles
- Voting from multiple K values

---

## References

1. Cover, T., & Hart, P. (1967). "Nearest neighbor pattern classification"
2. Altman, N. S. (1992). "An introduction to kernel and nearest-neighbor nonparametric regression"
3. Fix, E., & Hodges, J. L. (1951). "Discriminatory analysis - nonparametric discrimination"
4. Bishop, C. M. (2006). "Pattern Recognition and Machine Learning"

---

*Last Updated: January 2026*