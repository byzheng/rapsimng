suppressPackageStartupMessages(library(testthat))
test_that("log", {
    # Insert a model
    # Add a new replacements
    wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
    expect_error(log_level(wheat, "Notfound"))

    expect_error(wheat2 <- log_level(wheat, c("Error", "All")))

    expect_no_error(wheat2 <-log_level(wheat, "Error"))


    summary_node <- search_node(wheat2, all = FALSE, "$type" = "Models.Summary, Models")
    expect_equal(summary_node$node$Verbosity, 0)

    expect_no_error(wheat2 <-log_level(wheat, "All"))
    summary_node <- search_node(wheat2, all = FALSE, "$type" = "Models.Summary, Models")
    expect_equal(summary_node$node$Verbosity, 100)

})
