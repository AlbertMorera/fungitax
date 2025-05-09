% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_fungal_name.R
\name{get_fungal_name}
\alias{get_fungal_name}
\title{Get updated fungal name}
\usage{
get_fungal_name(name, add_info = FALSE)
}
\arguments{
\item{name}{A character vector containing the fungal names to update.}

\item{add_info}{A logical value indicating whether to return additional information
about the species (default is FALSE) such as the synonyms and the taxonomic classification.}
}
\value{
A character vector with updated names, or a tibble with additional information
if add_info = TRUE.
}
\description{
This function updates fungal names based on the species classification
and retrieves information from Index Fungorum. It only works for species.
}
