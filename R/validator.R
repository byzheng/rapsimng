#' Validate a thermaltime definition
#'
#' Checks that a thermaltime specification is a named list containing both `x`
#' and `y` vectors and that the vectors have the same length.
#'
#' @param value A list with `x` and `y` components defining the thermaltime
#'   relationship.
#'
#' @return This function returns `NULL` invisibly when the value is valid.
#'   Otherwise it stops with an informative error.
#'
#' @export
thermaltime_validator <- function(value) {
    if (!is.list(value) || !all(c("x", "y") %in% names(value))) {
        stop("thermaltime must be a list with both x and y")
    }
    if (length(value$x) != length(value$y)) {
        stop("thermaltime x and y must have same length")
    }
    if (!all(sapply(value$x, is.numeric)) || !all(sapply(value$y, is.numeric))) {
        stop("thermaltime x and y must be numeric vectors")
    }
    invisible(NULL)
}
