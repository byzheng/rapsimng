# Modify apsimx file

Several functions are designed to modify the apsimx file, including \*
`replace` an existing model \* `remove` an existing model \* `append` a
new model as sibling node \* `insert` a new model as child

## Read apsimx file

`read_apsimx` is used to read files with apsimx json format,
i.e. `*.apsimx` for simulations and `*.json` for model under resource.

``` r
library(rapsimng)
wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
#wheat <- read_apsimx("inst/Wheat.json")
```

## Modify existing model

The existing model can be `replaced` and `removed`. The example below
shows to update the critical thermal and then remove it.

``` r
# Find the ThermalTime model 
a <- search_path(wheat, '[Wheat].Phenology.ThermalTime')
a$node$Children[[1]]$X[[2]]
#> [1] 26
# Update the optimum temperature
a$node$Children[[1]]$X[[2]] <- 27
# Replace with new value
wheat_new <- replace_model(wheat, a$path, a$node)
b <- search_path(wheat_new, '[Wheat].Phenology.ThermalTime')
# The optimum temperature should be updated now
b$node$Children[[1]]$X[[2]]
#> [1] 27

# The ThermalTime model can also be removed
a <- search_path(wheat, '[Wheat].Phenology.ThermalTime')
wheat_new <- remove_model(wheat, a$path)
b <- search_path(wheat_new, '[Wheat].Phenology.ThermalTime')
# The ThermalTime model should not be found now (i.e. Empty list)
b
#> list()
```

## Create new model

Function `new_model` is used to generate the required elements for a new
model, e.g. createing a new cultivar `Hartog`

``` r
new_cultivar <- new_model("PMF.Cultivar", name = "Hartog")
new_cultivar
#> $`$type`
#> [1] "Models.PMF.Cultivar, Models"
#> 
#> $Name
#> [1] "Hartog"
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
```

Then the `Command` can be updated to specify new parameter values.

``` r
new_cultivar$Command <- list(
  "[Phenology].MinimumLeafNumber.FixedValue = 6",
  "[Phenology].VrnSensitivity.FixedValue = 0")
```

Finally the new cultivar can be inserted into apsimx file.

``` r
# Read the apsimx file
wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
# Create a new Replacements
replacements <- new_model("Core.Replacements")
# Insert the replacements into root folder
wheat_new <- insert_model(wheat, 1, replacements)
replacements_node <- search_path(wheat_new, ".Simulations.Replacements")
replacements_node$path
#> [1] 1 3

# Insert the new cultivar
wheat_new <- insert_model(wheat_new, replacements_node$path, new_cultivar)

# Check the new cultivar
cultivar_node <- search_path(wheat_new,
                                        ".Simulations.Replacements.Hartog")
cultivar_node$path
#> [1] 1 3 1
cultivar_node$node$Command
#> [[1]]
#> [1] "[Phenology].MinimumLeafNumber.FixedValue = 6"
#> 
#> [[2]]
#> [1] "[Phenology].VrnSensitivity.FixedValue = 0"
```

### Available models

A new model can be generated in R according to Models assemble in APSIM
Next Generation. The rapsimng package stores a copy of `Models.xml` from
APSIM Next Generation on `1st August, 2020`.  
The available models can be listed using function `available_models`.

``` r
head(data.frame(model = available_models()))
#>                                             model
#> 1                            AgPasture.AGPBiomass
#> 2                           AgPasture.BiomassAndN
#> 3                    AgPasture.BiomassAndNLayered
#> 4                         AgPasture.TissuesHelper
#> 5                         AgPasture.SimpleGrazing
#> 6 AgPasture.SimpleGrazing.GrazingRotationTypeEnum
```

## Update cultivar parameter values

Function `update_cultivar` is a short way to update parameter values for
cultivars.

``` r
wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
# Update cultivars
df <- data.frame(name = rep("Hartog", 3),
                  parameter = c("[Phenology].MinimumLeafNumber.FixedValue",
                               "[Phenology].VrnSensitivity.FixedValue",
                               "[Phenology].PpSensitivity.FixedValue"),
                 value = c(9, 7, 3))
wheat_cultivar <- update_cultivar(wheat, df)
# Check update cultivar paramters
hartog <- search_path(wheat_cultivar, "[Replacements].Hartog")
hartog$path
#> NULL
```
