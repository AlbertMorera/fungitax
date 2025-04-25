# fungitax: A R package for fungal taxonomy updates

## Description
The **fungitax** package provides functions to update scientific names of fungi based on the data available from Index Fungorum. It allows users to get the most current name of a fungus species by querying this online database.

## Installation

You can install the latest version of **fungitax** from GitHub using the `remotes` package:

```r
remotes::install_github("AlbertMorera/fungitax")
```

### 1. **Basic usage: Update fungal names**
If you provide a vector of fungal species names, the function will return their updated names if an update exists.

```{r}
species <- c("Amanita deliciosa", "Lactarius vinosus", "Geastrum triplex")
get_fungal_name(species)
```
