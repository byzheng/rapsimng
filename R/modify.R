


# Internal code to check path
.check_path <- function(l, path) {
    if (length(path) < 1) {
        stop("Path should not be empty")
    }

    if (sum(path < 1) > 0) {
        stop("All path should be positive values")
    }
    if (sum(as.integer(path) != path) > 0){
        stop("All path should be integar values.")
    }
    if (path[1] != 1) {
        stop("Path should start with 1")
    }

    if (all(is.numeric(path))) {
        return(path)
    } else if (length(path) == 1 && is.character(path)) {
        return(search_path(l, path)$path)
    }
    stop("not implemented")
}


#' Replace a model with new values
#'
#' @param l the list of apsimx file
#' @param path If numeric, the path returned by search_path or search_node. If character, the path supported by apsimx
#' @param model A new model
#' @return The modified list with new value
#' @export
#' @examples
#' wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
#'
#' a <- search_path(wheat, '[Wheat].Phenology.ThermalTime')
#' a$node$Children[[1]]$X[[2]] <- 27
#' wheat_new <- replace_model(wheat, a$path, a$node)
#' b <- search_path(wheat_new, '[Wheat].Phenology.ThermalTime')
#' b$node$Children[[1]]$X
replace_model <- function(l, path, model) {
    path <- .check_path(l, path)
    path <- path[-1]
    eq <- 'l'
    for (i in seq(along = path)) {
        eq <- c(eq, '[["Children"]]', paste0('[[', path[i], ']]'))
    }
    eq <- c(eq, '<- model')
    eq_str <- paste(eq, collapse = '')
    eval(parse(text=eq_str))
    return(l)
}



#' Disable models in apsimx
#'
#' @param l the list of apsimx file
#' @param paths If numeric, the path returned by search_path or search_node. If character, the path supported by apsimx
#' @return The modified list with new value
#' @export
#' @examples
#' wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
#' a <- disable_models(wheat, '[Wheat].Phenology.ThermalTime')
disable_models <- function(l, paths) {
    i <- 1
    for (i in seq(along = paths)) {
        node_i <- search_path(l, paths[i])
        node_i$node$Enabled <- FALSE
        l <- replace_model(l, node_i$path, node_i$node)
    }
    return(l)
}



#' Remove a model with new values
#'
#' @param l the list of apsimx file
#' @param path If numeric, the path returned by search_path or search_node. If character, the path supported by apsimx
#' @return The modified list with new value
#' @export
#' @examples
#' wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
#' a <- search_path(wheat, '[Wheat].Phenology.ThermalTime')
#' wheat_new <- remove_model(wheat, a$path)
#' b <- search_path(wheat_new, '[Wheat].Phenology.ThermalTime')
#' b
remove_model <- function(l, path) {
    path <- .check_path(l, path)
    path <- path[-1]
    eq <- 'l'
    for (i in seq(along = path)) {
        eq <- c(eq, '[["Children"]]', paste0('[[', path[i], ']]'))
    }
    eq <- c(eq, '<- NULL')
    eq_str <- paste(eq, collapse = '')
    eval(parse(text=eq_str))
    return(l)
}


#' Insert a model into apsimx
#'
#' @param l the list of apsimx file
#' @param path If numeric, the path returned by search_path or search_node. If character, the path supported by apsimx
#' @param model A new model
#' @return The modified list with new value
#' @export
#' @examples
#' wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
#' replacements <- new_model("Core.Replacements")
#' wheat_new <- insert_model(wheat, 1, replacements)
#' replacements_node <- search_path(wheat_new, ".Simulations.Replacements")
#' replacements_node$path
#' # Add a cultivar folder under replacements
#' cultivar_folder <- new_model("PMF.CultivarFolder", "Cultivars")
#' wheat_new <- insert_model(wheat_new, replacements_node$path, cultivar_folder)
#' cultivar_folder_node <- search_path(wheat_new,
#'                                     ".Simulations.Replacements.Cultivars")
#' cultivar_folder_node$path
#' # Add an new cultivar
#' cultivar <- new_model("PMF.Cultivar", "Hartog")
#' wheat_new <- insert_model(wheat_new, cultivar_folder_node$path, cultivar)
#' cultivar_node <- search_path(wheat_new,
#'                              ".Simulations.Replacements.Cultivars.Hartog")
#' cultivar_node$path
insert_model <- function(l, path, model) {
    path <- .check_path(l, path)
    path <- path[-1]
    eq <- 'l'
    for (i in seq(along = path)) {
        eq <- c(eq, '[["Children"]]', paste0('[[', path[i], ']]'))
    }
    eq <- c(eq, '[["Children"]]')
    eq_str <- paste(eq, collapse = '')
    eq_str <- paste0(eq_str, '[[length(', eq_str, ')+1]] <- model')

    eval(parse(text=eq_str))
    return(l)
}



#' Insert models into apsimx
#'
#' @param l the list of apsimx file
#' @param path If numeric, the path returned by search_path or search_node. If character, the path supported by apsimx
#' @param models New models
#' @return The modified list with new value
#' @export
#' @examples
#' wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
#' replacements <- new_model("Core.Replacements")
#' wheat_new <- insert_model(wheat, 1, replacements)
#' replacements_node <- search_path(wheat_new, ".Simulations.Replacements")
#' replacements_node$path
#' # Add a cultivar folder under replacements
#' cultivar_folder <- new_model("PMF.CultivarFolder", "Cultivars")
#' wheat_new <- insert_model(wheat_new, replacements_node$path, cultivar_folder)
#' cultivar_folder_node <- search_path(wheat_new,
#'                                     ".Simulations.Replacements.Cultivars")
#' cultivar_folder_node$path
#' # Add an new cultivar
#' cultivar <- new_model("PMF.Cultivar", "Hartog")
#' wheat_new <- insert_model(wheat_new, cultivar_folder_node$path, cultivar)
#' cultivar_node <- search_path(wheat_new,
#'                              ".Simulations.Replacements.Cultivars.Hartog")
#' cultivar_node$path
insert_models <- function(l, path, models) {
    path <- .check_path(l, path)
    path <- path[-1]
    eq <- 'l'
    for (i in seq(along = path)) {
        eq <- c(eq, '[["Children"]]', paste0('[[', path[i], ']]'))
    }
    eq <- c(eq, '[["Children"]]')
    eq_str <- paste(eq, collapse = '')
    #eq_str <- paste0(eq_str, '[[length(', eq_str, ')+1]] <- models')
    eq_str <- paste0(eq_str, "<- c(", eq_str, ', models)')
    eval(parse(text=eq_str))
    return(l)
}


#' append a model into apsimx
#'
#' @param l the list of apsimx file
#' @param path If numeric, the path returned by search_path or search_node. If character, the path supported by apsimx
#' @param model A new model which should be a list of new models
#' @return The modified list with new value
#' @export
#' @examples
#' wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
#' replacements <- new_model("Core.Replacements")
#' wheat_new <- insert_model(wheat, 1, replacements)
#' replacements_node <- search_path(wheat_new, ".Simulations.Replacements")
#' replacements_node$path
#' # Add a cultivar folder under replacements
#' cultivar_folder <- new_model("PMF.CultivarFolder", "Cultivars")
#' wheat_new <- insert_model(wheat_new, replacements_node$path, cultivar_folder)
#' cultivar_folder_node <- search_path(wheat_new,
#'                                     ".Simulations.Replacements.Cultivars")
#' cultivar_folder_node$path
#' # Add an new cultivar
#' cultivar <- new_model("PMF.Cultivar", "Hartog")
#' wheat_new <- insert_model(wheat_new, cultivar_folder_node$path, cultivar)
#' cultivar_node <- search_path(wheat_new,
#'                              ".Simulations.Replacements.Cultivars.Hartog")
#' cultivar_node$path
#' # Append another cultivar
#' cultivar2 <- new_model("PMF.Cultivar", "Axe")
#' wheat_new <- append_model(wheat_new, cultivar_node$path, list(cultivar2))
#' cultivar2_node <- search_path(wheat_new,
#'                               ".Simulations.Replacements.Cultivars.Axe")
#' cultivar2_node$path
append_model <- function(l, path, model) {
    path <- .check_path(l, path)
    path <- path[-1]
    if (length(path) == 1) {
        stop("Path should be more than 1")
    }
    if (length(model) > 1) {
        stop("The length of new model should be equal to 1")
    }
    eq <- 'l'
    path1 <- path[-length(path)]
    path2 <- path[length(path)]
    for (i in seq(along = path1)) {
        eq <- c(eq, '[["Children"]]', paste0('[[', path[i], ']]'))
    }
    eq <- c(eq, '[["Children"]]')
    eq_str <- paste(eq, collapse = '')
    eq_str <- paste0(eq_str, ' <- append(', eq_str, ', model, ', path2, ')')

    eval(parse(text=eq_str))
    return(l)
}


#' Set a parameter with a new value
#'
#' @param l the list of apsimx file
#' @param parameter the name of parameter with APSIM NG specification
#' @param value the new value
#'
#' @return A list with replaced value
#' @export
#'
#' @examples
#'  wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
#'  new_wheat <- set_parameter_value(wheat,
#'   "[Structure].BranchingRate.PotentialBranchingRate.Reproductive.Zero.FixedValue",
#'   1)
#' new_wheat2 <- search_path(new_wheat,
#'     "[Structure].BranchingRate.PotentialBranchingRate.Reproductive.Zero")
#' new_wheat2$node$FixedValue
#'
#' new_wheat <- set_parameter_value(
#'     wheat,
#'     "[Structure].HeightModel.WaterStress.XYPairs.Y",
#'     "0.1,1.1")
#' new_wheat2 <- search_path(new_wheat,
#'     "[Structure].HeightModel.WaterStress.XYPairs")
#' new_wheat2$node$Y
set_parameter_value <- function(l, parameter, value) {
    if (length(parameter) != 1) {
        stop("Require parameter has length 1")
    }
    if (length(value) != 1) {
        stop("Require value has length 1")
    }
    if (!is.character(parameter)) {
        stop("Require parameter is character")
    }
    if (grepl("\\.FixedValue$", parameter)) {
        p_path <- gsub("\\.FixedValue$", "", parameter)
        p_node <- search_path(l, p_path)
        if (length(p_node) == 0) {
            stop('Parameter (', parameter, ') is not found')
        }
        p_node$node$FixedValue <- value
    } else if (grepl("\\.(X|Y)$", parameter)) {
        p_path <- gsub("\\.(X|Y)$", "", parameter)
        p_node <- search_path(l, p_path)
        if (length(p_node) == 0) {
            stop('Parameter (', parameter, ') is not found')
        }
        new_values <- strsplit(value, " *, *")[[1]]

        if (grepl("\\.X$", parameter)) {
            if (length(new_values) != length(p_node$node$X)) {
                stop("New value doesn't match the length for old values. ",
                        "Expect: ", paste(p_node$node$X, collapse = ","))
            }
            p_node$node$X <- as.list(new_values)
        } else if (grepl("\\.Y$", parameter)) {
            if (length(new_values) != length(p_node$node$Y)) {
                stop("New value doesn't match the length for old values. ",
                        "Expect: ", paste(p_node$node$Y, collapse = ","))
            }
            p_node$node$Y <- as.list(new_values)
        }
    } else  {
        # for node with special value
        p_path <- gsub("^(.+)\\.([a-zA-Z0-9]+)$", "\\1", parameter)
        p_name <- gsub("^(.+)\\.([a-zA-Z0-9]+)$", "\\2", parameter)
        if (nchar(p_name) == 0 || nchar(p_name) == nchar(parameter)) {
            stop("Parameter name is not found")
        }
        p_node <- search_path(l, p_path)
        if (length(p_node) == 0) {
            stop('Parameter (', parameter, ') is not found')
        }
        p_node$node[[p_name]] <- value
    }
    l <- replace_model(l, p_node$path, p_node$node)
    l
}
