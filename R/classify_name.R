#' Classify a Fungal Name
#'
#' This function classifies a given fungal name into either a genus or species.
#' It returns the type (`gen.` for genus, `sp.` for species) and the base name.
#'
#' @param name A character string representing a fungal name.
#' @return A list with two elements:
#'   \itemize{
#'     \item `type`: A character string indicating the classification type ("gen." or "sp.").
#'     \item `name`: The base name of the fungus (either genus or species).
#'   }
classify_name <- function(name) {
  if (str_detect(name, "\\s+sp\\.?$") || str_count(name, "\\S+") == 1) {
    return(list(type = "gen.", name = str_extract(name, "\\w+")))
  } else {
    return(list(type = "sp.", name = name))
  }
}
