# Get the parent node from a path

Get the parent node from a path

## Usage

``` r
get_parent(l, path)
```

## Arguments

- l:

  the list of apsimx file

- path:

  If numeric, the path returned by search_path or search_node. If
  character, the path supported by apsimx

## Value

A new list for parent

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
a <- search_path(wheat, '[Structure].BranchingRate')
get_parent(wheat, a$path)
#> $node
#> $node$`$type`
#> [1] "Models.PMF.Struct.Structure, Models"
#> 
#> $node$CohortInitialisationStage
#> [1] "Germination"
#> 
#> $node$LeafInitialisationStage
#> [1] "Emergence"
#> 
#> $node$Name
#> [1] "Structure"
#> 
#> $node$Children
#> $node$Children[[1]]
#> $node$Children[[1]]$`$type`
#> [1] "Models.Functions.MultiplyFunction, Models"
#> 
#> $node$Children[[1]]$Name
#> [1] "BranchingRate"
#> 
#> $node$Children[[1]]$Children
#> $node$Children[[1]]$Children[[1]]
#> $node$Children[[1]]$Children[[1]]$`$type`
#> [1] "Models.Functions.PhaseLookup, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Name
#> [1] "PotentialBranchingRate"
#> 
#> $node$Children[[1]]$Children[[1]]$Children
#> $node$Children[[1]]$Children[[1]]$Children[[1]]
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$`$type`
#> [1] "Models.Functions.PhaseLookupValue, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Start
#> [1] "Emergence"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$End
#> [1] "TerminalSpikelet"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Name
#> [1] "Vegetative"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$`$type`
#> [1] "Models.Functions.LinearInterpolationFunction, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Name
#> [1] "PotentialBranchingRate"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$`$type`
#> [1] "Models.Functions.XYPairs, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$X
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$X[[1]]
#> [1] 1
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$X[[2]]
#> [1] 2
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$X[[3]]
#> [1] 3
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$X[[4]]
#> [1] 4
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$X[[5]]
#> [1] 5
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$X[[6]]
#> [1] 6
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$X[[7]]
#> [1] 7
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$X[[8]]
#> [1] 8
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Y
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Y[[1]]
#> [1] 0
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Y[[2]]
#> [1] 0
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Y[[3]]
#> [1] 1
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Y[[4]]
#> [1] 2
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Y[[5]]
#> [1] 5
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Y[[6]]
#> [1] 7
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Y[[7]]
#> [1] 15
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Y[[8]]
#> [1] 23
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Name
#> [1] "XYPairs"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children
#> list()
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$`$type`
#> [1] "Models.Functions.VariableReference, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$VariableName
#> [1] "[Structure].LeafTipsAppeared"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$Name
#> [1] "XValue"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$Children
#> list()
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$`$type`
#> [1] "Models.Functions.PhaseLookupValue, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Start
#> [1] "TerminalSpikelet"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$End
#> [1] "HarvestRipe"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Name
#> [1] "Reproductive"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Children
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Children[[1]]
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Children[[1]]$`$type`
#> [1] "Models.Functions.Constant, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Children[[1]]$FixedValue
#> [1] 0
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Children[[1]]$Units
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Children[[1]]$Name
#> [1] "Zero"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Children[[1]]$Children
#> list()
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Children[[1]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[1]]$Children[[2]]
#> $node$Children[[1]]$Children[[2]]$`$type`
#> [1] "Models.Functions.MinimumFunction, Models"
#> 
#> $node$Children[[1]]$Children[[2]]$Name
#> [1] "StressFactors"
#> 
#> $node$Children[[1]]$Children[[2]]$Children
#> $node$Children[[1]]$Children[[2]]$Children[[1]]
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$`$type`
#> [1] "Models.Functions.LinearInterpolationFunction, Models"
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Name
#> [1] "CoverEffect"
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$`$type`
#> [1] "Models.Functions.XYPairs, Models"
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$X
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$X[[1]]
#> [1] 0
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$X[[2]]
#> [1] 0.1
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$X[[3]]
#> [1] 0.3
#> 
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$Y
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$Y[[1]]
#> [1] 1
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$Y[[2]]
#> [1] 1
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$Y[[3]]
#> [1] 0
#> 
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$Name
#> [1] "XYPairs"
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$Children
#> list()
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[2]]
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[2]]$`$type`
#> [1] "Models.Functions.VariableReference, Models"
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[2]]$VariableName
#> [1] "[Leaf].CoverTotal"
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[2]]$Name
#> [1] "XValue"
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[2]]$Children
#> list()
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[2]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[2]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[1]]$Children[[2]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[1]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]
#> $node$Children[[2]]$`$type`
#> [1] "Models.PMF.Struct.HeightFunction, Models"
#> 
#> $node$Children[[2]]$Name
#> [1] "HeightModel"
#> 
#> $node$Children[[2]]$Children
#> $node$Children[[2]]$Children[[1]]
#> $node$Children[[2]]$Children[[1]]$`$type`
#> [1] "Models.Functions.LinearInterpolationFunction, Models"
#> 
#> $node$Children[[2]]$Children[[1]]$Name
#> [1] "PotentialHeight"
#> 
#> $node$Children[[2]]$Children[[1]]$Children
#> $node$Children[[2]]$Children[[1]]$Children[[1]]
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$`$type`
#> [1] "Models.Functions.XYPairs, Models"
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$X
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$X[[1]]
#> [1] 3
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$X[[2]]
#> [1] 4
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$X[[3]]
#> [1] 5
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$X[[4]]
#> [1] 6
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$X[[5]]
#> [1] 7
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$X[[6]]
#> [1] 8
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$X[[7]]
#> [1] 9
#> 
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$Y
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$Y[[1]]
#> [1] 10
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$Y[[2]]
#> [1] 200
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$Y[[3]]
#> [1] 200
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$Y[[4]]
#> [1] 1000
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$Y[[5]]
#> [1] 1000
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$Y[[6]]
#> [1] 1000
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$Y[[7]]
#> [1] 1000
#> 
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$Name
#> [1] "XYPairs"
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[2]]
#> $node$Children[[2]]$Children[[1]]$Children[[2]]$`$type`
#> [1] "Models.Functions.VariableReference, Models"
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[2]]$VariableName
#> [1] "[Phenology].Stage"
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[2]]$Name
#> [1] "XValue"
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[2]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[2]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[1]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[2]]$Children[[1]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[2]]
#> $node$Children[[2]]$Children[[2]]$`$type`
#> [1] "Models.Functions.LinearInterpolationFunction, Models"
#> 
#> $node$Children[[2]]$Children[[2]]$Name
#> [1] "WaterStress"
#> 
#> $node$Children[[2]]$Children[[2]]$Children
#> $node$Children[[2]]$Children[[2]]$Children[[1]]
#> $node$Children[[2]]$Children[[2]]$Children[[1]]$`$type`
#> [1] "Models.Functions.XYPairs, Models"
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[1]]$X
#> $node$Children[[2]]$Children[[2]]$Children[[1]]$X[[1]]
#> [1] 0.3
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[1]]$X[[2]]
#> [1] 1
#> 
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[1]]$Y
#> $node$Children[[2]]$Children[[2]]$Children[[1]]$Y[[1]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[1]]$Y[[2]]
#> [1] 1
#> 
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[1]]$Name
#> [1] "XYPairs"
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[1]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[1]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[2]]
#> $node$Children[[2]]$Children[[2]]$Children[[2]]$`$type`
#> [1] "Models.Functions.VariableReference, Models"
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[2]]$VariableName
#> [1] "[Leaf].Fw"
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[2]]$Name
#> [1] "XValue"
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[2]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[2]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[2]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[2]]$Children[[2]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[2]]$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$IncludeInDocumentation
#> [1] TRUE
#> 
#> $node$Enabled
#> [1] TRUE
#> 
#> $node$ReadOnly
#> [1] FALSE
#> 
#> 
#> $path
#> [1] 1 1 4
#> 
```
