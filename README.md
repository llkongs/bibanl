# bibanl - Bibliometric Analysis Toolkit

[![R](https://img.shields.io/badge/R-%3E%3D%203.0-blue.svg)](https://www.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/llkongs/bibanl.svg?style=social&label=Star)](https://github.com/llkongs/bibanl)

A lightweight R toolkit for **bibliometric analysis** and **academic impact assessment**. Calculate H-index, G-index, and other scholarly metrics from citation data exported from Web of Science, Scopus, or Google Scholar.

> **Keywords**: bibliometrics, h-index, g-index, citation analysis, academic metrics, research impact, scientometrics, R statistics, Web of Science, Scopus

## Table of Contents

- [Why bibanl?](#why-bibanl)
- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage Examples](#usage-examples)
- [Supported Metrics](#supported-metrics)
- [Data Format](#data-format)
- [Configuration](#configuration)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)
- [Citation](#citation)

## Why bibanl?

- **Simple**: No complex dependencies, pure R implementation
- **Fast**: Vectorized operations for efficient computation
- **Flexible**: Works with any citation data in CSV format
- **Complete**: Calculates 7+ bibliometric indices in one call
- **Extensible**: Easy to add custom metrics and journal lists

## Features

| Metric | Description |
|--------|-------------|
| **H-index** | Hirsch index - h papers with at least h citations each |
| **G-index** | Top g papers have together at least g² citations |
| **R-index** | Square root of citations in h-core papers |
| **i10-index** | Number of papers with 10+ citations (Google Scholar) |
| **m-quotient** | H-index divided by academic career length |
| **hg-index** | Geometric mean of h-index and g-index |
| **VIP count** | Publications in Nature, Science, Cell, PNAS, etc. |

## Installation

```bash
# Clone the repository
git clone https://github.com/llkongs/bibanl.git
cd bibanl
```

No package installation required - just source the files in R.

## Quick Start

```r
# Load the toolkit
source("main.R")

# Calculate h-index from a citation vector
citations <- c(100, 50, 30, 20, 10, 5, 3, 1)
h_index(citations)  # Returns: 5
```

## Usage Examples

### Calculate Individual Metrics

```r
source("R/config.R")
source("R/utils.R")
source("R/indices.R")

citations <- c(245, 187, 156, 98, 76, 54, 43, 32, 21, 15, 8, 5, 3, 1, 0)

h_index(citations)     # H-index: 9
g_index(citations)     # G-index: 14
r_index(citations)     # R-index: 31.05
i10_index(citations)   # i10-index: 10
```

### Calculate All Metrics at Once

```r
all_indices(citations, years_active = 15)

# Returns:
# $h_index: 9
# $g_index: 14
# $r_index: 31.05
# $i10_index: 10
# $hg_index: 11.22
# $m_quotient: 0.6
# $total_citations: 961
# $total_papers: 15
# $avg_citations: 64.07
```

### Analyze Researchers from Data File

```r
source("R/analysis.R")

# Single researcher analysis
data <- read.csv("sample_data_single_researcher.csv")
result <- analyze_researcher(data)
print(result)

# Multiple researchers - batch analysis
multi_data <- read.csv("sample_data_mutiple_researcher.csv")
results <- analyze_all(multi_data)

# Rank researchers by h-index
top10 <- rank_researchers(results, by = "h_index", top_n = 10)
print(top10)
```

### Export Results

```r
# Export to CSV
export_results(results, "bibliometric_analysis_results.csv")
```

## Supported Metrics

### H-index (Hirsch, 2005)
A researcher has index h if h of their papers have at least h citations each.

```
Papers (sorted by citations): 100, 50, 30, 20, 10, 5, 3, 1
Position:                       1,  2,  3,  4,  5, 6, 7, 8
H-index = 5 (5 papers have ≥5 citations)
```

### G-index (Egghe, 2006)
The largest number g such that the top g papers have together at least g² citations.

### R-index (Jin et al., 2007)
Square root of total citations received by papers in the h-core.

### i10-index (Google Scholar)
Simply the number of publications with at least 10 citations.

### m-quotient (Hirsch, 2005)
H-index divided by academic age (years since first publication).

## Data Format

Your input CSV should contain these columns:

| Column | Description | Example |
|--------|-------------|---------|
| `researcher` | Author name or ID | "John Smith" |
| `tc` | Total citations | 156 |
| `source` | Journal name | "NATURE" |
| `pyear` | Publication year | 2015 |

### Sample Data

The repository includes sample data files:
- `sample_data_single_researcher.csv` - Single author publication record
- `sample_data_mutiple_researcher.csv` - Multiple authors for comparison

## Configuration

Edit `R/config.R` to customize:

### VIP Journals List

```r
VIP_JOURNALS <- c(
  "NATURE", "SCIENCE", "CELL",
  "PROCEEDINGS OF THE NATIONAL ACADEMY OF SCIENCES...",
  # Add your own journals here
)
```

### Default Column Names

```r
DEFAULT_COLS <- list(
  researcher = "researcher",
  total_citations = "tc",
  source = "source",
  pub_year = "pyear"
)
```

## Project Structure

```
bibanl/
├── R/
│   ├── config.R      # Configuration (VIP journals, defaults)
│   ├── utils.R       # Utility functions
│   ├── indices.R     # Index calculations (vectorized)
│   └── analysis.R    # High-level analysis functions
├── main.R            # Entry point with examples
├── sample_data_single_researcher.csv
├── sample_data_mutiple_researcher.csv
└── README.md
```

## Contributing

Contributions are welcome! Here are some ways you can help:

1. **Add new metrics**: Implement additional bibliometric indices
2. **Improve performance**: Optimize existing algorithms
3. **Add data sources**: Support more citation database formats
4. **Documentation**: Improve examples and documentation
5. **Bug reports**: Open an issue if you find problems

### Development

```bash
git clone https://github.com/llkongs/bibanl.git
cd bibanl
# Make your changes
# Test with: source("main.R")
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Citation

If you use bibanl in your research, please cite:

```bibtex
@software{bibanl,
  author = {llkongs},
  title = {bibanl: Bibliometric Analysis Toolkit for R},
  year = {2014},
  url = {https://github.com/llkongs/bibanl}
}
```

## References

- Hirsch, J. E. (2005). An index to quantify an individual's scientific research output. *PNAS*, 102(46), 16569-16572.
- Egghe, L. (2006). Theory and practise of the g-index. *Scientometrics*, 69(1), 131-152.
- Jin, B., et al. (2007). The R-and AR-indices: Complementing the h-index. *Chinese Science Bulletin*, 52(6), 855-863.

---

**Star this repo** if you find it useful!

*Made with R for the research community*
