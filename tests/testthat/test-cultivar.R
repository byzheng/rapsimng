suppressPackageStartupMessages(library(testthat))
test_that("cultivar", {
    wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
    a <- get_cultivar(wheat)
    expect_equal(nrow(a), 30)
    a <- get_cultivar(wheat, alias = FALSE)
    expect_equal(nrow(a), 25)

})
