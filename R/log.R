
#' Set the log level of apsimx file
#'
#' @param l the list of apsimx file
#' @param level log level with option Error, Warning, Information, Diagnostic, All
#'
#' @return a new apsimx file
#' @export
log_level <- function(l, level = c("Error", "Warning", "Information", "Diagnostic", "All")) {
    level <- match.arg(level)
    Verbosity <- if (level == "Error") {
        0
    } else if (level == "Warning") {
        1
    } else if (level == "Information") {
        2
    } else if (level == "Diagnostic") {
        3
    } else if (level == "All") {
        100
    }

    summary_nodes <- search_node(l, all = TRUE, "$type" = "Models.Summary, Models")

    i <- 1
    for (i in seq(along = summary_nodes)) {
        summary_nodes[[i]]$node$Verbosity <- Verbosity
        l <- replace_model(l, summary_nodes[[i]]$path, summary_nodes[[i]]$node)
    }
    l
}
