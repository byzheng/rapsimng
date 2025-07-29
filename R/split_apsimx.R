#' Split an APSIMX file into separate simulations except cultivar
#'
#' This function takes an APSIMX file and splits it into separate simulations for all factors except cultivar factors.
#' Then saving the results to the specified output location.
#'
#' @param file Character. Path to the input APSIMX file.
#' @param output Character. Path to the directory where the split components will be saved.
#'
#' @return No return value. The function is called for its side effects.
#'
#' @examples
#' \dontrun{
#' split_apsimx("path/to/input.apsimx", "path/to/output/directory")
#' }
#'
#' @export
split_apsimx <- function(file, output) {
    if (!is.character(file) || length(file) != 1) {
        stop("'file' must be a character string of length 1 (the path to the APSIMX file).")
    }
    if (!is.character(output) || length(output) != 1 || is.na(output) || !nzchar(output)) {
        stop("'output' must be a non-empty character string of length 1 (the path to the output directory).")
    }
    # Check if the output folder exists, and create it if it does not
    if (file.exists(output) && !dir.exists(output)) {
        stop(sprintf("A file named '%s' exists and is not a directory.", output))
    }
    if (!dir.exists(output)) {
        dir.create(output, recursive = TRUE)
    }
    if (!dir.exists(output)) {
        stop(sprintf("The output directory '%s' does not exist and could not be created.", output))
    }

    # read apsimx file
    apsimx_model <- read_apsimx(file)

    # Remove unused models
    apsimx_model_temp <- apsimx_model
    remove_nodes <- c(
        "[Simulations].Sensibility",
        "[Simulations].Sensibility tests",
        "[Simulations].Validation",
        "[Simulations].TitlePage",
        "[Simulations].Introduction",
        "[DataStore].ExcelMultiInput",
        "[DataStore].DailyObsPred",
        "[DataStore].HarvestObsPred",
        "[Replacements].Canola"
    )
    for (j in seq(along = remove_nodes)) {
        node_remove <- search_path(apsimx_model_temp, remove_nodes[j])
        if (length(node_remove) > 0) {
            apsimx_model_temp <- remove_model(apsimx_model_temp, node_remove$path)
        }
    }

    # Get all simulations

    sims <- search_node(apsimx_model, all = TRUE, `$type` = "Models.Core.Simulation, Models")
    sims <- sims |> purrr::discard(function(x) x$node$Name %in% c("CO2TEBaseSimulation", "WaterByNFactorial"))
    purrr::map_chr(sims, function(x) x$node$Name)
    j <- 1
    for (j in seq(along = sims)) {
        # Check whether the parent is experiment
        parent <- get_parent(apsimx_model, sims[[j]]$path)
        if (parent$node$`$type` == "Models.Factorial.Experiment, Models") {
            exp_node <- parent$node
            exp_name <- exp_node$Name
            # Remove all figures
            graphs <- search_node(exp_node,
                all = TRUE,
                `$type` = "Models.Graph, Models"
            )
            for (k in rev(seq(along = graphs))) {
                exp_node <- remove_model(exp_node, graphs[[k]]$path)
            }
            # Remove unused reports
            remove_nodes <- c(
                "[DailyReport]",
                "[MaxLeafSizeReport]",
                "[SowingReport]"
            )
            for (k in seq(along = remove_nodes)) {
                node_remove <- search_path(exp_node, remove_nodes[k])
                if (length(node_remove) > 0) {
                    exp_node <- remove_model(exp_node, node_remove$path)
                }
            }
            # Create a new apsimx file
            apsimx_model_exp <- apsimx_model_temp
            apsimx_model_exp <- insert_model(apsimx_model_exp, c(1), exp_node)
            # Get the met files
            met <- NULL
            met_file <- NULL
            tryCatch(
                {
                    met_file <- get_metfile(apsimx_model_exp)
                    met_path <- file.path(dirname(file), met_file)
                    met <- readLines(met_path)
                },
                error = function(e) {
                    # stop("met file is not found")
                }
            )
            # Further split apsimx by all factors except Cv
            all_nodes <- apsimx_model_exp %>%
                search_path("[Factors]")

            # find out all combinations of all other nodes
            simulations <- get_simulations(all_nodes$node)

            # # Check whether Cv node exists
            # pos <- names(simulations) %in% c("Cv", "Cultivar")
            # if (sum(pos) == 0) {
            #   warning("Cultivar factor doesn't exist for experiment ", exp_name)
            #   #next()
            # }
            # # Remove cultivar factor
            # simulations <- simulations[!(names(simulations) %in% c("Cv", "Cultivar"))]
            simulations <- expand.grid(simulations, stringsAsFactors = FALSE)
            m <- 1

            # Generate apsimx for each factor
            for (m in seq_len(max(1, nrow(simulations)))) {
                if (nrow(simulations) == 0) {
                    model_factor_new <- all_nodes$node
                    base_name <- exp_name
                } else {
                    model_factor_new <- keep_simulations(all_nodes$node, as.list(simulations[m, , drop = FALSE]))
                    factor_name <- paste(paste0(names(simulations), "_", simulations[m, ]), collapse = "_")
                    base_name <- paste0(exp_name, "-", factor_name)

                    factor_name <- paste(paste0(names(simulations), simulations[m, ]), collapse = "")
                    base_name <- paste0(exp_name, factor_name)
                    # obs_exp_f <- obs_exp
                    # mm <- 1
                    # for (mm in seq(along = names(simulations))) {
                    #   obs_exp_f %>%
                    #     filter(FactorName == names(simulations)[mm],
                    #            FactorValue == simulations[[mm]][m])
                    # }
                }
                base_name <- gsub(" ", "", base_name)
                apsimx_model_new <- apsimx_model_exp
                apsimx_model_new <- replace_model(
                    apsimx_model_exp,
                    all_nodes$path,
                    model_factor_new
                )
                file_name <- file.path(dirname(file), paste0(base_name, ".apsimx"))
                # write_apsimx(apsimx_model_new, file_name)
                # Combine weather and met file
                # apsimx <- readLines(file_name)

                file_name <- file.path(output, paste0(base_name, ".Rds"))
                # Check whether Weather node
                permutation_test <- model_factor_new$Children[[1]]$Children
                k <- 4
                for (k in seq(along = permutation_test)) {
                    if (!is.null(permutation_test[[k]]$Specification) &&
                        length(permutation_test[[k]]$Specification) == 1 &&
                        permutation_test[[k]]$Specification == "[Weather]") {
                        if (permutation_test[[k]]$Children[[1]]$`$type` == "Models.Climate.Weather, Models") {
                            met_file <- permutation_test[[k]]$Children[[1]]$FileName
                            met_path <- file.path(dirname(file), met_file)
                            new_met <- readLines(met_path)
                        }
                    }
                }
                if (is.null(met)) {
                    treat_node <- search_path(apsimx_model_new, "[Permutation].Treat")
                    if (length(treat_node) > 0) {
                        if (length(treat_node$node$Children) > 1) {
                            stop()
                        }
                        if (length(treat_node$node$Children[[1]]$Children) > 0) {
                            met_file <- treat_node$node$Children[[1]]$Children[[1]]$FileName
                            met_path <- file.path(dirname(file), met_file)
                            new_met <- readLines(met_path)
                        } else {
                            new_met <- NULL
                        }
                    }
                } else {
                    new_met <- met
                }
                saveRDS(list(met = new_met, apsimx = apsimx_model_new, met_file = met_file), file = file_name)
            }
        } else {
            # In case of single simulation
            apsimx_model_new <- apsimx_model_temp
            apsimx_model_new <- insert_model(apsimx_model_new, c(1), sims[[j]]$node)

            # Get weather data
            met <- NULL
            met_file <- NULL
            tryCatch(
                {
                    met_file <- get_metfile(apsimx_model_new)
                    met_path <- file.path(dirname(file), met_file)
                    met <- readLines(met_path)
                },
                error = function(e) {
                    # stop("met file is not found")
                }
            )
            base_name <- sims[[j]]$node$Name
            file_name <- file.path(output, paste0(base_name, ".Rds"))
            saveRDS(list(met = met, apsimx = apsimx_model_new, met_file = met_file), file = file_name)
        }
    }
}
