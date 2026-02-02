# bibanl - Bibliometric Analysis Tool
# Main entry point

# Load all modules
source("R/config.R")
source("R/utils.R")
source("R/indices.R")
source("R/analysis.R")

# =============================================================================
# Usage Examples
# =============================================================================

cat("bibanl - Bibliometric Analysis Tool\n")
cat("====================================\n\n")

# Example 1: Analyze a single researcher
cat("Example 1: Single Researcher Analysis\n")
cat("--------------------------------------\n")

single_data <- read.csv("sample_data_single_researcher.csv", stringsAsFactors = FALSE)
single_result <- analyze_researcher(single_data)
print(single_result)

cat("\n")

# Example 2: Analyze multiple researchers
cat("Example 2: Multiple Researcher Analysis\n")
cat("----------------------------------------\n")

multi_data <- read.csv("sample_data_mutiple_researcher.csv", stringsAsFactors = FALSE)
multi_result <- analyze_all(multi_data)
print(multi_result)

cat("\n")

# Example 3: Rank researchers by h-index
cat("Example 3: Top 10 Researchers by H-index\n")
cat("-----------------------------------------\n")

top_researchers <- rank_researchers(multi_result, by = "h_index", top_n = 10)
print(top_researchers[, c("rank", "researcher", "h_index", "g_index", "total_papers", "total_citations")])

cat("\n")

# Example 4: Summary statistics
cat("Example 4: Summary Statistics\n")
cat("-----------------------------\n")

summary_stats <- summarize_analysis(multi_result)
print(summary_stats)

cat("\n")

# Example 5: Quick index calculation from citation vector
cat("Example 5: Quick Index Calculation\n")
cat("-----------------------------------\n")

example_citations <- c(245, 187, 156, 98, 76, 54, 43, 32, 21, 15, 8, 5, 3, 1, 0)
cat("Citations:", paste(example_citations, collapse = ", "), "\n")
cat("H-index:", h_index(example_citations), "\n")
cat("G-index:", g_index(example_citations), "\n")
cat("R-index:", round(r_index(example_citations), 2), "\n")
cat("i10-index:", i10_index(example_citations), "\n")

cat("\n====================================\n")
cat("Analysis complete!\n")
