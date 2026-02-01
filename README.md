# bibanl

A bibliometric analysis toolkit for calculating academic impact indices.

## Features

- **H-index**: Hirsch's original definition
- **G-index**: Based on cumulative citation counts
- **R-index**: Square root of citations in h-core
- **i10-index**: Papers with 10+ citations (Google Scholar metric)
- **m-quotient**: H-index normalized by academic age
- **hg-index**: Geometric mean of h and g indices
- **VIP journal counting**: Track publications in top-tier journals

## Project Structure

```
bibanl/
├── R/
│   ├── config.R      # Configuration (VIP journal list, defaults)
│   ├── utils.R       # Shared utility functions
│   ├── indices.R     # Index calculation functions
│   └── analysis.R    # High-level analysis functions
├── main.R            # Entry point with examples
├── sample_data_single_researcher.csv
└── sample_data_mutiple_researcher.csv
```

## Quick Start

```r
# Load the toolkit
source("main.R")

# Or load modules individually
source("R/config.R")
source("R/utils.R")
source("R/indices.R")
source("R/analysis.R")
```

## Usage

### Calculate indices from citation vector

```r
citations <- c(100, 50, 30, 20, 10, 5, 3, 1)

h_index(citations)    # H-index
g_index(citations)    # G-index
r_index(citations)    # R-index
i10_index(citations)  # i10-index
all_indices(citations, years_active = 10)  # All at once
```

### Analyze researcher from data file

```r
# Single researcher
data <- read.csv("sample_data_single_researcher.csv")
result <- analyze_researcher(data)

# Multiple researchers
data <- read.csv("sample_data_mutiple_researcher.csv")
results <- analyze_all(data)

# Rank by h-index
top10 <- rank_researchers(results, by = "h_index", top_n = 10)
```

### Expected data format

| Column | Description |
|--------|-------------|
| researcher | Researcher identifier |
| tc | Total citations |
| source | Journal name |
| pyear | Publication year |

## Configuration

Edit `R/config.R` to customize:

- `VIP_JOURNALS`: List of top-tier journals to track
- `DEFAULT_COLS`: Default column name mappings

## Legacy Files

The original implementation files are preserved for reference:
- `h_index.R`, `g_index.R`, `rindex.R` - Original index functions
- `bibm.R`, `datanl.R` - Original analysis functions
- `jnal.R`, `dhindex.R`, `corehindex.R`, `hindex1.R`, `rmhindex.R` - Supporting functions
