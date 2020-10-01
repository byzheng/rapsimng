


# Internal code to check path
.check_path <- function(l, path) {
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
#' wheat <- read_apsimx(system.file("Wheat.json", package = "rapsimng"))
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


#' Remove a model with new values
#'
#' @param l the list of apsimx file
#' @param path If numeric, the path returned by search_path or search_node. If character, the path supported by apsimx
#' @return The modified list with new value
#' @export
#' @examples
#' wheat <- read_apsimx(system.file("Wheat.json", package = "rapsimng"))
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
#' wheat <- read_apsimx(system.file("wheat.apsimx", package = "rapsimng"))
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


#' append a model into apsimx
#'
#' @param l the list of apsimx file
#' @param path If numeric, the path returned by search_path or search_node. If character, the path supported by apsimx
#' @param model A new model which should be a list of new models
#' @return The modified list with new value
#' @export
#' @examples
#' wheat <- read_apsimx(system.file("wheat.apsimx", package = "rapsimng"))
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
