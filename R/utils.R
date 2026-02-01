# Utility functions for bibanl
# These are shared helper functions used across the package

#' Sort data by citations in descending order
#'
#' @param data A data.frame containing article data
#' @param tc_col Column name for total citations
#' @return Sorted data.frame
sort_by_citations <- function(data, tc_col = "tc") {
  data[order(data[, tc_col], decreasing = TRUE), ]
}

#' Get current year
#'
#' @return Current year as integer
current_year <- function() {
  as.integer(format(Sys.Date(), "%Y"))
}

#' Calculate years since first publication
#'
#' @param data A data.frame containing article data
#' @param year_col Column name for publication year
#' @return Number of years since first publication
years_active <- function(data, year_col = "pyear") {
  current_year() - min(data[, year_col], na.rm = TRUE) + 1
}

#' Count VIP journal publications
#'
#' @param data A data.frame containing article data
#' @param source_col Column name for journal source
#' @param vip_list Vector of VIP journal names
#' @return Count of VIP publications
count_vip_publications <- function(data, source_col = "source",
                                    vip_list = VIP_JOURNALS) {
  sum(data[, source_col] %in% vip_list)
}

#' Split data by researcher
#'
#' @param data A data.frame containing article data
#' @param researcher_col Column name for researcher
#' @return List of data.frames, one per researcher
split_by_researcher <- function(data, researcher_col = "researcher") {
  split(data, data[, researcher_col])
}

#' Validate input data
#'
#' @param data A data.frame to validate
#' @param required_cols Vector of required column names
#' @return TRUE if valid, stops with error otherwise
validate_data <- function(data, required_cols) {
  if (!is.data.frame(data)) {
    stop("Input must be a data.frame")
  }

  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols) > 0) {
    stop(paste("Missing required columns:", paste(missing_cols, collapse = ", ")))
  }

  TRUE
}
