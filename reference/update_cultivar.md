# Title Update the cultivar parameters

This function assumes the file is apsimx format. A new Replacements node
is added if it is not exist. The existing cultivar parameters are
updated. New cultivar is created.

## Usage

``` r
update_cultivar(
  l,
  df,
  add = TRUE,
  use_folder = TRUE,
  cultivar_folder = "Cultivars"
)
```

## Arguments

- l:

  The list of apsimx file

- df:

  A data frame for new parameters with three columns, i.e. name,
  parameter and value.

- add:

  Whether to add extra nodes (e.g. replacements, Cultivars folder and
  new cultivar)

- use_folder:

  use cultivar folder to add new cultivars

- cultivar_folder:

  folder name for cultivars

## Value

The modified apsimx file

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
# Update cultivars
df <- data.frame(name = rep("Hartog", 3),
                 parameter = c("[Phenology].MinimumLeafNumber.FixedValue",
                              "[Phenology].VrnSensitivity.FixedValue",
                              "[Phenology].PpSensitivity.FixedValue"),
                value = c(9, 7, 3))

wheat_cultivar <- update_cultivar(wheat, df)
hartog <- search_path(wheat_cultivar, "[Replacements].Hartog")
hartog$path
#> NULL
```
