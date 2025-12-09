# Replace a model with new values

Replace a model with new values

## Usage

``` r
replace_model(l, path, model)
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
wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))

a <- search_path(wheat, '[Wheat].Phenology.ThermalTime')
a$node$Children[[1]]$X[[2]] <- 27
wheat_new <- replace_model(wheat, a$path, a$node)
b <- search_path(wheat_new, '[Wheat].Phenology.ThermalTime')
b$node$Children[[1]]$X
#> [[1]]
#> [1] 0
#> 
#> [[2]]
#> [1] 27
#> 
#> [[3]]
#> [1] 37
#> 
```
