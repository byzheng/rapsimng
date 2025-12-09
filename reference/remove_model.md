# Remove a model with new values

Remove a model with new values

## Usage

``` r
remove_model(l, path)
```

## Arguments

- l:

  the list of apsimx file

- path:

  If numeric, the path returned by search_path or search_node. If
  character, the path supported by apsimx

## Value

The modified list with new value

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
a <- search_path(wheat, '[Wheat].Phenology.ThermalTime')
wheat_new <- remove_model(wheat, a$path)
b <- search_path(wheat_new, '[Wheat].Phenology.ThermalTime')
b
#> list()
```
