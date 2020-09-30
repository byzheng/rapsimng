suppressPackageStartupMessages(library(testthat))
test_that("cultivar", {
    wheat <- read_apsimx(system.file("Wheat.json", package = "rapsimng"))

    # Replace a model
    a <- search_path(wheat, '[Wheat].Phenology.ThermalTime')
    wheat_new <- replace_model(wheat, a$path, a$node)
    expect_equal(wheat, wheat_new)

    a <- search_path(wheat, '[Wheat].Phenology.ThermalTime')
    a$node$Children[[1]]$X[[2]] <- 27
    wheat_new <- replace_model(wheat, a$path, a$node)
    b <- search_path(wheat_new, '[Wheat].Phenology.ThermalTime')
    expect_equal(b$node$Children[[1]]$X[[2]], 27)

    # Remove model
    a <- search_path(wheat, '[Wheat].Phenology.ThermalTime')
    wheat_new <- remove_model(wheat, a$path)
    b <- search_path(wheat_new, '[Wheat].Phenology.ThermalTime')
    expect_equal(b, list())

    # New model
    cultivar <- new_model("PMF.Cultivar")
    expect_equal(cultivar$Name, "Cultivar")
    expect_equal(cultivar$`$type`, "Models.PMF.Cultivar, Models")
    cultivar <- new_model("PMF.Cultivar", "test")
    expect_equal(cultivar$Name, "test")
    expect_equal(cultivar$`$type`, "Models.PMF.Cultivar, Models")
    wheat <- read_apsimx(system.file("wheat.apsimx", package = "rapsimng"))

    replacements <- new_model("Core.Replacements")

})
