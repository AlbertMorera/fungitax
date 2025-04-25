# **fungitax**: A R package for fungal taxonomy updates

## Description
The **fungitax** package provides functions to update scientific names of fungi based on the data available from Index Fungorum. It allows users to get the most current name of a fungus species by querying this online database.

## Installation

You can install the latest version of **fungitax** from GitHub using the `remotes` package:

```r
remotes::install_github("AlbertMorera/fungitax")
```

### **Basic usage:**
The main function of fungitax is get_fungal_name()
#### - *Update fungal names*
If you provide a vector of fungal species names, the function will return their updated names if an update exists.
```{r}
species <- c("Amanita deliciosa", "Lactarius vinosus", "Geastrum triplex")
get_fungal_name(species)
```

#### - *Retrieve additional taxonomic information*
You can also get additional information such as taxonomic classification, the Index Fungorum ID, synonyms, etc. by setting the add_info parameter to `TRUE`.
```{r}
get_fungal_name(species, add_info = TRUE)
```

#### - *Handling incorrect names or genera*
If the name is misspelled or only the genus is provided, the function will return NA. The package is case-insensitive, so both uppercase and lowercase inputs are accepted.
```{r}
species_2 <- c("Amanita delicios", "LACTARIUS VINOSUS", NA, "Paxillus", "Gaestrum")
get_fungal_name(species_2)
```

#### - *Handling incorrect names or genera*
You can also work with data.frame or tibbles:
```{r}
tibble(species = species) %>%
  mutate(new.name = get_fungal)
```

#### - *Extracting information from the result*
If you request additional information with `add_info = TRUE`, the result will be a list. You can extract the information with `tidyr::unnest()`.
```{r}
tibble(species = species) %>%
  mutate(new.name = get_fungal_name(species, add_info = TRUE)) %>%
  unnest(new.name)
```
