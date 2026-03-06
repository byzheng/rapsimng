# Frost and Heat Damage Functions

Helper and wrapper functions to calculate frost and heat damage from
temperature and growth stage.

## Usage

``` r
default_frost_heat_params()

stage_sens_frost(growth_stage, params)

stage_sens_heat(growth_stage, params)

temp_damage_frost(mint, params)

temp_damage_heat(maxt, params)

daily_damage_frost(mint, growth_stage, params)

daily_damage_heat(maxt, growth_stage, params)

daily_damage_frost_heat(mint, maxt, growth_stage, params)

cum_damage_frost(mint, growth_stage, params)

cum_damage_heat(maxt, growth_stage, params)

cum_damage_frost_heat(mint, maxt, growth_stage, params)

calc_daily_damage_frost_heat(
  mint,
  maxt,
  growth_stage,
  crop = c("Wheat", "Canola"),
  params = NULL
)

calc_cum_damage_frost_heat(
  mint,
  maxt,
  growth_stage,
  crop = c("Wheat", "Canola"),
  params = NULL
)
```

## Arguments

- growth_stage:

  Numeric vector of daily growth stage.

- params:

  A crop parameter list. If provided, it will override the `crop`
  argument.

- mint:

  Numeric vector of daily minimum temperature.

- maxt:

  Numeric vector of daily maximum temperature.

- crop:

  Crop name to use from `default_frost_heat_params()`.

## Value

A named list with crop-specific parameter lists.

A numeric vector of frost stage sensitivity (0-1).

A numeric vector of heat stage sensitivity (0-1).

A numeric vector of frost damage contribution from temperature.

A numeric vector of heat damage contribution from temperature.

A numeric vector of daily frost damage.

A numeric vector of daily heat damage.

A numeric vector of combined daily frost and heat damage.

A scalar cumulative frost damage.

A scalar cumulative heat damage.

A scalar cumulative frost and heat damage.

A tibble with daily stage sensitivity, temperature damage, and daily
frost/heat/combined damage.

A tibble with cumulative frost damage, cumulative heat damage, and
cumulative combined frost-heat damage.

## Details

The damage functions are based on the APSIM NG Model
[FrostHeatDamageFunctions](https://github.com/APSIMInitiative/ApsimX/blob/3787815684da28c13467942b9d886fa04f54d4c6/Models/Functions/FrostHeatDamageFunctions.cs).
See full documentation
[here](https://notes.apsimng.bangyou.me/docs/Models/Functions/FrostHeatDamageFunctions.html).

## Examples

``` r
default_frost_heat_params()
#> $Wheat
#> $Wheat$FrostLowTT
#> [1] -4
#> 
#> $Wheat$FrostMaxReductionRatio
#> [1] 0.4
#> 
#> $Wheat$FrostUpTT
#> [1] 1
#> 
#> $Wheat$FrostMinReductionRatio
#> [1] 0
#> 
#> $Wheat$FrostStartSensitiveGS
#> [1] 6.485454
#> 
#> $Wheat$FrostStartMostSensitiveGS
#> [1] 8
#> 
#> $Wheat$FrostEndMostSensitiveGS
#> [1] 9.49833
#> 
#> $Wheat$FrostEndSensitiveGS
#> [1] 9.499096
#> 
#> $Wheat$HeatLowTT
#> [1] 30.346
#> 
#> $Wheat$HeatMinReductionRatio
#> [1] 0
#> 
#> $Wheat$HeatUpTT
#> [1] 34.00007
#> 
#> $Wheat$HeatMaxReductionRatio
#> [1] 0.2031898
#> 
#> $Wheat$HeatStartSensitiveGS
#> [1] 7.283231
#> 
#> $Wheat$HeatStartMostSensitiveGS
#> [1] 7.483232
#> 
#> $Wheat$HeatEndMostSensitiveGS
#> [1] 8.970902
#> 
#> $Wheat$HeatEndSensitiveGS
#> [1] 9.094543
#> 
#> 
#> $Canola
#> $Canola$FrostLowTT
#> [1] -4.108862
#> 
#> $Canola$FrostMaxReductionRatio
#> [1] 0.3050003
#> 
#> $Canola$FrostUpTT
#> [1] -0.7549879
#> 
#> $Canola$FrostMinReductionRatio
#> [1] 0
#> 
#> $Canola$FrostStartSensitiveGS
#> [1] 7.222864
#> 
#> $Canola$FrostStartMostSensitiveGS
#> [1] 7.329504
#> 
#> $Canola$FrostEndMostSensitiveGS
#> [1] 8.063452
#> 
#> $Canola$FrostEndSensitiveGS
#> [1] 8.181088
#> 
#> $Canola$HeatLowTT
#> [1] 27.45271
#> 
#> $Canola$HeatMinReductionRatio
#> [1] 0
#> 
#> $Canola$HeatUpTT
#> [1] 38.8354
#> 
#> $Canola$HeatMaxReductionRatio
#> [1] 0.5810167
#> 
#> $Canola$HeatStartSensitiveGS
#> [1] 5.578273
#> 
#> $Canola$HeatStartMostSensitiveGS
#> [1] 6.260291
#> 
#> $Canola$HeatEndMostSensitiveGS
#> [1] 9.200536
#> 
#> $Canola$HeatEndSensitiveGS
#> [1] 9.428058
#> 
#> 
calc_daily_damage_frost_heat(
  mint = c(-2, 0, 4),
  maxt = c(29, 33, 36),
  growth_stage = c(7.0, 8.0, 9.0),
  crop = "Wheat"
)
#> # A tibble: 3 × 10
#>    mint  maxt growth_stage stage_sens_frost stage_sens_heat temp_damage_frost
#>   <dbl> <dbl>        <dbl>            <dbl>           <dbl>             <dbl>
#> 1    -2    29            7            0.340           0                  0.24
#> 2     0    33            8            1               1                  0.08
#> 3     4    36            9            1               0.765              0   
#> # ℹ 4 more variables: temp_damage_heat <dbl>, daily_damage_frost <dbl>,
#> #   daily_damage_heat <dbl>, daily_damage_frost_heat <dbl>
calc_cum_damage_frost_heat(
  mint = c(-2, 0, 4),
  maxt = c(29, 33, 36),
  growth_stage = c(7.0, 8.0, 9.0),
  crop = "Wheat"
)
#> # A tibble: 1 × 3
#>   cum_frost cum_heat cum_frost_heat
#>       <dbl>    <dbl>          <dbl>
#> 1     0.155    0.280          0.392
```
