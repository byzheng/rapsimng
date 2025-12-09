# Estimate Plant Available Water Capacity (PAWC) from an apsimx file

This function calculates the Plant Available Water Capacity (PAWC) from
soil properties in an APSIM Next Generation (.apsimx) file. PAWC
represents the amount of water that can be stored in the soil and is
available for plant uptake.

## Usage

``` r
get_pawc(l, soil_path = NULL, crop = NULL, depth = NULL)
```

## Arguments

- l:

  The list of apsimx file

- soil_path:

  The path to the soil model. If NULL (default), searches for the first
  Soil model. Can be a character string specifying the soil name.

- crop:

  The crop name for crop-specific lower limit (LL). If NULL (default),
  uses LL15 and does not apply XF. If provided, uses the crop-specific
  LL and XF values from the SoilCrop parameters.

- depth:

  The depth (in mm) to which PAWC should be calculated. If NULL
  (default), calculates for all layers. If specified, applies
  proportional weighting to layers that are partially or completely
  beyond this depth.

## Value

A numeric value of PAWC in mm

## Details

PAWC represents the soil's water storage capacity between field capacity
(DUL) and the permanent wilting point (LL). It is a critical parameter
for:

PAWC is calculated for each soil layer using the formula:

\*\*When crop = NULL and depth = NULL:\*\* \$\$PAWC_i = (DUL_i - LL15_i)
\times Thickness_i\$\$

\*\*When crop is specified:\*\* \$\$PAWC_i = (DUL_i - LL_i) \times
Thickness_i \times XF_i\$\$

\*\*When depth is specified (with or without crop):\*\* \$\$PAWC_i =
(DUL_i - LL_i) \times Thickness_i \times \[XF_i\] \times Weight_i\$\$

Where:

- **DUL** (Drained Upper Limit): The volumetric water content (mm/mm)
  after the soil has drained under gravity, typically 2-3 days after
  saturation

- **LL** (Lower Limit): The volumetric water content (mm/mm) below which
  plants cannot extract water. This can be either:

  - **LL15**: Generic lower limit at 15 bar suction (used when crop =
    NULL)

  - **Crop-specific LL**: Lower limit specific to a crop type,
    accounting for different rooting characteristics

- **Thickness**: Layer thickness in millimeters

- **XF**: Exploration factor (0-1), representing the fraction of a layer
  explored by roots. Only applied when crop is specified; represents the
  proportion of the layer volume that roots can explore

- **Weight**: Depth weighting factor (0-1), only applied when depth is
  specified:

  - 1.0 for layers completely within the specified depth

  - Proportional fraction for layers partially within the depth

  - 0.0 for layers completely beyond the specified depth

The total PAWC is the sum across all layers: \$\$PAWC\_{total} =
\sum\_{i=1}^{n} PAWC_i\$\$

## Examples

``` r
wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))

# Get total PAWC using LL15 (generic)
pawc <- get_pawc(wheat)
pawc
#> [1] 361.23

# Get PAWC for wheat crop (uses crop-specific LL and XF)
pawc_wheat <- get_pawc(wheat, crop = "Wheat")
pawc_wheat
#> [1] 246.015

# Get PAWC to 1200 mm depth
pawc_1200 <- get_pawc(wheat, depth = 1200)
pawc_1200
#> [1] 256.41

# Get wheat PAWC to 1500 mm depth
pawc_wheat_1500 <- get_pawc(wheat, crop = "Wheat", depth = 1500)
pawc_wheat_1500
#> [1] 244.125
```
