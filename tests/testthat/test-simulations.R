suppressPackageStartupMessages(library(testthat))
test_that("Search all nodes", {
    # Read wheat.apsimx
    wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))

    permutation <- search_path(wheat, path = "[Experiment].Factors")
    expect_equal(length(permutation), 2)
    # Get simulations
    sims <- get_simulations(permutation$node)
    expect_equal(length(sims), 3)
    expect_equal(sims$V, c("1", "2"))
    expect_equal(sims$Cv, c("Axe", "Bolac", "Calingiri"))
    expect_equal(sims$N, c("0", "200"))

    # Keep simulations
    # l <- permutation$node
    # s <- list(V = "1", Cv = c("Axe", "Bolac"),
    #      N = "200")
    #
    permutation_new <- keep_simulations(permutation$node, list(V = "2"))
    sims_new <- get_simulations(permutation_new)
    expect_equal(length(sims_new), 3)
    expect_equal(sims_new$V, c("2"))
    expect_equal(sims_new$Cv, c("Axe", "Bolac", "Calingiri"))
    expect_equal(sims_new$N, c("0", "200"))

    permutation_new <- keep_simulations(permutation$node, list(Cv = c("Axe", "Bolac")))
    sims_new <- get_simulations(permutation_new)
    expect_equal(length(sims_new), 3)
    expect_equal(sims_new$V, c("1", "2"))
    expect_equal(sims_new$Cv, c("Axe", "Bolac"))
    expect_equal(sims_new$N, c("0", "200"))

    permutation_new <- keep_simulations(permutation$node,
                                        list(V = "1", Cv = c("Axe", "Bolac")))
    sims_new <- get_simulations(permutation_new)
    expect_equal(length(sims_new), 3)
    expect_equal(sims_new$V, "1")
    expect_equal(sims_new$Cv, c("Axe", "Bolac"))
    expect_equal(sims_new$N, c("0", "200"))

    permutation_new <- keep_simulations(permutation$node,
                                        list(V = "1", Cv = c("Axe", "Bolac"),
                                             N = "200"))
    sims_new <- get_simulations(permutation_new)
    expect_equal(length(sims_new), 3)
    expect_equal(sims_new$V, "1")
    expect_equal(sims_new$Cv, c("Axe", "Bolac"))
    expect_equal(sims_new$N, c("200"))

    # Check errors
    expect_error(keep_simulations(permutation$node, list(Cv = c("Axe", "Janz"))))
    expect_error(keep_simulations(permutation, list(Cv = c("Axe", "Janz"))))
    expect_error(keep_simulations(list(1), list(Cv = c("Axe", "Janz"))))

    # Test met name
    exp <- search_path(wheat, path = "[Experiment]")
    metfile <- get_metfile(exp)
    expect_equal(metfile, "example.met")
})
