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
#> $Command
#> list()
#> 
#> $Name
#> [1] "Cultivar"
#> 
#> $ResourceName
#> NULL
#> 
#> $Children
#> list()
#> 
#> $Enabled
#> [1] TRUE
#> 
#> $ReadOnly
#> [1] TRUE
#> 
new_model(model = "PMF.Cultivar", name = "example")
#> $`$type`
#> [1] "Models.PMF.Cultivar, Models"
#> 
#> $Command
#> list()
#> 
#> $Name
#> [1] "example"
#> 
#> $ResourceName
#> NULL
#> 
#> $Children
#> list()
#> 
#> $Enabled
#> [1] TRUE
#> 
#> $ReadOnly
#> [1] TRUE
#> 
```
