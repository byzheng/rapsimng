# Get an experiment node by name

Get an experiment node by name

## Usage

``` r
get_experiment(apsimx, experiment)
```

## Arguments

- apsimx:

  A parsed APSIMX model from \`read_apsimx()\`.

- experiment:

  A single experiment name to locate.

## Value

An \`apsimxNode\` object for the experiment.

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
exp <- search_path(wheat, path = "[Experiment]")
get_experiment(wheat, exp$node$Name)
#> $node
#> $node$`$type`
#> [1] "Models.Factorial.Experiment, Models"
#> 
#> $node$DisabledSimNames
#> NULL
#> 
#> $node$Name
#> [1] "Experiment"
#> 
#> $node$ResourceName
#> NULL
#> 
#> $node$Children
#> $node$Children[[1]]
#> $node$Children[[1]]$`$type`
#> [1] "Models.Factorial.Factors, Models"
#> 
#> $node$Children[[1]]$Name
#> [1] "Factors"
#> 
#> $node$Children[[1]]$ResourceName
#> NULL
#> 
#> $node$Children[[1]]$Children
#> $node$Children[[1]]$Children[[1]]
#> $node$Children[[1]]$Children[[1]]$`$type`
#> [1] "Models.Factorial.Permutation, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Name
#> [1] "Permutation"
#> 
#> $node$Children[[1]]$Children[[1]]$ResourceName
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children
#> $node$Children[[1]]$Children[[1]]$Children[[1]]
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$`$type`
#> [1] "Models.Factorial.Factor, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Specification
#> [1] ""
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Name
#> [1] "V"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$ResourceName
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$`$type`
#> [1] "Models.Factorial.CompositeFactor, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Specifications
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Specifications[[1]]
#> [1] "[Sowing].Script.SowDate = 19-Jun"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Specifications[[2]]
#> [1] "[Sowing].Script.EmergeDate = 23-Jun"
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Paths
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Values
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Name
#> [1] "1"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$ResourceName
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Children
#> list()
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$`$type`
#> [1] "Models.Factorial.CompositeFactor, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$Specifications
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$Specifications[[1]]
#> [1] "[Sowing].Script.SowDate = 24-Apr"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$Specifications[[2]]
#> [1] "[Sowing].Script.EmergeDate = 21-Jun"
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$Paths
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$Values
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$Name
#> [1] "2"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$ResourceName
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$Children
#> list()
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[1]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
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
#> [1] "Models.Factorial.Factor, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Specification
#> [1] "[Sowing].Script.CultivarName=Axe,Bolac,Calingiri"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Name
#> [1] "Cv"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$ResourceName
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Children
#> list()
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$`$type`
#> [1] "Models.Factorial.Factor, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Specification
#> [1] "[NSchedule]"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Name
#> [1] "N"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$ResourceName
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$`$type`
#> [1] "Models.Operations, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$OperationsList
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$OperationsList[[1]]
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$OperationsList[[1]]$`$type`
#> [1] "Models.Operation, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$OperationsList[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$OperationsList[[1]]$Date
#> [1] "1990-06-21"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$OperationsList[[1]]$Action
#> [1] "[Fertiliser].Apply(amount: 0, type: \"UreaN\");"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$OperationsList[[1]]$Line
#> [1] "1990-06-21 [Fertiliser].Apply(amount: 0, type: \"UreaN\");"
#> 
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$Name
#> [1] "0"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$ResourceName
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$Children
#> list()
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$`$type`
#> [1] "Models.Operations, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$OperationsList
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$OperationsList[[1]]
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$OperationsList[[1]]$`$type`
#> [1] "Models.Operation, Models"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$OperationsList[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$OperationsList[[1]]$Date
#> [1] "1990-06-21"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$OperationsList[[1]]$Action
#> [1] "[Fertiliser].Apply(amount: 200, type: \"UreaN\");"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$OperationsList[[1]]$Line
#> [1] "1990-06-21 [Fertiliser].Apply(amount: 200, type: \"UreaN\");"
#> 
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$Name
#> [1] "200"
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$ResourceName
#> NULL
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$Children
#> list()
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$Children[[3]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[1]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[1]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
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
#> [1] "Models.Core.Simulation, Models"
#> 
#> $node$Children[[2]]$Descriptors
#> NULL
#> 
#> $node$Children[[2]]$Name
#> [1] "Simulation"
#> 
#> $node$Children[[2]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children
#> $node$Children[[2]]$Children[[1]]
#> $node$Children[[2]]$Children[[1]]$`$type`
#> [1] "Models.Clock, Models"
#> 
#> $node$Children[[2]]$Children[[1]]$Start
#> [1] "1990-04-23T00:00:00"
#> 
#> $node$Children[[2]]$Children[[1]]$End
#> [1] "1991-04-15T00:00:00"
#> 
#> $node$Children[[2]]$Children[[1]]$Name
#> [1] "Clock"
#> 
#> $node$Children[[2]]$Children[[1]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[1]]$Children
#> list()
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
#> [1] "Models.Climate.Weather, Models"
#> 
#> $node$Children[[2]]$Children[[2]]$ConstantsFile
#> NULL
#> 
#> $node$Children[[2]]$Children[[2]]$FileName
#> [1] "example.met"
#> 
#> $node$Children[[2]]$Children[[2]]$ExcelWorkSheetName
#> [1] ""
#> 
#> $node$Children[[2]]$Children[[2]]$Name
#> [1] "Weather"
#> 
#> $node$Children[[2]]$Children[[2]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[2]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[3]]
#> $node$Children[[2]]$Children[[3]]$`$type`
#> [1] "Models.Summary, Models"
#> 
#> $node$Children[[2]]$Children[[3]]$Verbosity
#> [1] 100
#> 
#> $node$Children[[2]]$Children[[3]]$Name
#> [1] "SummaryFile"
#> 
#> $node$Children[[2]]$Children[[3]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[3]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[3]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[3]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[4]]
#> $node$Children[[2]]$Children[[4]]$`$type`
#> [1] "Models.Soils.Arbitrator.SoilArbitrator, Models"
#> 
#> $node$Children[[2]]$Children[[4]]$Name
#> [1] "SoilArbitrator"
#> 
#> $node$Children[[2]]$Children[[4]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[4]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[4]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[4]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]
#> $node$Children[[2]]$Children[[5]]$`$type`
#> [1] "Models.Core.Zone, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Area
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Slope
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$AspectAngle
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Altitude
#> [1] 50
#> 
#> $node$Children[[2]]$Children[[5]]$CanopyType
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Name
#> [1] "Field"
#> 
#> $node$Children[[2]]$Children[[5]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children
#> $node$Children[[2]]$Children[[5]]$Children[[1]]
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$`$type`
#> [1] "Models.Report, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$VariableNames
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$VariableNames[[1]]
#> [1] "[Clock].Today"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$VariableNames[[2]]
#> [1] "[Wheat].Phenology.Stage"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$VariableNames[[3]]
#> [1] "[Wheat].Phenology.Zadok.Stage"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$VariableNames[[4]]
#> [1] "[Wheat].Phenology.FloweringDAS"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$VariableNames[[5]]
#> [1] "[Wheat].Phenology.FlagLeafDAS"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$VariableNames[[6]]
#> [1] "[Wheat].Phenology.TerminalSpikeletDAS"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$EventNames
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$EventNames[[1]]
#> [1] "[Wheat].Harvesting"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$GroupByVariableName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$Name
#> [1] "HarvestReport"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[2]]
#> $node$Children[[2]]$Children[[5]]$Children[[2]]$`$type`
#> [1] "Models.Fertiliser, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[2]]$Name
#> [1] "Fertiliser"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[2]]$ResourceName
#> [1] "Fertiliser"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[2]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$`$type`
#> [1] "Models.Soils.Soil, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$RecordNumber
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$ASCOrder
#> [1] "Vertosol"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$ASCSubOrder
#> [1] "Black"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$SoilType
#> [1] "Clay"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$LocalName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Site
#> [1] "Norwin"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$NearestTown
#> [1] "Norwin"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Region
#> [1] "Darling Downs and Granite Belt"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$State
#> [1] "Queensland"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Country
#> [1] "Australia"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$NaturalVegetation
#> [1] "Qld. Bluegrass, possible Qld. Blue gum"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$ApsoilNumber
#> [1] "900"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Latitude
#> [1] -27.5818
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Longitude
#> [1] 151.3202
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$LocationAccuracy
#> [1] " +/- 20m"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$YearOfSampling
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$DataSource
#> [1] "CSIRO Sustainable Ecosystems, Toowoomba; Characteriesd as part of the GRDC funded project\"Doing it better, doing it smarter, managing soil water in Australian agriculture' 2011"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Comments
#> [1] "OC, CLL for all crops estimated-based on Bongeen Mywybilla Soil No1"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Name
#> [1] "Soil"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$`$type`
#> [1] "Models.Soils.Physical, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Thickness
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Thickness[[1]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Thickness[[2]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Thickness[[3]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Thickness[[4]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Thickness[[5]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Thickness[[6]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Thickness[[7]]
#> [1] 300
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSand
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSand[[1]]
#> [1] 5
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSand[[2]]
#> [1] 5
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSand[[3]]
#> [1] 5
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSand[[4]]
#> [1] 5
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSand[[5]]
#> [1] 5
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSand[[6]]
#> [1] 5
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSand[[7]]
#> [1] 5
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSilt
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSilt[[1]]
#> [1] 65
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSilt[[2]]
#> [1] 65
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSilt[[3]]
#> [1] 65
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSilt[[4]]
#> [1] 65
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSilt[[5]]
#> [1] 65
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSilt[[6]]
#> [1] 65
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSilt[[7]]
#> [1] 65
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClay
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClay[[1]]
#> [1] 30
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClay[[2]]
#> [1] 30
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClay[[3]]
#> [1] 30
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClay[[4]]
#> [1] 30
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClay[[5]]
#> [1] 30
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClay[[6]]
#> [1] 30
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClay[[7]]
#> [1] 30
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Rocks
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Rocks[[1]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Rocks[[2]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Rocks[[3]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Rocks[[4]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Rocks[[5]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Rocks[[6]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Rocks[[7]]
#> [1] 0
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Texture
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$BD
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$BD[[1]]
#> [1] 1.0106
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$BD[[2]]
#> [1] 1.0715
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$BD[[3]]
#> [1] 1.0939
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$BD[[4]]
#> [1] 1.1586
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$BD[[5]]
#> [1] 1.173
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$BD[[6]]
#> [1] 1.1629
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$BD[[7]]
#> [1] 1.1875
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$AirDry
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$AirDry[[1]]
#> [1] 0.1303
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$AirDry[[2]]
#> [1] 0.1987
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$AirDry[[3]]
#> [1] 0.28
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$AirDry[[4]]
#> [1] 0.28
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$AirDry[[5]]
#> [1] 0.28
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$AirDry[[6]]
#> [1] 0.28
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$AirDry[[7]]
#> [1] 0.28
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$LL15
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$LL15[[1]]
#> [1] 0.2605
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$LL15[[2]]
#> [1] 0.2484
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$LL15[[3]]
#> [1] 0.28
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$LL15[[4]]
#> [1] 0.28
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$LL15[[5]]
#> [1] 0.28
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$LL15[[6]]
#> [1] 0.28
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$LL15[[7]]
#> [1] 0.28
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$DUL
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$DUL[[1]]
#> [1] 0.521
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$DUL[[2]]
#> [1] 0.4967
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$DUL[[3]]
#> [1] 0.4884
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$DUL[[4]]
#> [1] 0.4803
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$DUL[[5]]
#> [1] 0.4716
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$DUL[[6]]
#> [1] 0.4571
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$DUL[[7]]
#> [1] 0.4523
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$SAT
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$SAT[[1]]
#> [1] 0.5887
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$SAT[[2]]
#> [1] 0.5657
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$SAT[[3]]
#> [1] 0.5572
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$SAT[[4]]
#> [1] 0.5328
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$SAT[[5]]
#> [1] 0.5274
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$SAT[[6]]
#> [1] 0.5312
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$SAT[[7]]
#> [1] 0.5219
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$KS
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$KS[[1]]
#> [1] 20
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$KS[[2]]
#> [1] 20
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$KS[[3]]
#> [1] 20
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$KS[[4]]
#> [1] 20
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$KS[[5]]
#> [1] 20
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$KS[[6]]
#> [1] 20
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$KS[[7]]
#> [1] 20
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$BDMetadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$AirDryMetadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$LL15Metadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$DULMetadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$SATMetadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$KSMetadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$RocksMetadata
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$RocksMetadata[[1]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$RocksMetadata[[2]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$RocksMetadata[[3]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$RocksMetadata[[4]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$RocksMetadata[[5]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$RocksMetadata[[6]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$RocksMetadata[[7]]
#> [1] "Calculated"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$TextureMetadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSandMetadata
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSandMetadata[[1]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSandMetadata[[2]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSandMetadata[[3]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSandMetadata[[4]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSandMetadata[[5]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSandMetadata[[6]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSandMetadata[[7]]
#> [1] "Calculated"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSiltMetadata
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSiltMetadata[[1]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSiltMetadata[[2]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSiltMetadata[[3]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSiltMetadata[[4]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSiltMetadata[[5]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSiltMetadata[[6]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeSiltMetadata[[7]]
#> [1] "Calculated"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClayMetadata
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClayMetadata[[1]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClayMetadata[[2]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClayMetadata[[3]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClayMetadata[[4]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClayMetadata[[5]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClayMetadata[[6]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ParticleSizeClayMetadata[[7]]
#> [1] "Calculated"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Name
#> [1] "Physical"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$`$type`
#> [1] "Models.Soils.SoilCrop, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LL
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LL[[1]]
#> [1] 0.261
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LL[[2]]
#> [1] 0.248
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LL[[3]]
#> [1] 0.28
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LL[[4]]
#> [1] 0.306
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LL[[5]]
#> [1] 0.36
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LL[[6]]
#> [1] 0.392
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LL[[7]]
#> [1] 0.446
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KL
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KL[[1]]
#> [1] 0.06
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KL[[2]]
#> [1] 0.06
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KL[[3]]
#> [1] 0.06
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KL[[4]]
#> [1] 0.04
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KL[[5]]
#> [1] 0.04
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KL[[6]]
#> [1] 0.02
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KL[[7]]
#> [1] 0.01
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XF
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XF[[1]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XF[[2]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XF[[3]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XF[[4]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XF[[5]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XF[[6]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XF[[7]]
#> [1] 1
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LLMetadata
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LLMetadata[[1]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LLMetadata[[2]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LLMetadata[[3]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LLMetadata[[4]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LLMetadata[[5]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LLMetadata[[6]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$LLMetadata[[7]]
#> NULL
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KLMetadata
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KLMetadata[[1]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KLMetadata[[2]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KLMetadata[[3]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KLMetadata[[4]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KLMetadata[[5]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KLMetadata[[6]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$KLMetadata[[7]]
#> NULL
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XFMetadata
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XFMetadata[[1]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XFMetadata[[2]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XFMetadata[[3]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XFMetadata[[4]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XFMetadata[[5]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XFMetadata[[6]]
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$XFMetadata[[7]]
#> NULL
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$Name
#> [1] "WheatSoil"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[1]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$`$type`
#> [1] "Models.WaterModel.WaterBalance, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$SummerDate
#> [1] "1-Nov"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$SummerU
#> [1] 5
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$SummerCona
#> [1] 5
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$WinterDate
#> [1] "1-Apr"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$WinterU
#> [1] 5
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$WinterCona
#> [1] 5
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$DiffusConst
#> [1] 40
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$DiffusSlope
#> [1] 16
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$Salb
#> [1] 0.12
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$CN2Bare
#> [1] 73
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$CNRed
#> [1] 20
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$CNCov
#> [1] 0.8
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$DischargeWidth
#> [1] "NaN"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$CatchmentArea
#> [1] "NaN"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$PSIDul
#> [1] -100
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$Thickness
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$Thickness[[1]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$Thickness[[2]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$Thickness[[3]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$Thickness[[4]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$Thickness[[5]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$Thickness[[6]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$Thickness[[7]]
#> [1] 300
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$SWCON
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$SWCON[[1]]
#> [1] 0.3
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$SWCON[[2]]
#> [1] 0.3
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$SWCON[[3]]
#> [1] 0.3
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$SWCON[[4]]
#> [1] 0.3
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$SWCON[[5]]
#> [1] 0.3
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$SWCON[[6]]
#> [1] 0.3
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$SWCON[[7]]
#> [1] 0.3
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$KLAT
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$Name
#> [1] "SoilWater"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$ResourceName
#> [1] "WaterBalance"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$`$type`
#> [1] "Models.Soils.Organic, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FOMCNRatio
#> [1] 40
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Thickness
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Thickness[[1]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Thickness[[2]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Thickness[[3]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Thickness[[4]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Thickness[[5]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Thickness[[6]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Thickness[[7]]
#> [1] 300
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Carbon
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Carbon[[1]]
#> [1] 1.2
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Carbon[[2]]
#> [1] 0.96
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Carbon[[3]]
#> [1] 0.6
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Carbon[[4]]
#> [1] 0.3
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Carbon[[5]]
#> [1] 0.18
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Carbon[[6]]
#> [1] 0.12
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Carbon[[7]]
#> [1] 0.12
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$CarbonUnits
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$SoilCNRatio
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$SoilCNRatio[[1]]
#> [1] 12
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$SoilCNRatio[[2]]
#> [1] 12
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$SoilCNRatio[[3]]
#> [1] 12
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$SoilCNRatio[[4]]
#> [1] 12
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$SoilCNRatio[[5]]
#> [1] 12
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$SoilCNRatio[[6]]
#> [1] 12
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$SoilCNRatio[[7]]
#> [1] 12
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FBiom
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FBiom[[1]]
#> [1] 0.04
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FBiom[[2]]
#> [1] 0.02
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FBiom[[3]]
#> [1] 0.02
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FBiom[[4]]
#> [1] 0.02
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FBiom[[5]]
#> [1] 0.01
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FBiom[[6]]
#> [1] 0.01
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FBiom[[7]]
#> [1] 0.01
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FInert
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FInert[[1]]
#> [1] 0.4
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FInert[[2]]
#> [1] 0.6
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FInert[[3]]
#> [1] 0.8
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FInert[[4]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FInert[[5]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FInert[[6]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FInert[[7]]
#> [1] 1
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FOM
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FOM[[1]]
#> [1] 347.129
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FOM[[2]]
#> [1] 270.3444
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FOM[[3]]
#> [1] 163.9721
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FOM[[4]]
#> [1] 99.4541
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FOM[[5]]
#> [1] 60.322
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FOM[[6]]
#> [1] 36.5871
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FOM[[7]]
#> [1] 22.1912
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$CarbonMetadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$FOMMetadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Name
#> [1] "Organic"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[3]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$`$type`
#> [1] "Models.Soils.Chemical, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$Thickness
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$Thickness[[1]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$Thickness[[2]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$Thickness[[3]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$Thickness[[4]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$Thickness[[5]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$Thickness[[6]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$Thickness[[7]]
#> [1] 300
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$PH
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$PH[[1]]
#> [1] 8
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$PH[[2]]
#> [1] 8
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$PH[[3]]
#> [1] 8
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$PH[[4]]
#> [1] 8
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$PH[[5]]
#> [1] 8
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$PH[[6]]
#> [1] 8
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$PH[[7]]
#> [1] 8
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$PHUnits
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$EC
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$ESP
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CEC
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CEC[[1]]
#> [1] 11.045
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CEC[[2]]
#> [1] 10.505
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CEC[[3]]
#> [1] 9.695
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CEC[[4]]
#> [1] 9.02
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CEC[[5]]
#> [1] 8.75
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CEC[[6]]
#> [1] 8.615
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CEC[[7]]
#> [1] 8.615
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$ECMetadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CLMetadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CECMetadata
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CECMetadata[[1]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CECMetadata[[2]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CECMetadata[[3]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CECMetadata[[4]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CECMetadata[[5]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CECMetadata[[6]]
#> [1] "Calculated"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$CECMetadata[[7]]
#> [1] "Calculated"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$ESPMetadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$PHMetadata
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$Name
#> [1] "Chemical"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[4]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$`$type`
#> [1] "Models.Soils.Water, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$Thickness
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$Thickness[[1]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$Thickness[[2]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$Thickness[[3]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$Thickness[[4]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$Thickness[[5]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$Thickness[[6]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$Thickness[[7]]
#> [1] 300
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$InitialValues
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$InitialValues[[1]]
#> [1] 0.521
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$InitialValues[[2]]
#> [1] 0.4967
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$InitialValues[[3]]
#> [1] 0.4884
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$InitialValues[[4]]
#> [1] 0.4803
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$InitialValues[[5]]
#> [1] 0.4716
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$InitialValues[[6]]
#> [1] 0.4571
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$InitialValues[[7]]
#> [1] 0.4523
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$FilledFromTop
#> [1] FALSE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$Name
#> [1] "Water"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[5]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[6]]
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[6]]$`$type`
#> [1] "Models.Soils.Nutrients.Nutrient, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[6]]$Name
#> [1] "Nutrient"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[6]]$ResourceName
#> [1] "Nutrient"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[6]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[6]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[6]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$`$type`
#> [1] "Models.Soils.Solute, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$Thickness
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$Thickness[[1]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$Thickness[[2]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$Thickness[[3]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$Thickness[[4]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$Thickness[[5]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$Thickness[[6]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$Thickness[[7]]
#> [1] 300
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$InitialValues
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$InitialValues[[1]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$InitialValues[[2]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$InitialValues[[3]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$InitialValues[[4]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$InitialValues[[5]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$InitialValues[[6]]
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$InitialValues[[7]]
#> [1] 1
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$InitialValuesUnits
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$WaterTableConcentration
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$D0
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$Exco
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$FIP
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$DepthConstant
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$MaxDepthSoluteAccessible
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$RunoffEffectivenessAtMovingSolute
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$MaxEffectiveRunoff
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$ConcInSolution
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$Name
#> [1] "NO3"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[7]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$`$type`
#> [1] "Models.Soils.Solute, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$Thickness
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$Thickness[[1]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$Thickness[[2]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$Thickness[[3]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$Thickness[[4]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$Thickness[[5]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$Thickness[[6]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$Thickness[[7]]
#> [1] 300
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$InitialValues
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$InitialValues[[1]]
#> [1] 0.1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$InitialValues[[2]]
#> [1] 0.1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$InitialValues[[3]]
#> [1] 0.1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$InitialValues[[4]]
#> [1] 0.1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$InitialValues[[5]]
#> [1] 0.1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$InitialValues[[6]]
#> [1] 0.1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$InitialValues[[7]]
#> [1] 0.1
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$InitialValuesUnits
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$WaterTableConcentration
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$D0
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$Exco
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$FIP
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$DepthConstant
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$MaxDepthSoluteAccessible
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$RunoffEffectivenessAtMovingSolute
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$MaxEffectiveRunoff
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$ConcInSolution
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$Name
#> [1] "NH4"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[8]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$`$type`
#> [1] "Models.Soils.Solute, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$Thickness
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$Thickness[[1]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$Thickness[[2]]
#> [1] 150
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$Thickness[[3]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$Thickness[[4]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$Thickness[[5]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$Thickness[[6]]
#> [1] 300
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$Thickness[[7]]
#> [1] 300
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$InitialValues
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$InitialValues[[1]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$InitialValues[[2]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$InitialValues[[3]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$InitialValues[[4]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$InitialValues[[5]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$InitialValues[[6]]
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$InitialValues[[7]]
#> [1] 0
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$InitialValuesUnits
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$WaterTableConcentration
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$D0
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$Exco
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$FIP
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$DepthConstant
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$MaxDepthSoluteAccessible
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$RunoffEffectivenessAtMovingSolute
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$MaxEffectiveRunoff
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$ConcInSolution
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$Name
#> [1] "Urea"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[9]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[10]]
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[10]]$`$type`
#> [1] "Models.Soils.SoilTemp.SoilTemperature, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[10]]$Thickness
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[10]]$InitialValues
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[10]]$Name
#> [1] "Temperature"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[10]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[10]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[10]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Children[[10]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[3]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$`$type`
#> [1] "Models.Surface.SurfaceOrganicMatter, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$SurfOM
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$Canopies
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$InitialResidueName
#> [1] "wheat_stubble"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$InitialResidueType
#> [1] "wheat"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$InitialResidueMass
#> [1] 500
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$InitialStandingFraction
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$InitialCPR
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$InitialCNR
#> [1] 100
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$Name
#> [1] "SurfaceOrganicMatter"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$ResourceName
#> [1] "SurfaceOrganicMatter"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[4]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[5]]
#> $node$Children[[2]]$Children[[5]]$Children[[5]]$`$type`
#> [1] "Models.PMF.Plant, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[5]]$Name
#> [1] "Wheat"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[5]]$ResourceName
#> [1] "Wheat"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[5]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[5]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[5]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$`$type`
#> [1] "Models.MicroClimate, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$a_interception
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$b_interception
#> [1] 1
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$c_interception
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$d_interception
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$SoilHeatFluxFraction
#> [1] 0.4
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$MinimumHeightDiffForNewLayer
#> [1] 0
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$NightInterceptionFraction
#> [1] 0.5
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$ReferenceHeight
#> [1] 2
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$Name
#> [1] "MicroClimate"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$ResourceName
#> [1] "MicroClimate"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[6]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$`$type`
#> [1] "Models.Manager, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[1]]
#> [1] "using Models.Soils;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[2]]
#> [1] "using System;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[3]]
#> [1] "using Models.Core;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[4]]
#> [1] "using Models.PMF;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[5]]
#> [1] "namespace Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[6]]
#> [1] "{"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[7]]
#> [1] "    [Serializable]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[8]]
#> [1] "    public class Script : Model"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[9]]
#> [1] "    {"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[10]]
#> [1] "        [Link] Clock Clock;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[11]]
#> [1] "        [Link] Fertiliser Fertiliser;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[12]]
#> [1] "        [Link] Summary Summary;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[13]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[14]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[15]]
#> [1] "        [Description(\"Amount of fertiliser to be applied (kg/ha)\")]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[16]]
#> [1] "        public double Amount { get; set;}"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[17]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[18]]
#> [1] "        [Description(\"Crop to be fertilised\")]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[19]]
#> [1] "        public string CropName { get; set;}"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[20]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[21]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[22]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[23]]
#> [1] ""
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[24]]
#> [1] "        [EventSubscribe(\"Sowing\")]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[25]]
#> [1] "        private void OnSowing(object sender, EventArgs e)"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[26]]
#> [1] "        {"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[27]]
#> [1] "            Model crop = sender as Model;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[28]]
#> [1] "            if (crop.Name.ToLower()==CropName.ToLower())"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[29]]
#> [1] "                Fertiliser.Apply(amount: Amount, type: \"NO3N\");"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[30]]
#> [1] "        }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[31]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[32]]
#> [1] "    }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$CodeArray[[33]]
#> [1] "}"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$Parameters
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$Parameters[[1]]
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$Parameters[[1]]$Key
#> [1] "Amount"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$Parameters[[1]]$Value
#> [1] "300"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$Parameters[[2]]
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$Parameters[[2]]$Key
#> [1] "CropName"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$Parameters[[2]]$Value
#> [1] "wheat"
#> 
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$Name
#> [1] "SowingFertiliser"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[7]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$`$type`
#> [1] "Models.Manager, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[1]]
#> [1] "using APSIM.Shared.Utilities;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[2]]
#> [1] "using Models.Utilities;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[3]]
#> [1] "using Models.Soils;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[4]]
#> [1] "using Models.PMF;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[5]]
#> [1] "using Models.Core;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[6]]
#> [1] "using System;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[7]]
#> [1] ""
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[8]]
#> [1] "namespace Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[9]]
#> [1] "{"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[10]]
#> [1] "    [Serializable]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[11]]
#> [1] "    public class Script : Model"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[12]]
#> [1] "    {"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[13]]
#> [1] "        [Link] Plant Wheat;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[14]]
#> [1] ""
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[15]]
#> [1] "        [EventSubscribe(\"DoManagement\")]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[16]]
#> [1] "        private void OnDoManagement(object sender, EventArgs e)"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[17]]
#> [1] "        {"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[18]]
#> [1] "            if (Wheat.IsReadyForHarvesting)"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[19]]
#> [1] "            {"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[20]]
#> [1] "               Wheat.Harvest();"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[21]]
#> [1] "               Wheat.EndCrop();    "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[22]]
#> [1] "            }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[23]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[24]]
#> [1] "        }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[25]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[26]]
#> [1] "    }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$CodeArray[[27]]
#> [1] "}"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$Parameters
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$Name
#> [1] "Harvest"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[8]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$`$type`
#> [1] "Models.Manager, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[1]]
#> [1] "using Models.Soils.Nutrients;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[2]]
#> [1] "using System;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[3]]
#> [1] "using Models.Core;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[4]]
#> [1] "using Models.PMF;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[5]]
#> [1] "using Models.Soils;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[6]]
#> [1] "using Models.Soils.Nutrients;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[7]]
#> [1] "using Models.Utilities;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[8]]
#> [1] "using APSIM.Shared.Utilities;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[9]]
#> [1] ""
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[10]]
#> [1] "namespace Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[11]]
#> [1] "{"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[12]]
#> [1] "    [Serializable]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[13]]
#> [1] "    public class Script : Model"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[14]]
#> [1] "    {"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[15]]
#> [1] "        [Link] Clock Clock;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[16]]
#> [1] "        [Link] Fertiliser Fertiliser;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[17]]
#> [1] "        [Link] Summary Summary;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[18]]
#> [1] "        [Link] Plant Wheat;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[19]]
#> [1] "        [Link] Soil Soil;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[20]]
#> [1] "        Accumulator accumulatedRain;"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[21]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[22]]
#> [1] "        [Description(\"Sowing date (d-mmm)\")]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[23]]
#> [1] "        public string SowDate { get; set; }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[24]]
#> [1] "        [Description(\"Emergence date (d-mmm)\")]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[25]]
#> [1] "        public string EmergeDate { get; set; }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[26]]
#> [1] "        [Description(\"Cultivar to be sown\")]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[27]]
#> [1] "        public string CultivarName { get; set; }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[28]]
#> [1] "        [Description(\"Sowing depth (mm)\")]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[29]]
#> [1] "        public double SowingDepth { get; set; }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[30]]
#> [1] "        [Description(\"Row spacing (mm)\")]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[31]]
#> [1] "        public double RowSpacing { get; set; }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[32]]
#> [1] "        [Description(\"Plant population (/m2)\")]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[33]]
#> [1] "        public double Population { get; set; }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[34]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[35]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[36]]
#> [1] ""
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[37]]
#> [1] ""
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[38]]
#> [1] "        [EventSubscribe(\"DoManagement\")]"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[39]]
#> [1] "        private void OnDoManagement(object sender, EventArgs e)"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[40]]
#> [1] "        {"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[41]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[42]]
#> [1] "            "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[43]]
#> [1] "            if (DateUtilities.WithinDates(SowDate, Clock.Today, SowDate))"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[44]]
#> [1] "            {"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[45]]
#> [1] "                Wheat.Sow(population: Population, cultivar: CultivarName, depth: SowingDepth, rowSpacing: RowSpacing);    "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[46]]
#> [1] "                Wheat.Phenology.SetPhaseCompletionDate(EmergeDate,\"Emerging\");"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[47]]
#> [1] "            }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[48]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[49]]
#> [1] "        }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[50]]
#> [1] "        "
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[51]]
#> [1] "    }"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$CodeArray[[52]]
#> [1] "}"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[1]]
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[1]]$Key
#> [1] "SowDate"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[1]]$Value
#> [1] "5-May"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[2]]
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[2]]$Key
#> [1] "EmergeDate"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[2]]$Value
#> [1] ""
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[3]]
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[3]]$Key
#> [1] "CultivarName"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[3]]$Value
#> [1] "Hartog"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[4]]
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[4]]$Key
#> [1] "SowingDepth"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[4]]$Value
#> [1] "30"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[5]]
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[5]]$Key
#> [1] "RowSpacing"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[5]]$Value
#> [1] "250"
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[6]]
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[6]]$Key
#> [1] "Population"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Parameters[[6]]$Value
#> [1] "150"
#> 
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Name
#> [1] "Sowing"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[9]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[10]]
#> $node$Children[[2]]$Children[[5]]$Children[[10]]$`$type`
#> [1] "Models.Operations, Models"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[10]]$OperationsList
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[10]]$Name
#> [1] "NSchedule"
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[10]]$ResourceName
#> NULL
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[10]]$Children
#> list()
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[10]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$Children[[10]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[2]]$Children[[5]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$Children[[5]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Children[[2]]$Enabled
#> [1] TRUE
#> 
#> $node$Children[[2]]$ReadOnly
#> [1] FALSE
#> 
#> 
#> 
#> $node$Enabled
#> [1] TRUE
#> 
#> $node$ReadOnly
#> [1] FALSE
#> 
#> 
#> $path
#> [1] 1 2 1
#> 
#> attr(,"class")
#> [1] "apsimxNode"
```
