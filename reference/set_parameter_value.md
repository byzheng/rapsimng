# Set a parameter with a new value

Set a parameter with a new value

## Usage

``` r
set_parameter_value(l, parameter, value)
```

## Arguments

- l:

  the list of apsimx file

- parameter:

  the name of parameter with APSIM NG specification

- value:

  the new value

## Value

A list with replaced value

## Examples

``` r
 wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
 new_wheat <- set_parameter_value(wheat,
  "[Structure].BranchingRate.PotentialBranchingRate.Reproductive.Zero.FixedValue",
  1)
new_wheat2 <- search_path(new_wheat,
    "[Structure].BranchingRate.PotentialBranchingRate.Reproductive.Zero")
new_wheat2$node$FixedValue
#> [1] 1

new_wheat <- set_parameter_value(
    wheat,
    "[Structure].HeightModel.WaterStress.XYPairs.Y",
    "0.1,1.1")
new_wheat2 <- search_path(new_wheat,
    "[Structure].HeightModel.WaterStress.XYPairs")
new_wheat2$node$Y
#> [[1]]
#> [1] "0.1"
#> 
#> [[2]]
#> [1] "1.1"
#> 
```
