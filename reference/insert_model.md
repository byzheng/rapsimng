# Insert a model into apsimx

Insert a model into apsimx

## Usage

``` r
insert_model(l, path, model)
```

## Arguments

- l:

  the list of apsimx file

- path:

  If numeric, the path returned by search_path or search_node. If
  character, the path supported by apsimx

- model:

  A new model

## Value

The modified list with new value

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
replacements <- new_model("Core.Replacements")
wheat_new <- insert_model(wheat, 1, replacements)
replacements_node <- search_path(wheat_new, ".Simulations.Replacements")
replacements_node$path
#> [1] 1 3
# Add a cultivar folder under replacements
cultivar_folder <- new_model("PMF.CultivarFolder", "Cultivars")
wheat_new <- insert_model(wheat_new, replacements_node$path, cultivar_folder)
cultivar_folder_node <- search_path(wheat_new,
                                    ".Simulations.Replacements.Cultivars")
cultivar_folder_node$path
#> [1] 1 3 1
# Add an new cultivar
cultivar <- new_model("PMF.Cultivar", "Hartog")
wheat_new <- insert_model(wheat_new, cultivar_folder_node$path, cultivar)
cultivar_node <- search_path(wheat_new,
                             ".Simulations.Replacements.Cultivars.Hartog")
cultivar_node$path
#> [1] 1 3 1 1
```
