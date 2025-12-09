# Generate apsimx file for sensitivity analysis

``` r
library(rapsimng)
library(tidyverse)
```

Sensitivity analysis is conducted to check output variations when a
parameter is changed. This post is to show how to conduct sensitivity
analysis using rapsimng package using factorial simulations.

We use the base phyllochron as an example to demonstrate how to generate
a new apsimx file from a template.

The base phyllochron is a key parameter for wheat phelonogy and leaf
appearance rate. The range of base phyllochron is from 60 to 130 degree
days.

The data.frame requires three columns (i.e. parameter, value, name) and
multiple parameters can be specified here.

``` r
phyllochron_para <- tibble(parameter = "[Phenology].Phyllochron.BasePhyllochron.FixedValue", 
                           value = seq(60, 130, by = 1)) %>% 
  mutate(name = paste0("Cultivar", seq_len(n())))
head(phyllochron_para)
#> # A tibble: 6 × 3
#>   parameter                                          value name     
#>   <chr>                                              <dbl> <chr>    
#> 1 [Phenology].Phyllochron.BasePhyllochron.FixedValue    60 Cultivar1
#> 2 [Phenology].Phyllochron.BasePhyllochron.FixedValue    61 Cultivar2
#> 3 [Phenology].Phyllochron.BasePhyllochron.FixedValue    62 Cultivar3
#> 4 [Phenology].Phyllochron.BasePhyllochron.FixedValue    63 Cultivar4
#> 5 [Phenology].Phyllochron.BasePhyllochron.FixedValue    64 Cultivar5
#> 6 [Phenology].Phyllochron.BasePhyllochron.FixedValue    65 Cultivar6
```

The template is an apsimx file setup for the actual experiment or the
specified environments (i.e. locations, sowing date or years). I assume
there is a factor `Cv` for culivar in the `Permutation` model which
specified the cultivar by `[Sowing].Script.CultivarName`.

``` r
template <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
```

`update_cultivar` can be used to add the list of cultivars in the
`Replacements`. The `Specification` in the `Permutation.Cv` can be
replace with new values.

``` r
template <- update_cultivar(template, phyllochron_para)

node <- search_path(template, "[Permutation].Cv")    
if (length(node) == 0) {
  stop("[Permutation].Cv is not found")
}
new_value <- paste0("\\1", paste(phyllochron_para$name, collapse = ","))
node$node$Specification <- gsub("(.+ *= *)(.+)$", new_value, node$node$Specification)

node$node$Specification
#> [1] "[Sowing].Script.CultivarName=Cultivar1,Cultivar2,Cultivar3,Cultivar4,Cultivar5,Cultivar6,Cultivar7,Cultivar8,Cultivar9,Cultivar10,Cultivar11,Cultivar12,Cultivar13,Cultivar14,Cultivar15,Cultivar16,Cultivar17,Cultivar18,Cultivar19,Cultivar20,Cultivar21,Cultivar22,Cultivar23,Cultivar24,Cultivar25,Cultivar26,Cultivar27,Cultivar28,Cultivar29,Cultivar30,Cultivar31,Cultivar32,Cultivar33,Cultivar34,Cultivar35,Cultivar36,Cultivar37,Cultivar38,Cultivar39,Cultivar40,Cultivar41,Cultivar42,Cultivar43,Cultivar44,Cultivar45,Cultivar46,Cultivar47,Cultivar48,Cultivar49,Cultivar50,Cultivar51,Cultivar52,Cultivar53,Cultivar54,Cultivar55,Cultivar56,Cultivar57,Cultivar58,Cultivar59,Cultivar60,Cultivar61,Cultivar62,Cultivar63,Cultivar64,Cultivar65,Cultivar66,Cultivar67,Cultivar68,Cultivar69,Cultivar70,Cultivar71"

template <- replace_model(template, node$path, node$node)
```

Finally the new model can be write into file system and run with APSIM
NG. Uncomment the sections below, update the path to `Models.exe`.

``` r

# write_apsimx(template, "new-path.apsimx")
# models_path <- "path-to-Models.exe"
# run_models(models_path, sim_name, csv = TRUE, parallel = FALSE)
```

The example in this post can be modified into parallel codes for
sensivity analysis in the large scales.
