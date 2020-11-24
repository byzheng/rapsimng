suppressPackageStartupMessages(library(testthat))
test_that("Search all nodes", {
    # Read wheat.apsimx
    wheat <- read_apsimx(system.file("wheat.apsimx", package = "rapsimng"))

    permutation <- search_path(wheat, path = "[Experiment].Factors")
    expect_equal(length(permutation), 2)
    # Get simulations
    sims <- get_simulations(permutation$node)
    expect_equal(length(sims), 2)
    expect_equal(sims$V, c("1", "2"))
    expect_equal(sims$Cv, c("Axe", "Bolac", "Calingiri"))

    # Keep simulations
    # l <- permutation$node
    # v <- list(V = "2")
    permutation_new <- keep_simulations(permutation$node, list(V = "2"))
    sims_new <- get_simulations(permutation_new)
    expect_equal(length(sims_new), 2)
    expect_equal(sims_new$V, c("2"))
    expect_equal(sims_new$Cv, c("Axe", "Bolac", "Calingiri"))
    permutation_new <- keep_simulations(permutation$node, list(Cv = c("Axe", "Bolac")))
    sims_new <- get_simulations(permutation_new)
    expect_equal(length(sims_new), 2)
    expect_equal(sims_new$V, c("1", "2"))
    expect_equal(sims_new$Cv, c("Axe", "Bolac"))

    permutation_new <- keep_simulations(permutation$node,
                                        list(V = "1", Cv = c("Axe", "Bolac")))
    sims_new <- get_simulations(permutation_new)
    expect_equal(length(sims_new), 2)
    expect_equal(sims_new$V, "1")
    expect_equal(sims_new$Cv, c("Axe", "Bolac"))

    # Check errors
    expect_error(keep_simulations(permutation$node, list(Cv = c("Axe", "Janz"))))
    expect_error(keep_simulations(permutation, list(Cv = c("Axe", "Janz"))))
    expect_error(keep_simulations(list(1), list(Cv = c("Axe", "Janz"))))

    # Test non-permutation factors
    permutation <- search_path(wheat, path = "[Experiment1].Factors")
    expect_equal(length(permutation), 2)
    expect_error(get_simulations(permutation$node))
})
