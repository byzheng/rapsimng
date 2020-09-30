suppressPackageStartupMessages(library(testthat))
test_that("Utility", {
    wheat <- read_apsimx(system.file("Wheat.json", package = "rapsimng"))
    a <- get_cultivar(wheat)
    expect_equal(nrow(a), 948)
    a <- get_cultivar(wheat, alias = FALSE)
    expect_equal(nrow(a), 570)
})
