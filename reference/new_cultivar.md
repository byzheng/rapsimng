# Generate new cultivars with parameter which can be used in Replacements

Generate new cultivars with parameter which can be used in Replacements

## Usage

``` r
new_cultivar(df, cultivar_folder = "Cultivars")
```

## Arguments

- df:

  A data frame for new parameters with three columns, i.e. name,
  parameter and value.

- cultivar_folder:

  folder name for cultivars

## Value

An APSIMX list

## Examples

``` r
df <- data.frame(name = c("C1", "C1", "C2", "C2"),
     parameter = c("[Phenology].CAMP.FLNparams.MinLN",
              "[Phenology].CAMP.FLNparams.VrnLN",
              "[Phenology].CAMP.FLNparams.MinLN",
              "[Phenology].CAMP.FLNparams.VrnLN"),
     value = c(5, 6, 7, 8))
a <- new_cultivar(df)
```
