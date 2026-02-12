test_that("Get experiment by name", {
    wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
    expect_silent({
        exp_node <- get_experiment(wheat, "Experiment")
    })
    expect_equal(length(exp_node), 2)
    expect_equal(class(exp_node), "apsimxNode")
    expect_equal(exp_node$node$Name, "Experiment")
})

test_that("Error when experiment not found", {
    expect_error(get_experiment("1", "Experiment"))
    
    wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
    expect_error(get_experiment(wheat, "NonExistentExperiment"))
    expect_error(get_experiment(wheat, c(1)))
    expect_error(get_experiment(wheat, c("Exp1", "Exp2")))

})
