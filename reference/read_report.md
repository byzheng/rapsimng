# Read apsimx database in db file format

Read apsimx database in db file format

## Usage

``` r
read_report(file, report)
```

## Arguments

- file:

  the file path to apsimx or db file

- report:

  the report name

## Value

a data.frame for a report

## Examples

``` r
if (FALSE) { # \dontrun{
file <- system.file("extdata/wheat.apsimx", package = "rapsimng")
read_report(file, "HarvestReport")
} # }
```
