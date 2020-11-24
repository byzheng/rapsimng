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

    # Insert a model
    # Add a new replacements
    wheat <- read_apsimx(system.file("wheat.apsimx", package = "rapsimng"))
    replacements <- new_model("Core.Replacements")
    wheat_new <- insert_model(wheat, 1, replacements)
    replacements_node <- search_path(wheat_new, ".Simulations.Replacements")
    expect_equal(length(replacements_node), 2)
    expect_equal(replacements_node$path, c(1, 4))
    # Add a cultivar folder under replacements
    cultivar_folder <- new_model("PMF.CultivarFolder", "Cultivars")
    wheat_new <- insert_model(wheat_new, replacements_node$path, cultivar_folder)
    cultivar_folder_node <- search_path(wheat_new,
                                        ".Simulations.Replacements.Cultivars")
    expect_equal(length(cultivar_folder_node), 2)
    expect_equal(cultivar_folder_node$path, c(1, 4, 1))

    # Add an new cultivar
    cultivar <- new_model("PMF.Cultivar", "Hartog")
    wheat_new <- insert_model(wheat_new, cultivar_folder_node$path, cultivar)
    cultivar_node <- search_path(wheat_new,
                                        ".Simulations.Replacements.Cultivars.Hartog")
    expect_equal(length(cultivar_node), 2)
    expect_equal(cultivar_node$path, c(1, 4, 1, 1))

    # Append node
    cultivar2 <- new_model("PMF.Cultivar", "Axe")
    wheat_new <- append_model(wheat_new, cultivar_node$path, list(cultivar2))
    cultivar2_node <- search_path(wheat_new,
                                 ".Simulations.Replacements.Cultivars.Axe")
    expect_equal(length(cultivar2_node), 2)
    expect_equal(cultivar2_node$path, c(1, 4, 1, 2))


    # Update cultivars
    df <- data.frame(name = rep("Hartog", 3),
                     parameter = c("[Phenology].MinimumLeafNumber.FixedValue",
                                   "[Phenology].VrnSensitivity.FixedValue",
                                   "[Phenology].PpSensitivity.FixedValue"),
                     value = c(9, 7, 3))
    # No replacements
    wheat_cultivar <- update_cultivar(wheat, df)
    hartog <- search_path(wheat_cultivar, "[Replacements].Hartog")
    expect_equal(length(hartog), 2)
    expect_equal(hartog$path, c(1, 4, 1))
    # Update if existing
    wheat_cultivar2 <- update_cultivar(wheat_cultivar, df)
    hartog2 <- search_path(wheat_cultivar2, "[Replacements].Hartog")
    expect_equal(length(hartog2), 2)
    expect_equal(hartog, hartog2)
    # Replacements and Cultivars node exist
    wheat_cultivar3 <- update_cultivar(wheat_new, df)
    hartog3 <- search_path(wheat_cultivar3, "[Replacements].Cultivars.Hartog")
    expect_equal(length(hartog3), 2)
    expect_equal(hartog3$path, c(1, 4, 1, 1))
    # Update existing one
    wheat_cultivar4 <- update_cultivar(wheat_cultivar3, df)
    hartog4 <- search_path(wheat_cultivar4, "[Replacements].Cultivars.Hartog")
    expect_equal(length(hartog4), 2)
    expect_equal(hartog3, hartog4)

})
