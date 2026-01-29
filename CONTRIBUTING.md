# Contributing to Handwritten Digit Recognition using KNN

First off, thank you for considering contributing to this project! It's people like you that make this project better for everyone.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Coding Standards](#coding-standards)
- [Submission Guidelines](#submission-guidelines)

## Code of Conduct

This project and everyone participating in it is governed by our commitment to maintaining a welcoming and inclusive environment. By participating, you are expected to uphold this code.

### Our Standards

- **Be Respectful**: Treat everyone with respect and consideration
- **Be Collaborative**: Work together effectively and constructively
- **Be Professional**: Keep discussions focused and professional
- **Be Open-Minded**: Welcome newcomers and diverse perspectives

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include:

- **Clear Title**: A descriptive title for the issue
- **Description**: Detailed description of the problem
- **Steps to Reproduce**: Step-by-step instructions to reproduce the issue
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Environment**: MATLAB version, OS, and any relevant details
- **Screenshots**: If applicable, add screenshots to help explain the problem

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When suggesting an enhancement:

- **Use a clear title** describing the enhancement
- **Provide detailed description** of the proposed functionality
- **Explain why** this enhancement would be useful
- **Provide examples** of how the enhancement would be used

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Make your changes** following our coding standards
3. **Test your changes** thoroughly
4. **Update documentation** as needed
5. **Submit a pull request** with a clear description

## Development Setup

### Prerequisites

- MATLAB R2016b or later
- Git for version control
- Basic understanding of machine learning concepts

### Setting Up Your Development Environment

1. **Fork and Clone**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/AI-and-Descision-Support-System-Assignment-03.git
   cd AI-and-Descision-Support-System-Assignment-03
   ```

2. **Create a Branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Changes**: Implement your feature or bug fix

4. **Test Your Changes**: Run the main script to ensure everything works
   ```matlab
   cd src
   test
   ```

## Coding Standards

### MATLAB Code Style

#### Naming Conventions

- **Functions**: Use lowercase with underscores (e.g., `extract_features.m`)
- **Variables**: Use descriptive camelCase (e.g., `trainingData`, `numSamples`)
- **Constants**: Use UPPERCASE with underscores (e.g., `MAX_ITERATIONS`)

#### Code Structure

```matlab
%% Function Title
% Brief description of what the function does
%
% Detailed description (optional)
%
% Parameters:
%   param1 - description
%   param2 - description
%
% Returns:
%   output1 - description
%
% Example:
%   result = myfunction(input1, input2);

function output = myfunction(param1, param2)
    % Input validation
    validateattributes(param1, {'numeric'}, {'positive'});
    
    % Function logic
    output = param1 + param2;
end
```

#### Documentation

- Add clear comments explaining complex logic
- Include function headers with parameter descriptions
- Use section breaks (`%%`) to organize code logically
- Document assumptions and limitations

#### Code Quality

- **Avoid Global Variables**: Use function parameters instead
- **Vectorize Operations**: Use MATLAB's vectorized operations for efficiency
- **Error Handling**: Include appropriate error checking and validation
- **Magic Numbers**: Define constants at the top of the file
- **DRY Principle**: Don't Repeat Yourself - extract common code into functions

### Testing

- Test your code with different inputs and edge cases
- Verify that existing functionality still works
- Include test data or scripts if adding new features
- Document test procedures in your pull request

## Submission Guidelines

### Pull Request Process

1. **Update Documentation**: Ensure README and other docs reflect your changes
2. **Add Comments**: Include inline comments for complex logic
3. **Test Thoroughly**: Verify all functionality works as expected
4. **Clean Commit History**: Use clear, descriptive commit messages
5. **Reference Issues**: Link related issues in your PR description

### Commit Message Guidelines

Use clear and descriptive commit messages:

```
feat: Add improved feature extraction method
fix: Correct distance calculation in KNN
docs: Update installation instructions
refactor: Optimize KNN distance computation
test: Add validation for edge cases
```

Prefix types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Pull Request Template

When submitting a PR, include:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code refactoring

## Testing
Describe the tests you ran

## Checklist
- [ ] Code follows project style guidelines
- [ ] Documentation updated
- [ ] Changes tested locally
- [ ] No breaking changes introduced
```

## Areas for Contribution

We particularly welcome contributions in these areas:

### 1. Algorithm Improvements
- Alternative distance metrics (Manhattan, Minkowski)
- Weighted KNN implementation
- Adaptive K selection methods
- Ensemble methods

### 2. Feature Engineering
- Additional feature extraction techniques
- Dimensionality reduction methods (PCA, LDA)
- Feature selection algorithms
- Preprocessing improvements

### 3. Visualization
- Interactive plots and dashboards
- 3D visualizations of feature space
- Animation of learning process
- Enhanced confusion matrix displays

### 4. Performance Optimization
- Parallel processing implementation
- Memory optimization
- Faster distance computation methods
- Caching strategies

### 5. Documentation
- Tutorial notebooks
- Video demonstrations
- API documentation
- Code examples

### 6. Testing
- Unit tests for utility functions
- Integration tests
- Performance benchmarks
- Edge case validation

## Questions?

Feel free to open an issue with the `question` label if you have any questions about contributing.

## Recognition

Contributors will be acknowledged in:
- README.md Contributors section
- Release notes for significant contributions
- Project documentation

---

Thank you for contributing to making this project better! 🎉