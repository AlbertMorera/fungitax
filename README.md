# fungitax: An R package for updating and resolving fungal names based on Index Fungorum




## Description
The **fungitax** package provides functions to update scientific names of fungi based on the data available from Index Fungorum. It allows users to get the most current name of a fungus species by querying this online database.

## Installation

You can install the latest version of **fungitax** from GitHub using the `remotes` package:

```r
remotes::install_github("AlbertMorera/fungitax")
```

### **Basic usage:**
The main function of `fungitax` is `get_fungal_name()`. In this version, the function is a bit slow, so I recommend not making a very long query or splitting the problem to get an idea of where it is at. Updating 500 scientific names takes 15' on my computer.
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
If the name is misspelled or only the genus is provided, the function will return `NA`. The package is case-insensitive, so both uppercase and lowercase inputs are accepted.
```{r}
species_2 <- c("Amanita delicios", "LACTARIUS VINOSUS", NA, "Paxillus", "Gaestrum")
get_fungal_name(species_2)
```

#### - *Handling incorrect names or genera*
You can also work with data.frame or tibbles:
```{r}
tibble(species = species) %>%
  mutate(new.name = get_fungal_name(species))
```

#### - *Extracting information from the result*
If you request additional information with `add_info = TRUE`, the result will be a list. You can extract the information with `tidyr::unnest()`.
```{r}
tibble(species = species) %>%
  mutate(new.name = get_fungal_name(species, add_info = TRUE)) %>%
  unnest(new.name)
```

For long queries, it's useful to know the progress of the process. Here's a simple example using a loop:
```{r}
new.names <- c()

for(sp in species) {
  new.sp.name <- get_fungal_name(sp)
  new.names <- c(new.names, new.sp.name)
  cat(match(sp, species), "of", length(species), "done.\n")
}
```



## Cite this package
Morera, A. (2025). fungitax: An R package for updating and resolving fungal names based on Index Fungorum. GitHub repository URL. https://github.com/AlbertMorera/fungitax
