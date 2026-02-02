# Bibliometric Index Calculations
# Vectorized implementations for better performance

#' Calculate H-index (Hirsch index)
#'
#' H-index is defined as: a researcher has h papers with at least h citations each.
#' This is a vectorized implementation of J.E. Hirsch's original definition.
#'
#' @param citations Vector of citation counts (unsorted is fine)
#' @return Integer h-index value
#'
#' @examples
#' h_index(c(10, 8, 5, 4, 3))  # Returns 4
#' h_index(c(100, 50, 20, 10, 5, 1, 0))  # Returns 5
h_index <- function(citations) {
  if (length(citations) == 0) return(0)

  # Sort in descending order
  sorted_citations <- sort(citations, decreasing = TRUE)
  n <- length(sorted_citations)

  # Vectorized: find largest h where citations[h] >= h
  h_values <- seq_len(n)
  valid_h <- sorted_citations >= h_values

  if (any(valid_h)) {
    max(which(valid_h))
  } else {
    0
  }
}

#' Calculate G-index
#'
#' G-index is defined as: the largest number g such that the top g papers
#' have together at least g^2 citations.
#'
#' @param citations Vector of citation counts
#' @return Integer g-index value
#'
#' @examples
#' g_index(c(10, 8, 5, 4, 3))  # Returns 5
g_index <- function(citations) {
  if (length(citations) == 0) return(0)

  sorted_citations <- sort(citations, decreasing = TRUE)
  n <- length(sorted_citations)

  # Cumulative sum of citations

cumsum_citations <- cumsum(sorted_citations)

  # Find largest g where cumsum >= g^2
  g_values <- seq_len(n)
  valid_g <- cumsum_citations >= g_values^2

  if (any(valid_g)) {
    max(which(valid_g))
  } else {
    # Pseudo g-index: floor of sqrt of total citations
    floor(sqrt(sum(citations)))
  }
}

#' Calculate R-index
#'
#' R-index is defined as: the square root of the sum of citations
#' of the top h papers (where h is the h-index).
#'
#' @param citations Vector of citation counts
#' @return Numeric r-index value
#'
#' @examples
#' r_index(c(10, 8, 5, 4, 3))  # Returns sqrt(10+8+5+4) = 5.196
r_index <- function(citations) {
  if (length(citations) == 0) return(0)

  h <- h_index(citations)
  if (h == 0) return(0)

  sorted_citations <- sort(citations, decreasing = TRUE)
  sqrt(sum(sorted_citations[1:h]))
}

#' Calculate i10-index
#'
#' i10-index is defined as: the number of papers with at least 10 citations.
#' This is used by Google Scholar.
#'
#' @param citations Vector of citation counts
#' @return Integer i10-index value
#'
#' @examples
#' i10_index(c(100, 50, 20, 10, 5, 1))  # Returns 4
i10_index <- function(citations) {
  sum(citations >= 10)
}

#' Calculate m-quotient
#'
#' m-quotient is defined as: h-index divided by years since first publication.
#' It normalizes h-index by academic age.
#'
#' @param citations Vector of citation counts
#' @param years_active Number of years since first publication
#' @return Numeric m-quotient value
m_quotient <- function(citations, years_active) {
  if (years_active <= 0) return(0)
  h_index(citations) / years_active
}

#' Calculate hg-index
#'
#' hg-index is the geometric mean of h-index and g-index.
#'
#' @param citations Vector of citation counts
#' @return Numeric hg-index value
hg_index <- function(citations) {
  h <- h_index(citations)
  g <- g_index(citations)
  sqrt(h * g)
}

#' Calculate all indices at once
#'
#' Convenience function to calculate all bibliometric indices.
#'
#' @param citations Vector of citation counts
#' @param years_active Number of years since first publication (optional)
#' @return Named list of all index values
#'
#' @examples
#' all_indices(c(100, 50, 20, 10, 5, 1), years_active = 10)
all_indices <- function(citations, years_active = NULL) {
  h <- h_index(citations)
  g <- g_index(citations)

  result <- list(
    h_index = h,
    g_index = g,
    r_index = r_index(citations),
    i10_index = i10_index(citations),
    hg_index = sqrt(h * g),
    total_citations = sum(citations),
    total_papers = length(citations),
    avg_citations = mean(citations)
  )

  if (!is.null(years_active) && years_active > 0) {
    result$m_quotient <- h / years_active
    result$years_active <- years_active
  }

  result
}

#' Calculate random h-index (experimental)
#'
#' Randomly shuffles papers and calculates a "positional h-index" n times.
#' Returns the max, min, and average of these random h-indices.
#' This is an experimental metric exploring the sensitivity of h-index to paper ordering.
#'
#' @param citations Vector of citation counts
#' @param n_iterations Number of random shuffles (default: length of citations)
#' @return Named vector with max, min, and average random h-index
random_h_index <- function(citations, n_iterations = NULL) {
  if (length(citations) == 0) return(c(maximum = 0, minimum = 0, average = 0))

  if (is.null(n_iterations)) {
    n_iterations <- length(citations)
  }

  # Positional h-index: count papers where citation >= position
  positional_h <- function(cites) {
    sum(cites >= seq_along(cites))
  }

  # Run n random permutations
  random_h_values <- replicate(n_iterations, {
    positional_h(sample(citations))
  })

  c(
    maximum = max(random_h_values),
    minimum = min(random_h_values),
    average = round(mean(random_h_values))
  )
}
