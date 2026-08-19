# Validate a thermaltime definition

Checks that a thermaltime specification is a named list containing both
`x` and `y` vectors and that the vectors have the same length.

## Usage

``` r
thermaltime_validator(value)
```

## Arguments

- value:

  A list with `x` and `y` components defining the thermaltime
  relationship.

## Value

This function returns `NULL` invisibly when the value is valid.
Otherwise it stops with an informative error.
