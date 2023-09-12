
#' Get all cultivar parameters in a model
#'
#' @param l The list of apsimx file
#' @param alias Whether to export alias
#'
#' @return A data frame for all cultivar parameters
#' @export
#'
#' @examples
#' wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
#' get_cultivar(wheat)
#' get_cultivar(wheat, alias = FALSE)
#'
get_cultivar <- function(l, alias = TRUE) {
    culs <- search_node(l, `$type` = "Models.PMF.Cultivar, Models", all = TRUE)
    if (length(culs) == 0) {
        stop("No cultivars found")
    }
    res <- list()
    k <- 0
    for (i in seq(along = culs)) {
        cul_name <- culs[[i]]$node$Name
        cmds <- unlist(culs[[i]]$node$Command)
        k <- k + 1
        res[[k]] <- data.frame(name = cul_name, cmd = cmds, stringsAsFactors = FALSE)
        # for alias
        if (alias == TRUE && length(culs[[i]]$node$Children) > 0 ){
            aliases <- search_node(culs[[i]]$node, `$type` = 'Models.Core.Alias, Models', all = TRUE)
            if (length(aliases) > 0) {
                for (j in seq(along = aliases)) {
                    k <- k + 1
                    res[[k]] <- data.frame(name = aliases[[j]]$node$Name,
                                               cmd = cmds, stringsAsFactors = FALSE)
                }
            }
        }
    }
    if (length(res) == 0) {
        stop("No cultivars found")
    }
    r <- do.call(rbind, res)
    r <- r[grepl("=", r$cmd),]
    p_v <- strsplit(r$cmd, split = " *= *")
    r$parameter <- unlist(lapply(p_v, function(x) x[1]))
    r$value <- unlist(lapply(p_v, function(x) x[2]))
    r$cmd <- NULL
    r
}

# wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
# df <- data.frame(name = rep("Hartog", 3),
#                  parameter = c("[Phenology].MinimumLeafNumber.FixedValue",
#                                "[Phenology].VrnSensitivity.FixedValue",
#                                "[Phenology].PpSensitivity.FixedValue"),
#                  value = c(9, 7, 3))
# l <- wheat
#' Title Update the cultivar parameters
#'
#' @description
#' This function assumes the file is apsimx format.
#' A new Replacements node is added if it is not exist.
#' The existing cultivar parameters are updated. New cultivar
#' is created.
#'
#'
#' @param l The list of apsimx file
#' @param df A data frame for new parameters with three columns, i.e. name, parameter and value.
#' @param add Whether to add extra nodes (e.g. replacements, Cultivars folder
#'  and new cultivar)
#' @param use_folder use cultivar folder to add new cultivars
#' @param cultivar_folder folder name for cultivars
#'
#' @return The modified apsimx file
#' @export
#'
#' @examples
#' wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
#' # Update cultivars
#' df <- data.frame(name = rep("Hartog", 3),
#'                  parameter = c("[Phenology].MinimumLeafNumber.FixedValue",
#'                               "[Phenology].VrnSensitivity.FixedValue",
#'                               "[Phenology].PpSensitivity.FixedValue"),
#'                 value = c(9, 7, 3))
#'
#' wheat_cultivar <- update_cultivar(wheat, df)
#' hartog <- search_path(wheat_cultivar, "[Replacements].Hartog")
#' hartog$path
update_cultivar <- function(l, df, add = TRUE, use_folder = TRUE,
                            cultivar_folder = "Cultivars") {

    if (is.null(df$name)) {
        stop("'name' column is required in the data frame 'df'.")
    }

    if (is.null(df$parameter)) {
        stop("'parameter' column is required in the data frame 'df'.")
    }

    if (is.null(df$value)) {
        stop("'value' column is required in the data frame 'df'.")
    }

    if (add == TRUE) {
        cultivar_node <- search_node(l,
                                     `$type` = "Models.Core.Folder, Models",
                                     Name = cultivar_folder,
                                     all = FALSE)
        # compatible for old version
        if (length(cultivar_node) == 0) {
            cultivar_node <- search_node(l,
                                         `$type` = "Models.PMF.CultivarFolder, Models",
                                         Name = cultivar_folder,
                                         all = FALSE)

        }
        #cultivar_node <- search_path(l, "[Cultivars]")
        if (length(cultivar_node) == 0) {
            # Check the replacement node (assume the apsimx file)
            replacements_node <- search_path(l, "[Replacements]")

            if (length(replacements_node) == 0) {
                replacements <- new_model("Core.Replacements")
                l <- insert_model(l, 1, replacements)
            }
            if (use_folder) {
                replacements_node <- search_path(l, "[Replacements]")

                cultivars_path <- c(sprintf("[Replacements].%s", cultivar_folder))
                for (i in seq(along = cultivars_path)) {
                    cultivars_node <- search_path(l, cultivars_path[i])
                    if (length(cultivars_node) > 0) {
                        break
                    }
                }
                if (length(cultivars_node) == 0) {
                    # Fix me with new version
                    cultivar_model <- new_model("Core.Folder", cultivar_folder)
                    l <- insert_model(l, replacements_node$path, cultivar_model)
                }
            }


            # define the root node:
            # Cultivars or Replacements
            # Check whether cultivar node exists
            root_node <- search_path(l, "[Replacements]")
            if (use_folder) {
                root_node <- search_path(l, sprintf("[Replacements].%s", cultivar_folder))
            }
            # root_node <- search_path(l, "[Cultivars]")
            if (length(root_node) == 0) {
                stop("Cannot find replacements")
            }
        } else {
            root_node <- cultivar_node
        }
    }
    cultivars_name <- unique(df$name)
    i <- 1
    for (i in seq(along = cultivars_name)) {
        df_cultivar <- df[df$name == cultivars_name[i],]
        commands <- paste0(df_cultivar$parameter, " = ", df_cultivar$value)
        # Search whether the cultivar existing
        cultivar_node <- search_path(l, paste0("[", cultivars_name[i], "]"))
        if (length(cultivar_node) != 0 &&
            cultivar_node$node$`$type` == "Models.PMF.Cultivar, Models") {
            # overwrite in case the cultivar existing
            cultivar_model <- cultivar_node$node
            commands_old <- cultivar_model$Command
            for (j in seq(along = df_cultivar$parameter)) {
                pos <- grepl(df_cultivar$parameter[j], commands_old, fixed = TRUE)
                # Overwrite if existing
                if (sum(pos) > 0) {
                    commands_old[pos] <- commands[j]
                } else {
                    commands_old <- c(commands_old, commands[j])
                }
            }
            cultivar_model$Command <- commands_old
            # Replace cultivar
            l <- replace_model(l, cultivar_node$path,
                               cultivar_model)
        } else {
            if (add == TRUE) {
                # Create a new one if not existing
                cultivar_model <- new_model("PMF.Cultivar", cultivars_name[i])
                cultivar_model$Command <- commands
                # Insert new model
                l <- insert_model(l, root_node$path,
                                  cultivar_model)
            } else {
                warning("Cultivar ", cultivars_name[i], " cannot be found.")
            }
        }

    }
    l
}
