
get_node <- function(l) {
    if (methods::is(l, "apsimxNode")) {
        l <- l$node
    }
    if (!methods::is(l, "list")) {
        stop("A list object is required.")
    }
    l
}

#'
#' #' Convert a model into xypair
#' #'
#' #' @param l the list of apsimx file
#' #' @param lower The lower bound. The first value will be copied lower is not NULL
#' #' @param upper The upper bound. The last value will be copied upper is not NULL
#' #' @return a data.frame for X and Y values.
#' #'
#' #' @export
#' #' @examples
#' #' file <- system.file("extdata/wheat.apsimx", package = "rapsimng")
#' #' m <- read_apsimx(file)
#' #' potential <- search_path(m,
#' #'    path = '[Structure].BranchingRate.PotentialBranchingRate.Vegetative.PotentialBranchingRate')
#' #' xypair(potential)
#' xypair <- function(l, lower = NULL, upper = NULL) {
#'
#'     l_children <- l$node$Children
#'     if (is.null(l_children)) {
#'         stop('Children node is not found.')
#'     }
#'     x <- NULL
#'     Y <- NULL
#'     for (i in seq_along(l_children)) {
#'         if (!is.null(l_children[[i]]$`$type`) &&
#'             l_children[[i]]$`$type` == 'Models.Functions.XYPairs, Models') {
#'             X <- unlist(l_children[[i]]$X)
#'             Y <- unlist(l_children[[i]]$Y)
#'             break
#'         }
#'     }
#'     if (length(X) == 0 || length(Y) == 0) {
#'         stop('No values are found for X and Y.')
#'     }
#'     if (!is.null(lower)) {
#'         X <- c(lower, X)
#'         Y <- c(Y[1], Y)
#'     }
#'     if (!is.null(upper)) {
#'         X <- c(X, upper)
#'         Y <- c(Y, Y[length(Y)])
#'     }
#'     res <- data.frame(X = X, Y = Y)
#'     return(res)
#' }
#'
#'
#' #' The fixed value in the apsimx
#' #'
#' #' @param l the list of apsimx file
#' #' @export
#' #'
#' #' @return Value of this node
#' fixed_value <- function(l) {
#'     as.numeric(l$FixedValue)
#' }
