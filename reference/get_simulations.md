# Get simulations for a factorial experiment

Get simulations for a factorial experiment

## Usage

``` r
get_simulations(l)
```

## Arguments

- l:

  A list from read_apsim with Factorial.Permutation as root.

## Value

A list with Factor as name and Levels as values

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
permutation <- search_path(wheat, path = "[Factors].Permutation")
get_simulations(permutation$node)
#> $V
#> [1] "1" "2"
#> 
#> $Cv
#> [1] "Axe"       "Bolac"     "Calingiri"
#> 
#> $N
#> [1] "0"   "200"
#> 
```
