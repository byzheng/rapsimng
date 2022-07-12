
#' Get the parent node from a path
#'
#' @param l the list of apsimx file
#' @param path If numeric, the path returned by search_path or search_node. If character, the path supported by apsimx
#'
#' @return A new list for parent
#' @export
#'
#' @examples
#' wheat <- read_apsimx(system.file("extdata/Wheat.json", package = "rapsimng"))
#' a <- search_path(wheat, '[Structure].BranchingRate')
#' get_parent(wheat, a$path)
get_parent <- function(l, path) {
    path <- .check_path(l, path)
    if (length(path) == 1) {
        stop("Already in the root for ", path)
    }
    if (length(path) == 2) {
        return (list(node = l, path = 1))
    }
    path <- path[-1]
    path <- path[-length(path)]
    eq <- 'l'
    for (i in seq(along = path)) {
        eq <- c(eq, '[["Children"]]', paste0('[[', path[i], ']]'))
    }
    eq_str <- paste(eq, collapse = '')
    eq_str <- paste0("l <- ", eq_str)
    eval(parse(text=eq_str))
    res <- list(node = l, path = c(1, path))
    res
}


