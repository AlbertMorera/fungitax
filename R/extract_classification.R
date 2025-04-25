#' Extract Classification Information from a URL
#'
#' This function extracts the classification details (family, order, class, etc.) of a fungus
#' from the provided URL by parsing the HTML content. It specifically looks for the position
#' in the classification hierarchy.
#'
#' @param url A character string representing the URL of the fungal record.
#' @return A character vector containing the classification levels, or NA if an error occurs.
extract_classification <- function(url) {
  tryCatch({
    rvest::read_html(url) %>%
      rvest::html_nodes("p") %>%
      rvest::html_text() %>%
      str_subset("Position in") %>%
      str_remove("Position in classification: ") %>%
      str_split(", ") %>%
      unlist()
  }, error = function(e) NA)
}
