#' Clean and Format Fungal Names
#'
#' This function takes a fungal name and applies basic cleaning and formatting to it,
#' including extracting the genus and species (or genus-species combination) and removing unnecessary parts.
#'
#' @param x A character string representing the fungal name to be cleaned.
#' @return A character string representing the cleaned fungal name.
clean_names <- function(x){
  case_when(
    str_detect(x, " sp\\.") | !str_detect(str_remove(x, "\\w+ "), "^[a-z]") ~ str_extract(x, "\\w+"),
    str_starts(x, "\\w+\\s\\w+\\-") ~ str_extract(x, "\\w+ \\w+\\-\\w+"),
    TRUE ~ str_extract(x, "\\w+ \\w+")
  )
}
