# Find element(s) in apsimx file

Find element(s) in apsimx file

## Usage

``` r
search_node(l, all = FALSE, max_depth = 1e+06, case_insensitive = TRUE, ...)
```

## Arguments

- l:

  The list of apsimx file

- all:

  Whether to find all elements

- max_depth:

  The maximum depth to search

- case_insensitive:

  Whether case sensitive

- ...:

  Other names arguments for property to match

## Value

A list matching all criteria if all equals to TRUE, A list with node and
path if all equals to FALSE (default)

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
# Return empty list if not found
search_node(wheat, Name = "Simulations1")
#> list()
# Find root level
a <- search_node(wheat, Name = "Simulations")
a$path
#> [1] 1
# Find sub-level
a <- search_node(wheat, Name = "Wheat")
a$path
#> [1] 1 1
a <- search_node(wheat, `$type` = "Models.PMF.Cultivar, Models")
a$path
#> [1] 1 1 5 1

# Find multiple attributes
a <- search_node(wheat,
            Name = 'PotentialBranchingRate',
            `$type` = "Models.Functions.PhaseLookup, Models")
a$path
#> [1] 1 1 4 1 1
a$node$Name
#> [1] "PotentialBranchingRate"
# Find all cultivar nodes
 a <- search_node(wheat, `$type` = "Models.PMF.Cultivar, Models", all = TRUE)
length(a)
#> [1] 5
```
