# List all available models in APSIM NG

List all available models in APSIM NG

## Usage

``` r
available_models()
```

## Value

a character vector of available models

## Examples

``` r
a <- available_models()
a[1:10]
#>  [1] "AgPasture.AGPBiomass"                           
#>  [2] "AgPasture.BiomassAndN"                          
#>  [3] "AgPasture.BiomassAndNLayered"                   
#>  [4] "AgPasture.TissuesHelper"                        
#>  [5] "AgPasture.SimpleGrazing"                        
#>  [6] "AgPasture.SimpleGrazing.GrazingRotationTypeEnum"
#>  [7] "AgPasture.SimpleGrazing.UrineReturnType"        
#>  [8] "AgPasture.PastureSpecies"                       
#>  [9] "AgPasture.PastureSpecies.BiomassRemovedDelegate"
#> [10] "AgPasture.PastureSpecies.YesNoAnswer"           
```
