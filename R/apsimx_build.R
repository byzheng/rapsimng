#' Test whether all files under published folder of apsimx are required
#'
#' @param base the base folder path to apsimx publish
#' @param example an example apsimx file
#'
#' @return A vector a required files
test_apsimx <- function(base, example) {
    # Sys.setenv(PATH = "")
    Sys.unsetenv("PATH")
    models_exe <- file.path(base, "Models.exe")
    all_files <- list.files(base, "*.dll$", full.names = TRUE, include.dirs = FALSE)

    required_files <- c("Models.exe")
    env <- new.env()
    assign("required_files", required_files, envir = env)

    all_files <- all_files[!(basename(all_files) %in% required_files)]

    new_files <- paste0(all_files, ".bak")
    i <- 1
    for (i in seq(along = all_files)) {
        file.rename(all_files[i], new_files[i])
        tryCatch(
            {
                rapsimng::run_models(models_exe, example)
            },
            error = function(e) {
                message(all_files[i], " is required.")
                required_files <- get("required_files", envir = env)
                required_files2 <- c(required_files, all_files[i])
                assign("required_files", required_files2, envir = env)
            }
        )
        file.rename(new_files[i], all_files[i])
    }

    required_files <- get("required_files", envir = env)
    unrequired_files <- all_files[!(all_files %in% required_files)]
    message("Unrequired files: \"", paste0(unrequired_files, collapse = ", "), "\"")
    required_files
}


#' Install ApsimNG Software
#'
#' This function installs the ApsimNG simulation software on the local system.
#' It handles the download and installation process for the APSIM Next Generation
#' agricultural modeling platform.
#'
#' @param repo Character string specifying the repository of ApsimNG to install.
#' @param branch Character string specifying the branch of the repository to install.
#' @param install_dir Character string specifying the directory where ApsimNG
#'   should be installed.
#' @param overwrite Logical. If TRUE, overwrites any existing installation
#'   at the specified install directory.
#' @return No return value.
#'
#' @details
#' This function downloads and installs ApsimNG from the official repository.
#' It performs version checking, handles dependencies, and configures the
#' installation for use with R. The function requires administrative privileges
#' on Windows systems.
#'
#' @examples
#' \dontrun{
#' # Install latest version
#' install_apsimng()
#' install_apsimng(install_dir = "C:/MyPrograms/ApsimNG")
#' }
#'
#' @export
install_apsimng <- function(
    repo = "https://github.com/APSIMInitiative/ApsimX.git",
    branch = "master",
    install_dir = "apsimx_build", 
    overwrite = FALSE
) {
    # Check arguments
    stopifnot(is.character(repo), length(repo) == 1)
    stopifnot(is.character(branch), length(branch) == 1)
    stopifnot(is.character(install_dir), length(install_dir) == 1)
    stopifnot(is.logical(overwrite), length(overwrite) == 1)

    # Check dependencies
    if (Sys.which("git") == "") {
        stop("Git is not available in PATH. Please install Git and ensure it's accessible.")
    }
    if (Sys.which("dotnet") == "") {
        stop(".NET SDK is not available in PATH. Please install .NET SDK and ensure it's accessible.")
    }

    # Set up directories
    target_dir <- file.path(tempdir(), paste0("apsim_ng_", Sys.getpid()))
    target_dir <- normalizePath(target_dir)
    if (dir.exists(target_dir)) {
        unlink(target_dir, recursive = TRUE, force = TRUE)
    }
    
    dir.create(target_dir, recursive = TRUE, showWarnings = FALSE)
    
    install_dir <- normalizePath(path.expand(install_dir), mustWork = FALSE)

    if (dir.exists(install_dir)) {
        warning("Install directory already exists: ", install_dir)
        if (!overwrite) {
            stop("Set 'overwrite = TRUE' to overwrite existing installation.")
        }
        unlink(install_dir, recursive = TRUE)
    }
    dir.create(install_dir, recursive = TRUE, showWarnings = FALSE)


    # Clone repo
    # git clone --filter=blob:none --sparse
    system2("git", c(
        "clone", "--depth=1", "--filter=blob:none", "--sparse",
        "-b", branch, repo, target_dir
    ))

    system2("git", c("-C", target_dir, "sparse-checkout", "set",
        "Models", "APSIM.Shared", "APSIM.Core", "DeepCloner.Core"
    ))


    message("Fetching APSIM NG source...")
    system2("git", c("clone", "--depth", "1", "-b", branch, repo, target_dir))

    # Build using .NET
    message("Compiling APSIM NG with .NET SDK...")
    csproj_path <- file.path(target_dir, "Models", "Models.csproj")
    result <- system2(
        "dotnet",
        c("build", csproj_path, "-c", "Release", "-o", install_dir),
        stdout = TRUE, stderr = TRUE
    )

    if (result != 0) stop("Build failed. Check .NET SDK and repo status.")

    # Clean build artifacts
    message("Cleaning temporary files...")
    unlink(target_dir, recursive = TRUE, force = TRUE)

    message("APSIM NG built successfully at: ", install_dir)
    return(invisible(install_dir))
}
