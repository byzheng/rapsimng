# Get the met file name for an experiment

Get the met file name for an experiment

## Usage

``` r
get_metfile(l, is_stop = TRUE)
```

## Arguments

- l:

  A list or apsimxNode red by read_apsimx

- is_stop:

  Whether stop the function when error

## Value

The met file name in a experiment

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
exp <- search_path(wheat, path = "[Experiment]")
get_metfile(exp)
#> [1] "example.met"
```
