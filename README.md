# Handwritten Digit Recognition using K-Nearest Neighbors (KNN)

[![MATLAB](https://img.shields.io/badge/MATLAB-R2016b%2B-orange.svg)](https://www.mathworks.com/products/matlab.html)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A comprehensive implementation of the K-Nearest Neighbors (KNN) algorithm for handwritten digit recognition using the USPS (United States Postal Service) dataset. This project was developed as part of the EC-350 Artificial Intelligence and Decision Support Systems course.

![Project Banner](results/Code%20Structure.png)

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Algorithm Details](#algorithm-details)
- [Results](#results)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

> **🚀 New to the project?** Check out our [Quick Start Guide](docs/QUICKSTART.md) to get running in 5 minutes!

## 🎯 Overview

This project implements a complete pipeline for handwritten digit recognition, demonstrating the effectiveness of the K-Nearest Neighbors algorithm for classification tasks. The system processes 16×16 pixel grayscale images of handwritten digits and classifies them with high accuracy.

### Key Objectives

- Implement an efficient KNN classifier from scratch
- Develop custom feature extraction techniques to improve classification accuracy
- Perform comprehensive cross-validation and performance analysis
- Visualize classification results and confusion matrices
- Analyze the impact of different K values on classification performance

## ✨ Features

- **Efficient KNN Implementation**: Vectorized distance calculations for optimal performance
- **Custom Feature Extraction**: Block-based feature extraction reducing dimensionality from 256 to 64 features
- **Cross-Validation**: Robust model evaluation using k-fold cross-validation
- **Comprehensive Visualization**: 
  - Training vs testing accuracy plots
  - Confusion matrices with heatmaps
  - Per-digit recognition rate analysis
  - Misclassification highlighting
- **Flexible Dataset Handling**: Support for multi-digit classification (digits 3, 6, and 8)
- **Reproducible Results**: Fixed random seed for consistent experimentation

## 📁 Project Structure

```
AI-and-Descision-Support-System-Assignment-03/
├── src/                          # Source code files
│   ├── test.m                    # Main execution script
│   ├── knearest.m                # KNN classifier implementation
│   └── utils/                    # Utility functions
│       ├── crossfold.m           # Cross-validation utility
│       ├── extractfeatures.m     # Basic feature extraction
│       ├── extractmyfeatures.m   # Custom feature extraction
│       ├── getonedigit.m         # Single digit extraction
│       ├── showdata.m            # Batch visualization
│       ├── showdigit.m           # Single digit visualization
│       └── shufflerows.m         # Data shuffling utility
├── data/                         # Dataset files
│   ├── usps_main.mat             # Main training dataset
│   └── usps_benchmark.mat        # Benchmark testing dataset
├── results/                      # Output files and visualizations
│   ├── classification_results.txt
│   ├── Confusion Matrix.jpg
│   ├── Code Structure.png
│   └── Figure_*.png              # Generated plots
├── docs/                         # Additional documentation
├── README.md                     # This file
├── CONTRIBUTING.md               # Contribution guidelines
└── .gitignore                    # Git ignore rules

```

## 🔧 Requirements

- **MATLAB**: R2016b or later
- **Toolboxes**: Statistics and Machine Learning Toolbox (recommended)
- **Storage**: ~10 MB for datasets and results
- **RAM**: 4 GB minimum recommended

## 💻 Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/muzammil5539/AI-and-Descision-Support-System-Assignment-03.git
cd AI-and-Descision-Support-System-Assignment-03
```

### Step 2: Verify Data Files

Ensure the following data files are present in the `data/` directory:
- `usps_main.mat` - Main training dataset
- `usps_benchmark.mat` - Benchmark testing dataset

### Step 3: MATLAB Setup

1. Open MATLAB
2. Navigate to the project directory
3. The script automatically adds necessary paths

## 🚀 Usage

### Basic Usage

1. Open MATLAB and navigate to the `src/` directory:
   ```matlab
   cd src/
   ```

2. Run the main test script:
   ```matlab
   test
   ```

3. The script will:
   - Load and prepare the dataset
   - Extract features from digit images
   - Train the KNN classifier
   - Perform cross-validation
   - Generate visualizations
   - Save results to the `results/` directory

### Advanced Usage

#### Custom K Value

To test with a specific K value, modify the `best_k` variable in `test.m`:

```matlab
best_k = 5;  % Change to your desired K value
```

#### Custom Feature Extraction

The project includes two feature extraction methods:

1. **Basic Feature Extraction** (`extractfeatures.m`): Sums pixel values along columns
2. **Custom Feature Extraction** (`extractmyfeatures.m`): Block-based averaging (4×4 blocks)

To switch between methods, modify the feature extraction calls in `test.m`.

#### Analyzing Different Digits

To classify different digits, modify the `digits_to_classify` array:

```matlab
digits_to_classify = [0, 1, 2];  % Classify digits 0, 1, and 2
```

### Understanding the Output

The script generates several outputs:

1. **Console Output**: Real-time progress and accuracy statistics
2. **Figures**: 
   - Training accuracy vs K value
   - Testing accuracy with error bars
   - Confusion matrix heatmap
   - Sample digit visualizations with error highlighting
3. **Results File**: Detailed statistics saved to `results/classification_results.txt`

## 🧮 Algorithm Details

### K-Nearest Neighbors (KNN) Classifier

The KNN algorithm classifies a test sample based on the majority vote of its K nearest neighbors in the training set.

#### Implementation Steps:

1. **Distance Calculation**: Euclidean distance between test sample and all training samples
   ```matlab
   distances = sqrt(sum((data - x).^2, 2));
   ```

2. **Neighbor Selection**: Sort distances and select K nearest neighbors

3. **Voting**: Assign the most common label among the K neighbors
   ```matlab
   y = mode(top_k_labels);
   ```

### Feature Extraction

#### Custom Block-Based Feature Extraction

The custom feature extraction method divides each 16×16 image into 4×4 blocks and computes the mean intensity of each block:

- **Input**: 256 dimensions (16×16 pixels)
- **Output**: 64 dimensions (4×4 grid of block averages)
- **Benefits**:
  - Reduces dimensionality by 75%
  - Preserves spatial relationships
  - Reduces noise through local averaging
  - Improves computational efficiency

### Cross-Validation

The implementation uses k-fold cross-validation to ensure robust performance evaluation:

- Data is randomly shuffled
- Split into training and testing sets
- Multiple iterations reduce variance in accuracy estimates
- Error bars visualize performance variability

## 📊 Results

### Performance Summary

Based on the classification of digits 3, 6, and 8:

| Metric | Value |
|--------|-------|
| **Training Accuracy** | 97.0% |
| **Best K Value** | 3 |
| **Overall Test Accuracy** | ~70-85% (varies by digit) |

### Per-Digit Performance

- **Digit 3**: ~65-70% accuracy
- **Digit 6**: Variable performance (~50-60%)
- **Digit 8**: ~85-90% accuracy (best performance)

### Confusion Matrix

![Confusion Matrix](results/Confusion%20Matrix.jpg)

The confusion matrix reveals:
- Digit 8 is classified most accurately
- Significant confusion between digits 3 and 8
- Digit 6 shows challenging classification patterns

### Accuracy vs K Value

![Accuracy Plots](results/Figure_1.png)

The analysis shows:
- Training accuracy decreases as K increases (expected behavior)
- Optimal K value is around 3-5 for this dataset
- Higher K values lead to oversmoothing and reduced accuracy

## 📚 Documentation

Comprehensive documentation is available to help you understand and use this project:

- **[Quick Start Guide](docs/QUICKSTART.md)** - Get up and running in 5 minutes
- **[Algorithm Documentation](docs/ALGORITHM.md)** - Detailed explanation of KNN algorithm and implementation
- **[Contributing Guidelines](CONTRIBUTING.md)** - How to contribute to the project
- **[License](LICENSE)** - MIT License details

### Additional Resources

- **Code Documentation**: All MATLAB functions include detailed inline documentation
- **Examples**: See the main `test.m` script for comprehensive usage examples
- **Issues & Discussions**: Visit our [GitHub Issues](https://github.com/muzammil5539/AI-and-Descision-Support-System-Assignment-03/issues) page

## 🤝 Contributing

We welcome contributions to improve this project! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

### Quick Start for Contributors

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Areas for Contribution

- Improved feature extraction methods
- Additional classification algorithms for comparison
- Enhanced visualization techniques
- Performance optimization
- Extended dataset support
- Documentation improvements

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Course**: EC-350 Artificial Intelligence and Decision Support Systems
- **Dataset**: USPS Handwritten Digit Database
- **Instructor**: [Course Instructor Name]
- **Institution**: [University/Institution Name]

### References

- [K-Nearest Neighbors Algorithm](https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm)
- [USPS Dataset Information](http://www.cs.nyu.edu/~roweis/data.html)
- [MATLAB Documentation](https://www.mathworks.com/help/matlab/)

---

## 📞 Contact

For questions, issues, or suggestions:

- **Repository Issues**: [GitHub Issues](https://github.com/muzammil5539/AI-and-Descision-Support-System-Assignment-03/issues)
- **Email**: [Your Email]
- **Project Link**: [https://github.com/muzammil5539/AI-and-Descision-Support-System-Assignment-03](https://github.com/muzammil5539/AI-and-Descision-Support-System-Assignment-03)

---

**⭐ If you find this project helpful, please consider giving it a star!**

Last Updated: January 2026
