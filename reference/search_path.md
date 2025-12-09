# Find a model in the apsimx file using specified path

Find a model in the apsimx file using specified path

## Usage

``` r
search_path(l, path, case_insensitive = TRUE)
```

## Arguments

- l:

  the list of apsimx file

- path:

  The specified path (See details)

- case_insensitive:

  Whether case sensitive

## Value

The list for the specified path.

## Absolute Paths

Absolute paths have a leading ‘.’ e.g.

- .Simulations.Test.Clock - absolute path - refers to the clock model in
  the 'Test' simulation.

## Scoped Paths

Scoped paths have a leading model type in square brackets. A model of
the specified name, in scope, is located before applying the rest of the
path.

- \[Soil\].Water - scoped path - refers to the Water model that is a
  child of a model that has the name 'Soil' that is in scope

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
# Return empty list if not found
search_path(wheat, "[Simulations1]")
#> list()
# Search root path
a <- search_path(wheat, '.Simulations')
a$path
#> [1] 1
a$node$Name
#> [1] "Simulations"
# Level one
a <- search_path(wheat, '.Simulations.Wheat1')
a$path
#> NULL
a$node$Name
#> NULL
# Level two
a <- search_path(wheat, '.Simulations.Wheat')
a$path
#> [1] 1 1
a$node$Name
#> [1] "Wheat"
# Level three
a <- search_path(wheat, '.Simulations.Wheat.BranchingRate')
a$path
#> NULL
a$node$Name
#> NULL
a <- search_path(wheat, '.Simulations.Wheat.Structure')
a$path
#> [1] 1 1 4
a$node$Name
#> [1] "Structure"
# Level four
a <- search_path(wheat, '.Simulations.Wheat.Structure.BranchingRate')
a$path
#> [1] 1 1 4 1
a$node$Name
#> [1] "BranchingRate"
a <- search_path(wheat, '.Simulations.Wheat.Structure.BranchingRate1')
a$path
#> NULL
a$node$Name
#> NULL
# scoped
# Root path
a <- search_path(wheat, '[Simulations1]')
a <- search_path(wheat, '[Simulations]')
a$path
#> [1] 1
a$node$Name
#> [1] "Simulations"
# Level two
a <- search_path(wheat, '[Simulations].Wheat1')
a <- search_path(wheat, '[Simulations1].Wheat')
a$path
#> NULL
a$node$Name
#> NULL
a <- search_path(wheat, '[Whea]')
a <- search_path(wheat, '[Wheat]')
a$path
#> [1] 1 1
a$node$Name
#> [1] "Wheat"
# Level three
a <- search_path(wheat, '[Wheat].BranchingRate')
a <- search_path(wheat, '[Wheat].Structure')
a$path
#> [1] 1 1 4
a$node$Name
#> [1] "Structure"
a <- search_path(wheat, '[Structure]')
a$path
#> [1] 1 1 4
a$node$Name
#> [1] "Structure"
# Level four
a <- search_path(wheat, '[Structure].BranchingRate')
a$path
#> [1] 1 1 4 1
a$node$Name
#> [1] "BranchingRate"
a <- search_path(wheat, '[Structure].BranchingRate1')
a <- search_path(wheat, '[Structure1].BranchingRate')
```
