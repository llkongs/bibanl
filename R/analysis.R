# Main Analysis Functions for bibanl
# High-level functions for bibliometric analysis

#' Analyze a single researcher's bibliometric profile
#'
#' Computes comprehensive bibliometric indices for a single researcher.
#'
#' @param data A data.frame containing the researcher's articles
#' @param tc_col Column name for total citations (default: "tc")
#' @param source_col Column name for journal source (default: "source")
#' @param year_col Column name for publication year (default: "pyear")
#' @param researcher_col Column name for researcher (default: "researcher")
#' @param vip_list Vector of VIP journal names (default: VIP_JOURNALS from config)
#' @return A data.frame with one row containing all bibliometric indices
#'
#' @examples
#' analyze_researcher(researcher_data)
analyze_researcher <- function(data,
                                tc_col = "tc",
                                source_col = "source",
                                year_col = "pyear",
                                researcher_col = "researcher",
                                vip_list = VIP_JOURNALS) {

  # Validate input
  validate_data(data, c(tc_col, source_col, year_col))

  # Get citation vector
  citations <- data[, tc_col]

  # Calculate all indices
  indices <- all_indices(citations, years_active(data, year_col))

  # Build result data frame
  result <- data.frame(
    researcher = if (researcher_col %in% names(data)) data[1, researcher_col] else "Unknown",
    h_index = indices$h_index,
    g_index = indices$g_index,
    r_index = round(indices$r_index, 2),
    i10_index = indices$i10_index,
    hg_index = round(indices$hg_index, 2),
    m_quotient = round(indices$m_quotient, 3),
    total_papers = indices$total_papers,
    total_citations = indices$total_citations,
    avg_citations = round(indices$avg_citations, 2),
    years_active = indices$years_active,
    unique_journals = length(unique(data[, source_col])),
    vip_publications = count_vip_publications(data, source_col, vip_list),
    stringsAsFactors = FALSE
  )

  result
}

#' Analyze multiple researchers
#'
#' Computes bibliometric indices for multiple researchers in a dataset.
#'
#' @param data A data.frame containing articles from multiple researchers
#' @param researcher_col Column name for researcher (default: "researcher")
#' @param ... Additional arguments passed to analyze_researcher
#' @return A data.frame with one row per researcher
#'
#' @examples
#' analyze_all(multi_researcher_data)
analyze_all <- function(data, researcher_col = "researcher", ...) {

  # Split by researcher
  researcher_data <- split_by_researcher(data, researcher_col)

  # Analyze each researcher
  results <- lapply(researcher_data, function(rd) {
    analyze_researcher(rd, researcher_col = researcher_col, ...)
  })

  # Combine results
  do.call(rbind, results)
}

#' Generate summary statistics
#'
#' Provides summary statistics across all researchers.
#'
#' @param analysis_result Output from analyze_all()
#' @return List of summary statistics
summarize_analysis <- function(analysis_result) {
  list(
    total_researchers = nrow(analysis_result),
    avg_h_index = mean(analysis_result$h_index),
    max_h_index = max(analysis_result$h_index),
    avg_total_papers = mean(analysis_result$total_papers),
    avg_citations_per_researcher = mean(analysis_result$total_citations),
    total_vip_publications = sum(analysis_result$vip_publications)
  )
}

#' Compare researchers
#'
#' Ranks researchers by a specified metric.
#'
#' @param analysis_result Output from analyze_all()
#' @param by Column name to rank by (default: "h_index")
#' @param top_n Number of top researchers to return (default: all)
#' @return Sorted data.frame
rank_researchers <- function(analysis_result, by = "h_index", top_n = NULL) {
  if (!by %in% names(analysis_result)) {
    stop(paste("Column not found:", by))
  }

  sorted <- analysis_result[order(analysis_result[, by], decreasing = TRUE), ]
  sorted$rank <- seq_len(nrow(sorted))

  if (!is.null(top_n) && top_n < nrow(sorted)) {
    sorted <- sorted[1:top_n, ]
  }

  # Reorder columns to put rank first
  cols <- c("rank", setdiff(names(sorted), "rank"))
  sorted[, cols]
}

#' Export analysis results
#'
#' Exports analysis results to CSV file.
#'
#' @param analysis_result Output from analyze_all()
#' @param filename Output filename
#' @param ... Additional arguments passed to write.csv
export_results <- function(analysis_result, filename, ...) {
  write.csv(analysis_result, filename, row.names = FALSE, ...)
  message(paste("Results exported to:", filename))
}
