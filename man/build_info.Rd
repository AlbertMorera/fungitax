% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/build_info.R
\name{build_info}
\alias{build_info}
\title{Build a Tibble with Updated Fungal Information}
\usage{
build_info(current_name, id, synonyms, classification)
}
\arguments{
\item{current_name}{A character string representing the current name of the fungus.}

\item{id}{A character string representing the ID of the fungus.}

\item{synonyms}{A list of character strings representing the synonyms of the fungus.}

\item{classification}{A character vector representing the classification of the fungus (family, order, subclass, etc.).}
}
\value{
A tibble with columns for the current name, ID, synonyms, and classification details.
}
\description{
This function constructs a tibble containing detailed information about a fungal species,
including the current name, ID, synonyms, and classification details (family, order, etc.).
}
