suppressPackageStartupMessages(library(testthat))
test_that("Search all nodes", {
    # Read wheat.json
    wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
    # Search first node
    # Empty if no matching
    a <- search_node(wheat, Name = "Simulations1")
    expect_equal(length(a), 0)
    expect_equal(a, list())

    a <- search_node(wheat, Name = "simulations", case_insensitive = FALSE)
    expect_equal(length(a), 0)
    expect_equal(a, list())

    a <- search_node(wheat, Name = "Simulations")
    expect_equal(length(a), 2)
    expect_equal(a$path, 1)

    a <- search_node(wheat, Name = "simulations")
    expect_equal(length(a), 2)
    expect_equal(a$path, 1)


    a <- search_node(wheat, Name = "Wheat")
    expect_equal(length(a), 2)
    expect_equal(a$path, c(1, 1))

    a <- search_node(wheat, Name = "Arbitrator")
    expect_equal(length(a), 2)
    expect_equal(a$path, c(1, 1, 2))

    a <- search_node(wheat, `$type` = "Models.PMF.Cultivar, Models")
    expect_equal(length(a), 2)
    # Search all nodes
    a <- search_node(wheat, Name = "Simulations1", all = TRUE)
    expect_equal(length(a), 0)
    expect_equal(a, list())

    a <- search_node(wheat, Name = "Simulations", all = TRUE)
    expect_equal(length(a), 1)
    expect_equal(a[[1]]$path, 1)

    a <- search_node(wheat, Name = "Wheat", all = TRUE)
    expect_equal(length(a), 1)
    expect_equal(a[[1]]$path, c(1, 1))

    a <- search_node(wheat, Name = "Arbitrator", all = TRUE)
    expect_equal(length(a), 1)
    expect_equal(a[[1]]$path, c(1, 1, 2))
    a <- search_node(wheat, `$type` = "Models.PMF.Cultivar, Models", all = TRUE)
    expect_equal(length(a), 5)

    # Search by path
    # Absolute path
    # Root path
    a <- search_path(wheat, '.Simulations1')
    expect_equal(length(a), 0)
    expect_equal(a, list())

    a <- search_path(wheat, '.simulations', case_insensitive = FALSE)
    expect_equal(length(a), 0)
    expect_equal(a, list())

    a <- search_path(wheat, '.Simulations')
    expect_equal(length(a), 2)
    expect_equal(a$path, 1)

    a <- search_path(wheat, '.simulations')
    expect_equal(length(a), 2)
    expect_equal(a$path, 1)


    # Level one
    a <- search_path(wheat, '.Simulations.Wheat1')
    expect_equal(length(a), 0)
    expect_equal(a, list())

    # Level two
    a <- search_path(wheat, '.Simulations.Wheat')
    expect_equal(length(a), 2)
    expect_equal(a$path, c(1, 1))

    # Level three
    a <- search_path(wheat, '.Simulations.Wheat.BranchingRate')
    expect_equal(length(a), 0)
    expect_equal(a, list())

    a <- search_path(wheat, '.Simulations.Wheat.Structure')
    expect_equal(length(a), 2)
    expect_equal(a$path, c(1, 1, 4))
    # Level four
    a <- search_path(wheat, '.Simulations.Wheat.Structure.BranchingRate')
    expect_equal(length(a), 2)
    expect_equal(a$path, c(1, 1, 4, 1))
    a <- search_path(wheat, '.Simulations.Wheat.Structure.BranchingRate1')
    expect_equal(length(a), 0)
    expect_equal(a, list())

    #scoped
    # Root path
    a <- search_path(wheat, '[Simulations1]')
    expect_equal(length(a), 0)
    expect_equal(a, list())
    a <- search_path(wheat, '[Simulations]')
    expect_equal(length(a), 2)
    expect_equal(a$path, 1)

    # Level two
    a <- search_path(wheat, '[Simulations].Wheat1')
    expect_equal(length(a), 0)
    expect_equal(a, list())

    a <- search_path(wheat, '[Simulations1].Wheat')
    expect_equal(length(a), 0)
    expect_equal(a, list())

    a <- search_path(wheat, '[Whea]')
    expect_equal(length(a), 0)
    expect_equal(a, list())

    a <- search_path(wheat, '[Wheat]')
    expect_equal(length(a), 2)
    expect_equal(a$path, c(1, 1))

    # Level three
    a <- search_path(wheat, '[Wheat].BranchingRate')
    expect_equal(length(a), 0)
    expect_equal(a, list())

    a <- search_path(wheat, '[Wheat].Structure')
    expect_equal(length(a), 2)
    expect_equal(a$path, c(1, 1, 4))

    a <- search_path(wheat, '[Structure]')
    expect_equal(length(a), 2)
    expect_equal(a$path, c(1, 1, 4))

    # Level four
    a <- search_path(wheat, '[Structure].BranchingRate')
    expect_equal(length(a), 2)
    expect_equal(a$path, c(1, 1, 4, 1))

    a <- search_path(wheat, '[Structure].BranchingRate1')
    expect_equal(length(a), 0)
    expect_equal(a, list())

    a <- search_path(wheat, '[Structure1].BranchingRate')
    expect_equal(length(a), 0)
    expect_equal(a, list())

})
