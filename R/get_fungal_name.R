#' Get updated fungal name
#'
#' This function updates fungal names based on the species classification
#' and retrieves information from Index Fungorum. It only works for species.
#'
#' @param name A character vector containing the fungal names to update.
#' @param add_info A logical value indicating whether to return additional information
#'   about the species (default is FALSE) such as the synonyms and the taxonomic classification.
#' @return A character vector with updated names, or a tibble with additional information
#'   if add_info = TRUE.
#' @export
get_fungal_name <- function(name, add_info = FALSE) {

  name <- ifelse(is.na(name), NA, str_to_sentence(name))

  result <- purrr::map(name, ~ {

    if (is.na(.)) {
      return(NA)
    }

    name <- clean_names(.)
    classification <- classify_name(name)
    type <- classification$type
    base_name <- classification$name

    if (type != "sp.") {
      warning(paste("The function can only update names for taxa classified as species. The name", name, "is classified as", type, "and therefore no update will be made."))
      return(NA)
    }

    IF_data <- tryCatch({
      taxize::fg_name_search(base_name, limit = 6000) %>%
        filter(infraspecific_rank == type)
    }, error = function(e) {
      warning("Failed to query Index Fungorum: ", e$message)
      return(tibble())
    })

    if (nrow(IF_data) == 0) {
      warning(paste("No updates found for the species", base_name, "in Index Fungorum."))
      return(NA)
    }

    IF_data <- IF_data %>%
      dplyr::rename(id = dplyr::if_else(
        "current_name_record_number" %in% names(.),
        "current_name_record_number",
        "record_number"
      ))

    updated_id <- get_updated_id(IF_data, base_name)

    if (is.na(updated_id)) {
      warning(paste("No valid ID found for the species", base_name, "in Index Fungorum."))
      return(NA)
    }

    url_name  <- paste0("https://www.speciesfungorum.org/Names/SynSpecies.asp?RecordID=", updated_id)
    url_class <- paste0("https://www.indexfungorum.org/names/NamesRecord.asp?RecordID=", updated_id)

    result <- tryCatch({
      web_name <- rvest::read_html(url_name) %>%
        rvest::html_nodes("p") %>%
        rvest::html_text()

      tax_class <- extract_classification(url_class)

      if (!str_detect(web_name[1], "Click on")) {
        current_name <- web_name[1] %>%
          str_remove("Current Name:") %>%
          str_remove("\\,.+") %>%
          str_remove("\\s\\[.+\\]")

        if (!add_info) {
          return(clean_names(current_name))
        }

        synonyms <- web_name[2] %>%
          str_remove("Synonymy:") %>%
          str_remove_all("\\s\\[\\d+\\]") %>%
          str_split(" \\(\\d+\\)") %>%
          unlist() %>%
          clean_names() %>%
          str_extract(".+") %>%
          unique() %>%
          na.omit()

        return(build_info(current_name = current_name, id = updated_id, synonyms = synonyms, classification = tax_class))
      } else {
        return(base_name)
      }
    }, error = function(e) {
      warning("Error processing web page: ", e$message)
      return(NA)
    })

    return(result)
  })

  if (!add_info) {
    return(unlist(result))
  }

  return(result)
}
