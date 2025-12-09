# Split an APSIMX file into separate simulations except cultivar

This function takes an APSIMX file and splits it into separate
simulations for all factors except cultivar factors. Then saving the
results to the specified output location.

## Usage

``` r
split_apsimx(file, output)
```

## Arguments

- file:

  Character. Path to the input APSIMX file.

- output:

  Character. Path to the directory where the split components will be
  saved.

## Value

No return value. The function is called for its side effects.

## Examples

``` r
if (FALSE) { # \dontrun{
split_apsimx("path/to/input.apsimx", "path/to/output/directory")
} # }
```
