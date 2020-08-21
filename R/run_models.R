

#' Run apsimx file using Models.exe
#'
#' @param models_exe  path to Models.exe
#' @param path The path to an .apsimx file. May include wildcard.
#' @param pattern Use to filter simulation names to run.
#' @param recurse  Recursively search subdirectories for files matching ApsimXFileSpec. FALSE in default.
#' @param csv  Export all reports to .csv files. FALSE in default.
#' @param parallel Use the multi-process job runner. If FALSE, use single threaded; if TRUE, use the multi-process job runner
#' @param ncpus  Set the number of processors to use. All processes in default
#' @param verbose Write messages to StdOut when a simulation starts/finishes. Only has an effect when running a directory of .apsimx files (*.apsimx).
#'
#' @export
run_models <- function(models_exe, path,
                       pattern = NULL,
                       recurse = FALSE,
                       csv = FALSE,
                       parallel = NULL,
                       ncpus = NULL,
                       verbose = FALSE) {
    if (!file.exists(models_exe)) {
        stop("Models.exe does not exist")
    }
    cmd <- paste0('"', models_exe, '" "', path, '"')
    if (!is.null(pattern) && is.character(pattern)) {
        cmd <- paste0(cmd, " ", "/SimulationNameRegexPattern:", pattern)
    }
    if (is.logical(csv) && csv) {
        cmd <- paste0(cmd, " /Csv")
    }
    if (verbose) {
        cmd <- paste0(cmd, " /Verbose")
    }
    if (is.logical(recurse) && recurse) {
        cmd <- paste0(cmd, " /Recurse")
    }
    if (is.logical(parallel) && !parallel) {
        cmd <- paste0(cmd, " /SingleThreaded")
    }

    if (is.logical(parallel) && parallel) {
        cmd <- paste0(cmd, " /MultiProcess")
        if (!is.null(ncpus) && is.numeric(ncpus) && ncpus > 0) {
            cmd <- paste0(cmd, " /NumberOfProcessors:", ncpus)
        }
    }
    r <- system(cmd, intern = FALSE)
    if (r != 0) {
        stop("Failed to run apsimx: ", path)
    }
}
