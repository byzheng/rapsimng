

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
        stop(models_exe, " does not exist")
    }
    cmd <- paste0('"', models_exe, '" "', path, '"')
    # if (!is.null(pattern) && is.character(pattern)) {
    #     cmd <- paste0(cmd, " ", "--simulation-names ", pattern)
    # }
    if (is.logical(csv) && csv) {
        cmd <- paste0(cmd, " --csv")
    }
    if (verbose) {
        cmd <- paste0(cmd, " --verbose")
    }
    if (is.logical(recurse) && recurse) {
        cmd <- paste0(cmd, " --recursive")
    }
    if (is.logical(parallel) && !parallel) {
        cmd <- paste0(cmd, " --single-threaded ")
    }

    # if (is.logical(parallel) && parallel) {
    #     cmd <- paste0(cmd, " /MultiProcess")
    #     if (!is.null(ncpus) && is.numeric(ncpus) && ncpus > 0) {
    #         cmd <- paste0(cmd, " /NumberOfProcessors:", ncpus)
    #     }
    # }
    r <- system(cmd, intern = FALSE)
    if (r != 0) {
        stop("Failed to run apsimx: ", path)
    }
}


#' Run APSIM Next Generation Simulations in a Temporary Folder
#'
#' The `with_apsimx` function automates the process of setting up and running APSIM Next Generation (NG) simulations
#' in a temporary or specified folder. This approach helps reduce I/O overhead, particularly in high-performance
#' computing (HPC) environments with network file systems (NFS). The frequent file I/O operations performed by APSIM NG
#' (e.g., writing to SQLite databases) can strain file systems, and redirecting simulations to a local folder mitigates this issue.
#' The function can also perform optional post-processing of the simulation results.
#'
#' @param models A character string specifying the path to the APSIM NG executable (`Models.exe` on Windows
#'               or `Models` on Linux).
#' @param file A character string specifying the path to the `.apsimx` simulation file.
#' @param mets A character vector specifying paths to meteorological data (`.met` files) used in the simulation.
#'             Currently, only `.met` files located in the same folder as the `.apsimx` file are supported (optional).
#' @param target A character string specifying the target directory where simulations will be run.
#'               Defaults to the R system temporary directory (`tempdir()`).
#' @param clean A character string specifying which files or directories to clean after the simulation. Options are:
#'              \itemize{
#'                \item `"none"`: No files are cleaned (default).
#'                \item `"simulations"`: Cleans only simulation-related files (e.g., `*.apsimx`, `*.db`, `*.db-shm`, `*.db-wal`, `*.csv`).
#'                \item `"mets"`: Cleans only meteorological files (e.g., `*.met`).
#'                \item `"all"`: Cleans all files, including APSIM NG executable files, simulations, and meteorological files.
#'              }
#' @param post_process An optional function for post-processing simulation results.
#'                     The function must accept a `folder` argument specifying the directory
#'                     containing the simulation results.
#' @param ... Additional arguments passed to both the `run_models` and `post_process` functions.
#'
#' @return If a `post_process` function is provided, its return value is returned. Otherwise, the function returns `NULL`.
#'
#' @examples
#' \dontrun{
#' # Run simulations without post-processing
#' with_apsimx(
#'     models = "path/to/apsimx",
#'     file = "path/to/input.apsimx",
#'     mets = c("path/to/met1.met", "path/to/met2.met"),
#'     clean = "all"
#' )
#'
#' # Run simulations with post-processing
#' post_process_function <- function(folder) {
#'     output_files <- list.files(folder, full.names = TRUE)
#'     message("Output files:", paste(output_files, collapse = "\n"))
#' }
#'
#' result <- with_apsimx(
#'     models = "path/to/apsimx",
#'     file = "path/to/input.apsimx",
#'     mets = c("path/to/met1.met", "path/to/met2.met"),
#'     post_process = post_process_function
#' )
#' }
#'
#' @seealso
#' \code{\link{run_models}}: Runs APSIM simulations.
#' \code{\link{do.call}}: Dynamically calls functions with named arguments.
#'
#' @export
with_apsimx <- function(models, file, mets = NULL, target = tempdir(),
                        clean = c("none", "simulations", "mets", "all"),
                        post_process = NULL,
                        ...) {

    stopifnot(length(models) == 1)
    stopifnot(length(file) == 1)
    stopifnot(is.character(mets))
    stopifnot(is.character(target))
    stopifnot(file.exists(file))

    match.arg(clean)
    if ("none" %in% clean) {
        clean <- "none"
    }
    stopifnot(dir.exists(target))
    stopifnot(file.exists(models))

    if (!is.null(mets)) {
        if (!sum(file.exists(mets)) == length(mets)) {
            stop("Mets file is not existed")
        }
    }

    model_name <- if(.Platform$OS.type == "unix") {
        "Models"
    } else {
        "Models.exe"
    }

    # Create folder structure in the target folder (i.e. temp folder)
    # /apsimx for root folder

    folder_root <- file.path(target, "apsimx")
    dir.create(folder_root, showWarnings = FALSE)
    # Clean folder on exist
    if ("all" %in% clean) {
        on.exit(unlink(folder_root, recursive = TRUE))
    }
    stopifnot(file.exists(file.path(folder_root)))

    # /apsimx/models for apsimng Models.exe files
    folder_models <- file.path(folder_root, "models")
    dir.create(folder_models, showWarnings = FALSE)
    stopifnot(file.exists(file.path(folder_models)))

    # /apsimx/simulations for simulations
    folder_simulations <- file.path(folder_root, "simulation")
    dir.create(folder_simulations, showWarnings = FALSE)
    stopifnot(file.exists(file.path(folder_simulations)))
    # Clean simulations folder
    if ("simulations" %in% clean) {
        on.exit({
            old_files <- list.files(folder_simulations,
                                    "\\.(apsimx|db|db-shm|db-wal|csv)$",
                                    full.names = TRUE)
            a <- file.remove(old_files[file.exists(old_files)])
        })
    }
    if ("mets" %in% clean) {
        on.exit({
            old_files <- list.files(folder_simulations,
                                    "\\.(met)$",
                                    full.names = TRUE)
            a <- file.remove(old_files[file.exists(old_files)])
        })
    }

    # Copy execution files
    models_file <- file.path(folder_models, model_name)
    if (!file.exists(models_file)) {
        message("Copy ", model_name, " into ", folder_models)
        apsimx_files <- list.files(dirname(models), full.names = TRUE)
        a <- file.copy(apsimx_files, folder_models)
    }

    stopifnot(file.exists(models_file))

    # Copy apsimx and mets files
    file_new <- file.path(folder_simulations, basename(file))
    if (file.exists(file_new)) {
        warning("File is existed in target and overwrite: ", file_new)
    }
    file.copy(file, file_new, overwrite = TRUE)

    file_new_mets <- file.path(folder_simulations, basename(mets))
    if (sum(file.exists(file_new_mets)) > 0) {
        warning("Files are existed in target and ignore: ", file_new_mets)
    } else {
    # TO DO: Get mets file from apsimx and deal with subfolders
        a <- lapply(mets, file.copy, to = folder_simulations, overwrite = TRUE)
    }

    do_call2 <- function(fun, ...) {
        args <- list(...)
        args_names <- names(args)
        if (sum(nchar(args_names) == 0) > 0) {
            stop("All arguments should be named")
        }
        args_fun <- formals(fun)
        pos <- args_names %in% names(args_fun)
        a <- do.call(fun, args = args[pos])
        return(a)
    }
    do_call2(run_models, models_exe = models_file, path = file_new, ...)
    # post processing
    if (!is.null(post_process)) {
        stopifnot(is.function(post_process))
        res <- do_call2(post_process, folder = folder_simulations, ...)
        return(res)
    }
    return(invisible())
}
