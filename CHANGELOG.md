# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Professional repository structure with organized directories
- Comprehensive README with badges, table of contents, and detailed sections
- CONTRIBUTING.md with contribution guidelines
- ALGORITHM.md with detailed algorithm documentation
- QUICKSTART.md for quick setup and usage
- LICENSE file (MIT License)
- .gitignore for MATLAB projects
- Professional project organization

### Changed
- Reorganized all source files into `src/` directory
- Moved utility functions to `src/utils/` subdirectory
- Moved data files to `data/` directory
- Moved results and visualizations to `results/` directory
- Updated file paths in `test.m` to reflect new structure
- Enhanced README from basic description to comprehensive documentation

### Improved
- Code documentation with detailed inline comments
- Visual appeal with badges, emojis, and formatting
- Project discoverability with detailed feature list
- Onboarding experience with installation and usage instructions

## [1.0.0] - 2026-01-29

### Initial Release

#### Features
- K-Nearest Neighbors classifier implementation
- Custom feature extraction using block-based averaging
- Cross-validation support
- Comprehensive visualization suite
  - Training vs testing accuracy plots
  - Confusion matrix with heatmaps
  - Per-digit recognition analysis
  - Misclassification highlighting
- Support for USPS handwritten digit dataset
- Reproducible results with fixed random seeds

#### Core Components
- `knearest.m` - KNN classifier with vectorized operations
- `test.m` - Main testing and evaluation script
- `extractmyfeatures.m` - Custom block-based feature extraction
- `extractfeatures.m` - Basic column-sum feature extraction
- `crossfold.m` - K-fold cross-validation utility
- `getonedigit.m` - Single digit extraction utility
- `showdata.m` - Batch digit visualization
- `showdigit.m` - Single digit visualization
- `shufflerows.m` - Data shuffling utility

#### Dataset
- USPS handwritten digits (16×16 pixel grayscale images)
- Main training dataset (`usps_main.mat`)
- Benchmark testing dataset (`usps_benchmark.mat`)

#### Performance
- Training accuracy: Up to 97%
- Testing accuracy: 70-90% depending on digit
- Optimal K value: 3-5 for this dataset
- Feature reduction: 256 → 64 dimensions

---

## Version History Summary

- **[Unreleased]** - Repository reorganization and documentation enhancement
- **[1.0.0]** - Initial working implementation

## Future Releases

### Planned for v1.1.0
- [ ] Enhanced feature extraction methods
- [ ] Additional distance metrics (Manhattan, Cosine)
- [ ] Weighted KNN implementation
- [ ] Performance benchmarking suite
- [ ] Unit tests for utility functions

### Planned for v2.0.0
- [ ] Support for additional datasets (MNIST, custom datasets)
- [ ] GUI interface for interactive testing
- [ ] Real-time digit recognition from images
- [ ] Model export/import functionality
- [ ] Parallel processing support

### Ideas for Future Versions
- Deep learning comparison (CNN vs KNN)
- Ensemble methods implementation
- Real-time webcam digit recognition
- Mobile app integration
- Cloud deployment options

---

## How to Read This Changelog

- **Added**: New features
- **Changed**: Changes in existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Security vulnerability fixes
- **Improved**: Enhancements to existing features

---

*Last Updated: January 29, 2026*
