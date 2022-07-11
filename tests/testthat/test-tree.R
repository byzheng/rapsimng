suppressPackageStartupMessages(library(testthat))
test_that("Walking json tree", {
    # Read wheat.json
    wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))

    a <- search_node(wheat, Name = "Simulations")
    expect_error(get_parent(wheat, 1))

    # Level four
    a <- search_path(wheat, '[Structure].BranchingRate')
    b <- get_parent(wheat, a$path)
    expect_equal(b$node$Name, "Structure")
    expect_equal(b$path, c(1, 1, 4))
})
