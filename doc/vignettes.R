## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

# install packages
if (!require(RApsimNG)) {
    devtools::install_github('byzheng/RApsimNG')
}
library(RApsimNG)

## ----read-apsimx--------------------------------------------------------------
# Read Wheat.apsimx file with `read_apsimx` which returns a list of json results.
wheat_apsimx <- read_apsimx("https://raw.githubusercontent.com/APSIMInitiative/ApsimX/master/Tests/Validation/Wheat/Wheat.apsimx")
summary(wheat_apsimx)


## ----search-path--------------------------------------------------------------



