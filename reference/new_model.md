# Create a new model

Create a new model

## Usage

``` r
new_model(model, name = model)
```

## Arguments

- model:

  The name of new model

- name:

  The new name

## Examples

``` r
new_model(model = "PMF.Cultivar")
#> $`$type`
#> [1] "Models.PMF.Cultivar, Models"
#> 
#> $Name
#> [1] "Cultivar"
#> 
#> $Children
#> list()
#> 
#> $IncludeInDocumentation
#> [1] TRUE
#> 
#> $Enabled
#> [1] TRUE
#> 
#> $ReadOnly
#> [1] FALSE
#> 
#> $Alias
#> list()
#> 
#> $Command
#> list()
#> 
new_model(model = "PMF.Cultivar", name = "example")
#> $`$type`
#> [1] "Models.PMF.Cultivar, Models"
#> 
#> $Name
#> [1] "example"
#> 
#> $Children
#> list()
#> 
#> $IncludeInDocumentation
#> [1] TRUE
#> 
#> $Enabled
#> [1] TRUE
#> 
#> $ReadOnly
#> [1] FALSE
#> 
#> $Alias
#> list()
#> 
#> $Command
#> list()
#> 
```
