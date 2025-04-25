#' Build a Tibble with Updated Fungal Information
#'
#' This function constructs a tibble containing detailed information about a fungal species,
#' including the current name, ID, synonyms, and classification details (family, order, etc.).
#'
#' @param current_name A character string representing the current name of the fungus.
#' @param id A character string representing the ID of the fungus.
#' @param synonyms A list of character strings representing the synonyms of the fungus.
#' @param classification A character vector representing the classification of the fungus (family, order, subclass, etc.).
#' @return A tibble with columns for the current name, ID, synonyms, and classification details.
build_info <- function(current_name, id, synonyms, classification){
  tibble(
    fungi_name = clean_names(current_name),
    fungi_name_current = current_name,
    fungi_id = id,
    synonyms = list(synonyms),
    family = classification[1],
    order = classification[2],
    subclass = classification[3],
    class = classification[4],
    subdivision = classification[5],
    division = classification[6],
    kingdom = classification[7]
  )
}
