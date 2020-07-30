## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(RApsimNG)

## ----read-apsimx--------------------------------------------------------------
# Read Wheat.apsimx file with `read_apsimx` which returns a list of json results.
file <- system.file("wheat.apsimx", package = "RApsimNG")
m <- read_apsimx(file)


## ----search-path--------------------------------------------------------------



