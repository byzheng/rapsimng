# * Author:    Bangyou Zheng (Bangyou.Zheng@csiro.au)
# * Created:   01:09 PM Thursday, 21 February 2019
# * Copyright: MIT


#' Find an element in the apsimx file
#'
#' @param l the list of apsimx file
#' @param ... Other names arguments for property
#'
#' @return A list matching all criterias
#' @export
#'
#' @examples
#' library(jsonlite)
#' m <- read_json('https://raw.githubusercontent.com/APSIMInitiative/ApsimX/master/Models/Resources/Wheat.json')
#' # Find the potential branching rate
#' potential <- search_node(m,
#'             Name = 'PotentialBranchingRate',
#'             XProperty = "[Structure].LeafTipsAppeared")
search_node <- function(l, ...) {
    conds <- list(...)
    ele_names <- names(conds)


    if (!(!is.null(ele_names) && all(nchar(ele_names) > 0))) {
        stop('All elements should be named.')
    }
    r_search_node <- function(l, conds, ele_names){

        check <- TRUE
        for (i in seq(along = conds)) {
            check <- check && !is.null(l[[ele_names[i]]]) && l[[ele_names[i]]] == as.character(conds[i])
        }
        if (check) {
            return(l)
        }

        if (!is.null(l$Children)) {
            res <- NULL
            for (i in seq(along = l$Children)) {
                res <- r_search_node(l$Children[[i]], conds, ele_names)
                if (!is.null(res)) {
                    return(res)
                }
            }
            return(res)
        }
    }
    return(r_search_node(l, conds, ele_names))
}



#' Find a model in the apsimx file using specified path
#'
#' @section Absolute Paths:
#' Absolute paths have a leading ‘.’ e.g.
#' \itemize{
#'   \item .Simulations.Test.Clock - absolute path - refers to the clock model
#' in the ‘Test’ simulation.
#' }
#'
#' @section Scoped Paths:
#' Scoped paths have a leading model type in square brackets. A model
#' of the specified name, in scope, is located before applying the rest of the path.
#' \itemize{
#'    \item [Soil].Water - scoped path - refers to the Water model that is a child of a model
#' that has the name ‘Soil’ that is in scope
#' }
#'
#' @param l the list of apsimx file
#' @param path The specified path (See details)

#' @return The list for the specified path.
#' @export
#'
#' @examples
#' library(jsonlite)
#' m <- read_json('https://raw.githubusercontent.com/APSIMInitiative/ApsimX/master/Models/Resources/Wheat.json')
#' # Find the potential branching rate
#' potential <- search_path(m,
#'                          path = '[Structure].BranchingRate.PotentialBranchingRate.Vegetative.PotentialBranchingRate')
search_path <- function(l, path, type = NULL) {
    if (length(path) != 1) {
        stop('Only one path is supported.')
    }
    path_type <- ifelse(grepl('^\\.', path), 'absolute',
                        ifelse(grepl('^\\[.*\\]\\.*', path), 'scoped', 'NotSupported'))
    if (path_type == 'NotSupported') {
        stop('The path is not supported.')
    }
    if (path_type == 'scoped') {
        name <- sub('^\\[(.*)\\]\\..*', '\\1', path)
        l <- search_node(l, Name = name)
        if (is.null(l)) {
            stop('The path is not found.')
        }
    }
    search_path <- sub('^(\\.|\\[.*\\]\\.)(.*)', '\\2', path)
    if (nchar(search_path) == 0) {
        stop('Path cannot be zero length.')
    }
    search_path <- strsplit(search_path, '\\.')[[1]]
    current_node <- l
    for (i in seq_along(search_path)) {
        current_node <- search_node(current_node, Name = search_path[i])
        if (is.null(current_node)) {
            stop('The path is not found.')
        }
    }
    return(current_node)
}

#' Convert a model into xypair
#'
#' @param l the list of apsimx file
#'
#' @return a data.frame for X and Y values.
#' @export
#'
#' @examples
#' library(jsonlite)
#' m <- read_json('https://raw.githubusercontent.com/APSIMInitiative/ApsimX/master/Models/Resources/Wheat.json')
#' # Find the potential branching rate
#' potential <- search_path(m,
#'                          path = '[Structure].BranchingRate.PotentialBranchingRate.Vegetative.PotentialBranchingRate')
#' convert_xypair(potential)
convert_xypair <- function(l) {

    l_children <- l$Children
    if (is.null(l_children)) {
        stop('Children node is not found.')
    }
    res <- NULL
    for (i in seq_along(l_children)) {
        if (!is.null(l_children[[i]]$`$type`) &&
            l_children[[i]]$`$type` == 'Models.Functions.XYPairs, Models') {
            res <- data.frame(X = unlist(l_children[[i]]$X),
                       Y = unlist(l_children[[i]]$Y))
            break
        }
    }
    return(res)
}

