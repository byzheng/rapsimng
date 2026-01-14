# Get all cultivar parameters in a model

Get all cultivar parameters in a model

## Usage

``` r
get_cultivar(l, alias = TRUE)
```

## Arguments

- l:

  The list of apsimx file

- alias:

  Whether to export alias

## Value

A data frame for all cultivar parameters

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
get_cultivar(wheat)
#>    name standard_name                                          parameter value
#> 1  Cul1          Cul1           [Phenology].MinimumLeafNumber.FixedValue     1
#> 2  Cul1          Cul1              [Phenology].VrnSensitivity.FixedValue     0
#> 3  Cul1          Cul1               [Phenology].PpSensitivity.FixedValue     2
#> 4  Cul1          Cul1  [Phenology].HeadEmergencePpSensitivity.FixedValue     0
#> 5  Cul1          Cul1 [Phenology].Phyllochron.BasePhyllochron.FixedValue   100
#> 6  Cul6          Cul1           [Phenology].MinimumLeafNumber.FixedValue     1
#> 7  Cul6          Cul1              [Phenology].VrnSensitivity.FixedValue     0
#> 8  Cul6          Cul1               [Phenology].PpSensitivity.FixedValue     2
#> 9  Cul6          Cul1  [Phenology].HeadEmergencePpSensitivity.FixedValue     0
#> 10 Cul6          Cul1 [Phenology].Phyllochron.BasePhyllochron.FixedValue   100
#> 11 Cul2          Cul2           [Phenology].MinimumLeafNumber.FixedValue     1
#> 12 Cul2          Cul2              [Phenology].VrnSensitivity.FixedValue     0
#> 13 Cul2          Cul2               [Phenology].PpSensitivity.FixedValue     2
#> 14 Cul2          Cul2  [Phenology].HeadEmergencePpSensitivity.FixedValue     0
#> 15 Cul2          Cul2 [Phenology].Phyllochron.BasePhyllochron.FixedValue   100
#> 16 Cul3          Cul3           [Phenology].MinimumLeafNumber.FixedValue     1
#> 17 Cul3          Cul3              [Phenology].VrnSensitivity.FixedValue     0
#> 18 Cul3          Cul3               [Phenology].PpSensitivity.FixedValue     2
#> 19 Cul3          Cul3  [Phenology].HeadEmergencePpSensitivity.FixedValue     0
#> 20 Cul3          Cul3 [Phenology].Phyllochron.BasePhyllochron.FixedValue   100
#> 21 Cul4          Cul4           [Phenology].MinimumLeafNumber.FixedValue     1
#> 22 Cul4          Cul4              [Phenology].VrnSensitivity.FixedValue     0
#> 23 Cul4          Cul4               [Phenology].PpSensitivity.FixedValue     2
#> 24 Cul4          Cul4  [Phenology].HeadEmergencePpSensitivity.FixedValue     0
#> 25 Cul4          Cul4 [Phenology].Phyllochron.BasePhyllochron.FixedValue   100
#> 26 Cul5          Cul5           [Phenology].MinimumLeafNumber.FixedValue     1
#> 27 Cul5          Cul5              [Phenology].VrnSensitivity.FixedValue     0
#> 28 Cul5          Cul5               [Phenology].PpSensitivity.FixedValue     2
#> 29 Cul5          Cul5  [Phenology].HeadEmergencePpSensitivity.FixedValue     0
#> 30 Cul5          Cul5 [Phenology].Phyllochron.BasePhyllochron.FixedValue   100
get_cultivar(wheat, alias = FALSE)
#>    name standard_name                                          parameter value
#> 1  Cul1          Cul1           [Phenology].MinimumLeafNumber.FixedValue     1
#> 2  Cul1          Cul1              [Phenology].VrnSensitivity.FixedValue     0
#> 3  Cul1          Cul1               [Phenology].PpSensitivity.FixedValue     2
#> 4  Cul1          Cul1  [Phenology].HeadEmergencePpSensitivity.FixedValue     0
#> 5  Cul1          Cul1 [Phenology].Phyllochron.BasePhyllochron.FixedValue   100
#> 6  Cul2          Cul2           [Phenology].MinimumLeafNumber.FixedValue     1
#> 7  Cul2          Cul2              [Phenology].VrnSensitivity.FixedValue     0
#> 8  Cul2          Cul2               [Phenology].PpSensitivity.FixedValue     2
#> 9  Cul2          Cul2  [Phenology].HeadEmergencePpSensitivity.FixedValue     0
#> 10 Cul2          Cul2 [Phenology].Phyllochron.BasePhyllochron.FixedValue   100
#> 11 Cul3          Cul3           [Phenology].MinimumLeafNumber.FixedValue     1
#> 12 Cul3          Cul3              [Phenology].VrnSensitivity.FixedValue     0
#> 13 Cul3          Cul3               [Phenology].PpSensitivity.FixedValue     2
#> 14 Cul3          Cul3  [Phenology].HeadEmergencePpSensitivity.FixedValue     0
#> 15 Cul3          Cul3 [Phenology].Phyllochron.BasePhyllochron.FixedValue   100
#> 16 Cul4          Cul4           [Phenology].MinimumLeafNumber.FixedValue     1
#> 17 Cul4          Cul4              [Phenology].VrnSensitivity.FixedValue     0
#> 18 Cul4          Cul4               [Phenology].PpSensitivity.FixedValue     2
#> 19 Cul4          Cul4  [Phenology].HeadEmergencePpSensitivity.FixedValue     0
#> 20 Cul4          Cul4 [Phenology].Phyllochron.BasePhyllochron.FixedValue   100
#> 21 Cul5          Cul5           [Phenology].MinimumLeafNumber.FixedValue     1
#> 22 Cul5          Cul5              [Phenology].VrnSensitivity.FixedValue     0
#> 23 Cul5          Cul5               [Phenology].PpSensitivity.FixedValue     2
#> 24 Cul5          Cul5  [Phenology].HeadEmergencePpSensitivity.FixedValue     0
#> 25 Cul5          Cul5 [Phenology].Phyllochron.BasePhyllochron.FixedValue   100
```
