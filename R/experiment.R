#' Get an experiment node by name
#'
#' @param apsimx A parsed APSIMX model from `read_apsimx()`.
#' @param experiment A single experiment name to locate.
#'
#' @return An `apsimxNode` object for the experiment.
#' @export
#'
#' @examples
#' wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
#' exp <- search_path(wheat, path = "[Experiment]")
#' get_experiment(wheat, exp$node$Name)
get_experiment <- function(apsimx, experiment) {
    stopifnot(is.list(apsimx) && length(apsimx) > 0)
    stopifnot(is.character(experiment) && length(experiment) == 1)
    experiment_node <- search_node(apsimx, "$type" = "Models.Factorial.Experiment, Models",
                "Name" = experiment)
    if (length(experiment_node) == 0) {
        stop("Experiment not found in the APSIMX file.")
    }
    return(experiment_node)
}

