# rapsimng

![R-CMD-check](https://github.com/byzheng/rapsimng/workflows/R-CMD-check/badge.svg)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/rapsimng)](https://cran.r-project.org/package=rapsimng)




[rapsimng](https://rapsimng.bangyou.me) package is designed to modify and run the *.apsimx simulations using R in [APSIM Next Generation](https://www.apsim.info/).



## Features
* Find elements in the *.apsimx file



## Installation

Currently on [Github](https://github.com/byzheng/rapsimng) only. Install with:

```r
devtools::install_github('byzheng/rapsimng')
```


## Read APSIMX file

The `wheat.apsimx` in the validation dataset of APSIM NG  is used as an example. Function `read_apsimx` is used to read `*.apsimx` file through `jsonlite::read_json` and returns as a list.


```r
# Read Wheat.apsimx file with `read_apsimx` which returns a list of json results.
file <- system.file("wheat.apsimx", package = "rapsimng")
m <- read_apsimx(file)

```



## Search by of APSIM NG

A node in the apsimx file can be found using the path specification in APSIM NG.
```r
potential <- search_path(m,
    path = '[Structure].BranchingRate.PotentialBranchingRate.Vegetative.PotentialBranchingRate')
potential
```


## Modify a found model 
```r
new_model <- potential$node
new_model$XProperty <- 'NewVariable'
```

## Replace the new model 
```r
new <- replace_model(m, potential$path, new_model)
```

## Save into a new apsimx file
```r
write_apsimx(new, tempfile(fileext = '.json'))
```


## Run apsimx file

A function `run_models` is wrapped for APSIM NG `Models.exe` in the command line and can be called to run apsimx files. See [APSIM website](https://apsimnextgeneration.netlify.app/) for documentation. 


