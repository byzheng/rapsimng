# * Author:    Bangyou Zheng (Bangyou.Zheng@csiro.au)
# * Created:   01:09 PM Thursday, 21 February 2019
# * Copyright: MIT


#' Find element(s) in  apsimx file
#'
#' @param l The list of apsimx file
#' @param all Whether to find all elements
#' @param max_depth The maximum depth to search
#' @param case_insensitive Whether case sensitive
#' @param ... Other names arguments for property to match
#'
#' @return A list matching all criteria if all equals to TRUE,
#' A list with node and path if all equals to FALSE (default)
#' @export
#'
#' @examples
#' wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
#' # Return empty list if not found
#' search_node(wheat, Name = "Simulations1")
#' # Find root level
#' a <- search_node(wheat, Name = "Simulations")
#' a$path
#' # Find sub-level
#' a <- search_node(wheat, Name = "Wheat")
#' a$path
#' a <- search_node(wheat, `$type` = "Models.PMF.Cultivar, Models")
#' a$path
#'
#' # Find multiple attributes
#' a <- search_node(wheat,
#'             Name = 'PotentialBranchingRate',
#'             `$type` = "Models.Functions.PhaseLookup, Models")
#' a$path
#' a$node$Name
#' # Find all cultivar nodes
#'  a <- search_node(wheat, `$type` = "Models.PMF.Cultivar, Models", all = TRUE)
#' length(a)

search_node <- function(l, all = FALSE, max_depth = 1000000,
                        case_insensitive = TRUE, ...) {
    conds <- list(...)
    if (case_insensitive) {
        conds <- lapply(conds, tolower)
    }
    ele_names <- names(conds)

    if (!(!is.null(ele_names) && all(nchar(ele_names) > 0))) {
        stop('All elements should be named.')
    }
    r_search_node <- function(l, conds, ele_names, max_depth, cdepth,
                              cpath = 1, all = FALSE, result = list(),
                              case_insensitive = case_insensitive){
        check <- TRUE
        for (i in seq(along = conds)) {
            if (case_insensitive) {
                check <- check && !is.null(l[[ele_names[i]]]) &&
                    tolower(l[[ele_names[i]]]) == as.character(conds[i])

            } else {
                check <- check && !is.null(l[[ele_names[i]]]) &&
                    l[[ele_names[i]]] == as.character(conds[i])
            }

        }
        if (check) {
            # assign('l', l, .GlobalEnv)
            # stop()
            r <- list()
            r$node <- l
            r$path <- cpath[-length(cpath)]
            r$path <- cpath
            class(r) <- 'apsimxNode'
            result[[length(result) + 1]] <- r
            if (!all) {
                return (result)
            }
        }
        if (cdepth > max_depth) {
            return (result)
        }
        if (!is.null(l$Children) && length(l$Children) > 0) {
            for (i in seq(along = l$Children)) {

                result <- r_search_node(l$Children[[i]], conds, ele_names, max_depth, cdepth + 1,
                                     cpath = c(cpath, i), result = result,
                                     case_insensitive = case_insensitive)
            }
        }
        return (result)
    }
    res <- r_search_node(l, conds, ele_names, max_depth, 1, all = all,
                         case_insensitive = case_insensitive)
    if (length(res) == 0) {
        return (res)
    }
    if (!all) {
        if (length(all) != 1) {
            stop("Require 1 element if all = TRUE")
        }
        res <- res[[1]]
    }
    return(res)
}

#' Find a model in the apsimx file using specified path
#'
#' @section Absolute Paths:
#' Absolute paths have a leading ‘.’ e.g.
#' \itemize{
#'   \item .Simulations.Test.Clock - absolute path - refers to the clock model
#' in the 'Test' simulation.
#' }
#'
#' @section Scoped Paths:
#' Scoped paths have a leading model type in square brackets. A model
#' of the specified name, in scope, is located before applying the rest of the path.
#' \itemize{
#'    \item [Soil].Water - scoped path - refers to the Water model that is a child of a model
#' that has the name 'Soil' that is in scope
#' }
#'
#' @param l the list of apsimx file
#' @param path The specified path (See details)
#' @param case_insensitive Whether case sensitive

#' @return The list for the specified path.
#' @export
#'
#' @examples
#' wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
#' # Return empty list if not found
#' search_path(wheat, "[Simulations1]")
#' # Search root path
#' a <- search_path(wheat, '.Simulations')
#' a$path
#' a$node$Name
#' # Level one
#' a <- search_path(wheat, '.Simulations.Wheat1')
#' a$path
#' a$node$Name
#' # Level two
#' a <- search_path(wheat, '.Simulations.Wheat')
#' a$path
#' a$node$Name
#' # Level three
#' a <- search_path(wheat, '.Simulations.Wheat.BranchingRate')
#' a$path
#' a$node$Name
#' a <- search_path(wheat, '.Simulations.Wheat.Structure')
#' a$path
#' a$node$Name
#' # Level four
#' a <- search_path(wheat, '.Simulations.Wheat.Structure.BranchingRate')
#' a$path
#' a$node$Name
#' a <- search_path(wheat, '.Simulations.Wheat.Structure.BranchingRate1')
#' a$path
#' a$node$Name
#' # scoped
#' # Root path
#' a <- search_path(wheat, '[Simulations1]')
#' a <- search_path(wheat, '[Simulations]')
#' a$path
#' a$node$Name
#' # Level two
#' a <- search_path(wheat, '[Simulations].Wheat1')
#' a <- search_path(wheat, '[Simulations1].Wheat')
#' a$path
#' a$node$Name
#' a <- search_path(wheat, '[Whea]')
#' a <- search_path(wheat, '[Wheat]')
#' a$path
#' a$node$Name
#' # Level three
#' a <- search_path(wheat, '[Wheat].BranchingRate')
#' a <- search_path(wheat, '[Wheat].Structure')
#' a$path
#' a$node$Name
#' a <- search_path(wheat, '[Structure]')
#' a$path
#' a$node$Name
#' # Level four
#' a <- search_path(wheat, '[Structure].BranchingRate')
#' a$path
#' a$node$Name
#' a <- search_path(wheat, '[Structure].BranchingRate1')
#' a <- search_path(wheat, '[Structure1].BranchingRate')
search_path <- function(l, path, case_insensitive = TRUE) {
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
        l <- search_node(l, Name = name, case_insensitive = case_insensitive)
        if (is.null(l$node)) {
            return(list())
        }
    } else if (path_type == 'absolute') {
        l <- list(node = l, path = c(1))
    }

    if (nchar(path) == 0) {
        return(l)
    }
    search_path_str <- sub('^\\.', '', path)
    search_path_str <- strsplit(search_path_str, '\\.')[[1]]

    current_node <- l
    for (i in seq_along(search_path_str)) {
        old_path <- current_node$path
        current_node <- search_node(current_node$node, Name = search_path_str[i], max_depth = 1,
                                    case_insensitive = case_insensitive)
        if (is.null(current_node$node)) {
            return (list())
        }
        current_node$path <- c(old_path, current_node$path[-1])
        if (is.null(current_node$node)) {
            return (list())
        }
    }
    return(current_node)
}


