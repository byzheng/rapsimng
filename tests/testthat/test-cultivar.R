suppressPackageStartupMessages(library(testthat))
test_that("cultivar", {
    wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
    a <- get_cultivar(wheat)
    expect_equal(nrow(a), 30)
    expect_equal(length(a$name), 30)
    expect_equal(length(a$standard_name), 30)
    expect_equal(length(a$parameter), 30)
    expect_equal(length(a$value), 30)
    a <- get_cultivar(wheat, alias = FALSE)
    expect_equal(nrow(a), 25)
})



test_that("new cultivar", {

    df <- data.frame(name = c("C1", "C1", "C2", "C2"),
                     parameter = c("[Phenology].CAMP.FLNparams.MinLN",
                                   "[Phenology].CAMP.FLNparams.VrnLN",
                                   "[Phenology].CAMP.FLNparams.MinLN",
                                   "[Phenology].CAMP.FLNparams.VrnLN"),
                     value = c(5, 6, 7, 8))
    cultivar_folder <- "Cultivars"
    a <- new_cultivar(df, cultivar_folder)
    expect_equal(a$Name, cultivar_folder)
    expect_equal(length(a$Children), 2)
    expect_equal(a$Children[[1]]$Name, "C1")
    expect_equal(a$Children[[1]]$Command[[1]], "[Phenology].CAMP.FLNparams.MinLN = 5")
    expect_equal(a$Children[[2]]$Name, "C2")
})

