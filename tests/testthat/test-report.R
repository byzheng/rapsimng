suppressPackageStartupMessages(library(testthat))
test_that("report", {
    file <- system.file("extdata/wheat.apsimx", package = "rapsimng")
    res <- read_report(file, "HarvestReport")
    expect_error(read_report(file, "Harvest"))
    expect_equal(nrow(res), 12)
    rpts <- list_report(file)
    expect_equal(rpts, "HarvestReport")
})
