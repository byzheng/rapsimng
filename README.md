# RApsimNG

[![Build Status](https://travis-ci.com/byzheng/RApsimNG.svg?branch=master)](https://travis-ci.com/byzheng/RApsimNG)


A R package for APSIM Next Generation


## Features
* Find elements in the *.apsimx file



## Installation

Currently on [Github](https://github.com/byzheng/RApsimNG) only. Install with:

```r
devtools::install_github('byzheng/RApsimNG')
```

## Example

```r
library(RApsimNG)
# Read apsimx file
m <- read_apsimx('https://raw.githubusercontent.com/APSIMInitiative/ApsimX/master/Models/Resources/Wheat.json')
# Search for a model by path
potential <- search_path(m, path = '[Structure].BranchingRate.PotentialBranchingRate.Vegetative.PotentialBranchingRate')

# modify a model
new_model <- potential$node
new_model$XProperty <- 'NewVariable'

# Replace the new model 
new <- replace_model(m, potential$path, new_model)
write_apsimx(new, tempfile(fileext = '.json'))

```
