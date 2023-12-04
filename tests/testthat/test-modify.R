suppressPackageStartupMessages(library(testthat))
test_that("cultivar", {
    wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))




    # Set a parameter value
    new_wheat <- set_parameter_value(wheat,
                                     "[Structure].BranchingRate.PotentialBranchingRate.Reproductive.Zero.FixedValue",
                                     1)
    new_wheat2 <- search_path(new_wheat, "[Structure].BranchingRate.PotentialBranchingRate.Reproductive.Zero")
    expect_equal(length(new_wheat2), 2)
    expect_equal(new_wheat2$node$FixedValue, 1)

    new_wheat <- set_parameter_value(wheat,
                                     "[Structure].HeightModel.WaterStress.XYPairs.X", "0.4,1.1")
    new_wheat2 <- search_path(new_wheat, "[Structure].HeightModel.WaterStress.XYPairs")
    expect_equal(length(new_wheat2), 2)
    expect_equal(new_wheat2$node$X[[1]], "0.4")

    new_wheat <- set_parameter_value(wheat,
                                     "[Structure].HeightModel.WaterStress.XYPairs.X", "0.4, 1.1")
    new_wheat2 <- search_path(new_wheat, "[Structure].HeightModel.WaterStress.XYPairs")
    expect_equal(length(new_wheat2), 2)
    expect_equal(new_wheat2$node$X[[1]], "0.4")

    new_wheat <- set_parameter_value(wheat,
                                     "[Structure].HeightModel.WaterStress.XYPairs.X", "0.4 , 1.1")
    new_wheat2 <- search_path(new_wheat, "[Structure].HeightModel.WaterStress.XYPairs")
    expect_equal(length(new_wheat2), 2)
    expect_equal(new_wheat2$node$X[[1]], "0.4")

    new_wheat <- set_parameter_value(wheat,
                                     "[Structure].HeightModel.WaterStress.XYPairs.X", "0.4 ,1.1")
    new_wheat2 <- search_path(new_wheat, "[Structure].HeightModel.WaterStress.XYPairs")
    expect_equal(length(new_wheat2), 2)
    expect_equal(new_wheat2$node$X[[1]], "0.4")

    expect_error({
        new_wheat <- set_parameter_value(wheat,
                                     "[Structure].HeightModel.WaterStress.XYPairs.X", "0.4")
        new_wheat <- set_parameter_value(wheat,
                                         "[Structure].HeightModel.WaterStress.XYPairs.X", "0.4,1.1,2")

    })

    # Disable models
    new_wheat <- disable_models(wheat, c("[Structure].HeightModel", "[Structure].BranchingRate"))



    new_wheat <- set_parameter_value(
        wheat,
        "[Structure].HeightModel.WaterStress.XYPairs.Y", "0.1,1.1")
    new_wheat2 <- search_path(new_wheat, "[Structure].HeightModel.WaterStress.XYPairs")
    expect_equal(length(new_wheat2), 2)
    expect_equal(new_wheat2$node$Y[[2]], "1.1")

    new_wheat <- set_parameter_value(
        wheat,
        "[Structure].CohortInitialisationStage", "Germination1")
    new_wheat2 <- search_path(new_wheat, "[Structure]")
    expect_equal(length(new_wheat2), 2)
    expect_equal(new_wheat2$node$CohortInitialisationStage, "Germination1")

    expect_error({
        new_wheat <- set_parameter_value(
            wheat,
            "[Structure].HeightModel.WaterStress.XYPairs.X", c(1, 1))
    })
    expect_error({
        new_wheat <- set_parameter_value(
            wheat,
            "[Structure].HeightModel.WaterStress", c(1, 1))
    })
    expect_error({
        new_wheat <- set_parameter_value(
            wheat, 1, c(1, 1))
    })

    expect_error({
        new_wheat <- set_parameter_value(
            wheat, c("A", "B"), c(1, 1))
    })





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
    wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
    replacements <- new_model("Core.Replacements")
    wheat_replacement <- insert_model(wheat, 1, replacements)
    replacements_node <- search_path(wheat_replacement, ".Simulations.Replacements")
    expect_equal(length(replacements_node), 2)
    expect_equal(replacements_node$path, c(1, 3))
    # Add a cultivar folder under replacements
    cultivar_folder <- new_model("PMF.CultivarFolder", "Cultivars")
    wheat_cultivar_folder <- insert_model(wheat_replacement, replacements_node$path, cultivar_folder)
    cultivar_folder_node <- search_path(wheat_cultivar_folder,
                                        ".Simulations.Replacements.Cultivars")
    expect_equal(length(cultivar_folder_node), 2)
    expect_equal(cultivar_folder_node$path, c(1, 3, 1))

    # Add an new cultivar
    cultivar <- new_model("PMF.Cultivar", "Hartog")
    wheat_new_cultivar <- insert_model(wheat_cultivar_folder, cultivar_folder_node$path, cultivar)
    cultivar_node <- search_path(wheat_new_cultivar,
                                        ".Simulations.Replacements.Cultivars.Hartog")
    expect_equal(length(cultivar_node), 2)
    expect_equal(cultivar_node$path, c(1, 3, 1, 1))

    # Insert models
    cultivars <- c(list(new_model("PMF.Cultivar", "Hartog")),
                  list(new_model("PMF.Cultivar", "Janz")))
    wheat_new_cultivar2 <- insert_models(wheat_cultivar_folder, cultivar_folder_node$path, cultivars)

    cultivar_node <- search_path(wheat_new_cultivar2,
                                 ".Simulations.Replacements.Cultivars.Hartog")
    expect_equal(length(cultivar_node), 2)
    expect_equal(cultivar_node$path, c(1, 3, 1, 1))
    cultivar_node <- search_path(wheat_new_cultivar2,
                                 ".Simulations.Replacements.Cultivars.Janz")
    expect_equal(length(cultivar_node), 2)
    expect_equal(cultivar_node$path, c(1, 3, 1, 2))

    # Append node
    cultivar2 <- new_model("PMF.Cultivar", "Axe")
    wheat_new <- append_model(wheat_new_cultivar, cultivar_node$path, list(cultivar2))
    cultivar2_node <- search_path(wheat_new,
                                 ".Simulations.Replacements.Cultivars.Axe")
    expect_equal(length(cultivar2_node), 2)
    expect_equal(cultivar2_node$path, c(1, 3, 1, 2))


    # Update cultivars
    df <- rbind(data.frame(name = rep("Hartog", 3),
                     parameter = c("[Phenology].MinimumLeafNumber.FixedValue",
                                   "[Phenology].VrnSensitivity.FixedValue",
                                   "[Phenology].PpSensitivity.FixedValue"),
                     value = c(9, 7, 3)),
                data.frame(name = rep("Janz", 3),
                           parameter = c("[Phenology].MinimumLeafNumber.FixedValue",
                                         "[Phenology].VrnSensitivity.FixedValue",
                                         "[Phenology].PpSensitivity.FixedValue"),
                           value = c(3, 3, 4)))
    # No replacements
    wheat_cultivar <- update_cultivar(wheat, df)
    hartog <- search_path(wheat_cultivar, "[Replacements].Cultivars.Hartog")
    expect_equal(length(hartog), 2)
    expect_equal(hartog$path, c(1, 3, 1, 1))
    janz <- search_path(wheat_cultivar, "[Replacements].Cultivars.Janz")
    expect_equal(length(janz), 2)
    expect_equal(janz$path, c(1, 3, 1, 2))

    # Replacements and Cultivars node exist
    wheat_cultivar3 <- update_cultivar(wheat_new, df)
    hartog3 <- search_path(wheat_cultivar3, "[Replacements].Cultivars.Hartog")
    expect_equal(length(hartog3), 2)
    expect_equal(hartog3$path, c(1, 3, 1, 1))
    # Update existing one
    wheat_cultivar4 <- update_cultivar(wheat_cultivar3, df)
    hartog4 <- search_path(wheat_cultivar4, "[Replacements].Cultivars.Hartog")
    expect_equal(length(hartog4), 2)
    expect_equal(hartog3, hartog4)


})
