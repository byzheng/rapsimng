# * Author:    Bangyou Zheng (Bangyou.Zheng@csiro.au)
# * Created:   01:09 PM Thursday, 21 February 2019
# * Copyright: MIT

# Internal code to check path
.check_path <- function(l, path) {
    if (all(is.numeric(path))) {
        return(path)
    } else if (length(path) == 1 && is.character(path)) {
        return(search_path(l, path)$path)
    }
    stop("not implemented")
}

#' Read APSIMX file
#'
#' @param path The file path or URL to apsimx file
#'
#' @return A list object of apsimx file
#' @export
#'
#' @examples
#' m <- read_apsimx('https://raw.githubusercontent.com/APSIMInitiative/ApsimX/master/Models/Resources/Wheat.json')
read_apsimx <- function(path) {

    jsonlite::read_json(path, simplifyDataFrame = FALSE,
                       simplifyVector = FALSE, simplifyMatrix = FALSE)
}


#' Write APSIMX file
#'
#' @param l the list of apsimx file
#' @param path The file path to apsimx file
#'
#' @return A list object of apsimx file
#' @export
write_apsimx <- function(l, file) {
    jsonlite::write_json(l, file, pretty = TRUE, auto_unbox = TRUE, null = 'null')
}


#' Find an element in the apsimx file (first occurrence)
#'
#' @param l the list of apsimx file
#' @param max_depth The maximum depth to search
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
search_node <- function(l, max_depth = 1000000, ...) {
    conds <- list(...)
    ele_names <- names(conds)


    if (!(!is.null(ele_names) && all(nchar(ele_names) > 0))) {
        stop('All elements should be named.')
    }
    r_search_node <- function(l, conds, ele_names, max_depth, cdepth){
        check <- TRUE
        for (i in seq(along = conds)) {
            check <- check && !is.null(l[[ele_names[i]]]) && l[[ele_names[i]]] == as.character(conds[i])
        }
        if (check) {
            return(l)
        }
        if (cdepth > max_depth) {
            return (NULL)
        }
        if (!is.null(l$Children)) {
            res <- NULL
            for (i in seq(along = l$Children)) {

                res <- r_search_node(l$Children[[i]], conds, ele_names, max_depth, cdepth + 1)
                if (!is.null(res)) {
                    if (is.null(res$path)) {
                        res <- list(node = res)
                        res$path <- i
                    } else {
                        res$path <- c(i, res$path)
                    }
                    return(res)
                }
            }
            return(res)
        }
    }
    res <- r_search_node(l, conds, ele_names, max_depth, 1)

    if (!is.null(res) && is.null(res$node) && is.null(res$path)) {
        res <- list(node = res, path = NULL)
    }
    return(res)
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
search_path <- function(l, path) {
    if (length(path) != 1) {
        stop('Only one path is supported.')
    }
    path_type <- ifelse(grepl('^\\.', path), 'absolute',
                        ifelse(grepl('^\\[.*\\]\\.*', path), 'scoped', 'NotSupported'))
    if (path_type == 'NotSupported') {
        stop('The path is not supported.')
    }
    if (path_type == 'scoped') {
        name <- sub('^\\[(.*)\\].*', '\\1', path)
        path <- sub('^\\[(.*)\\](.*)', '\\2', path)
        l <- search_node(l, Name = name)
        if (is.null(l$node)) {
            stop('The path is not found.')
        }
    } else if (path_type == 'absolute') {
        l <- list(node = l, path = NULL)
    }

    if (nchar(path) == 0) {
        return(l)
    }
    search_path <- sub('^\\.', '', path)
    search_path <- strsplit(search_path, '\\.')[[1]]

    current_node <- l
    for (i in seq_along(search_path)) {
        old_path <- current_node$path

        current_node <- search_node(current_node$node, Name = search_path[i], max_depth = 1)
        current_node$path <- c(old_path, current_node$path)
        if (is.null(current_node$node)) {
            stop('The path is not found.')
        }
    }
    return(current_node)
}


#' Replace a model with new values
#'
#' @param l the list of apsimx file
#' @param path If numeric, the path returned by search_path or search_node. If character, the path supported by apsimx
#' @param model A new model
#' @return The modified list with new value
#' @export
#'
replace_model <- function(l, path, model) {
    path <- .check_path(l, path)
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
#'
remove_model <- function(l, path) {
    path <- .check_path(l, path)
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
#'
insert_model <- function(l, path, model) {
    path <- .check_path(l, path)
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
#' @param model A new model
#' @return The modified list with new value
#' @export
#'
append_model <- function(l, path, model) {
    path <- .check_path(l, path)
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

#' Convert a model into xypair
#'
#' @param l the list of apsimx file
#' @param lower The lower bound. The first value will be copied lower is not NULL
#' @param upper The upper bound. The last value will be copied upper is not NULL
#' @return a data.frame for X and Y values.
#' @export
#'
#' @examples
#' library(jsonlite)
#' m <- read_json('https://raw.githubusercontent.com/APSIMInitiative/ApsimX/master/Models/Resources/Wheat.json')
#' # Find the potential branching rate
#' potential <- search_path(m,
#'                          path = '[Structure].BranchingRate.PotentialBranchingRate.Vegetative.PotentialBranchingRate')
#' xypair(potential)
xypair <- function(l, lower = NULL, upper = NULL) {

    l_children <- l$node$Children
    if (is.null(l_children)) {
        stop('Children node is not found.')
    }
    x <- NULL
    Y <- NULL
    for (i in seq_along(l_children)) {
        if (!is.null(l_children[[i]]$`$type`) &&
            l_children[[i]]$`$type` == 'Models.Functions.XYPairs, Models') {
            X <- unlist(l_children[[i]]$X)
            Y <- unlist(l_children[[i]]$Y)
            break
        }
    }
    if (length(X) == 0 || length(Y) == 0) {
        stop('No values are found for X and Y.')
    }
    if (!is.null(lower)) {
        X <- c(lower, X)
        Y <- c(Y[1], Y)
    }
    if (!is.null(upper)) {
        X <- c(X, upper)
        Y <- c(Y, Y[length(Y)])
    }
    res <- data.frame(X = X, Y = Y)
    return(res)
}


#' The fixed value in the apsimx
#'
#' @param l the list of apsimx file
#'
#' @return Value of this node
#' @export
fixed_value <- function(l) {
    as.numeric(l$FixedValue)
}
