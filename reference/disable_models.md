# Disable models in apsimx

Disable models in apsimx

## Usage

``` r
disable_models(l, paths)
```

## Arguments

- l:

  the list of apsimx file

- paths:

  If numeric, the path returned by search_path or search_node. If
  character, the path supported by apsimx

## Value

The modified list with new value

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
a <- disable_models(wheat, '[Wheat].Phenology.ThermalTime')
```
