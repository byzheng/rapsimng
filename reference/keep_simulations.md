# Keep simulations for a factorial experiment

Keep simulations for a factorial experiment

## Usage

``` r
keep_simulations(l, s)
```

## Arguments

- l:

  A list from read_apsim with Factorial.Permutation as root.

- s:

  a list with factor as name and levels as value to keep. The factor is
  kept if it is not specified.

## Value

A new list with removed simulations.

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
permutation <- search_path(wheat, path = "[Factors].Permutation")
permutation_new <- keep_simulations(permutation$node, list(V = "2"))
get_simulations(permutation_new)
#> $V
#> [1] "2"
#> 
#> $Cv
#> [1] "Axe"       "Bolac"     "Calingiri"
#> 
#> $N
#> [1] "0"   "200"
#> 

permutation_new <- keep_simulations(permutation$node, list(Cv = c("Axe", "Bolac")))
get_simulations(permutation_new)
#> $V
#> [1] "1" "2"
#> 
#> $Cv
#> [1] "Axe"   "Bolac"
#> 
#> $N
#> [1] "0"   "200"
#> 

permutation_new <- keep_simulations(permutation$node,
                                    list(V = "1", Cv = c("Axe", "Bolac")))
get_simulations(permutation_new)
#> $V
#> [1] "1"
#> 
#> $Cv
#> [1] "Axe"   "Bolac"
#> 
#> $N
#> [1] "0"   "200"
#> 
```
