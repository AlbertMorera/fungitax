#' Get the Most Recent ID of a Fungal Record
#'
#' This function extracts the most recent ID for a given fungal species from a dataframe,
#' sorting the records by the update date and returning the ID of the most recent entry.
#'
#' @param df A tibble or dataframe containing fungal records.
#' @param name A character string representing the fungal species name.
#' @return A character string representing the ID of the most recently updated record.
get_updated_id <- function(df, name) {
  df %>%
    filter(name_of_fungus == name) %>%
    mutate(updateddate = as.Date(updateddate)) %>%
    arrange(desc(updateddate)) %>%
    drop_na(id) %>%
    pull(id) %>%
    .[1]
}
