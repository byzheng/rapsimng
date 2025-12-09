# Read APSIMX file

Read APSIMX file

## Usage

``` r
read_apsimx(path)
```

## Arguments

- path:

  The file path or URL to apsimx file

## Value

A list object of apsimx file

## Examples

``` r
file <- system.file("extdata/wheat.apsimx", package = "rapsimng")
m <- read_apsimx(file)
```
