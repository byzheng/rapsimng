#' Test whether all files under published folder of apsimx are required
#'
#' @param base the base folder path to apsimx publish
#' @param example an example apsimx file
#'
#' @return A vector a required files
test_apsimx <- function(base, example) {
    #Sys.setenv(PATH = "")
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
        tryCatch({
            rapsimng::run_models(models_exe, example)
        }, error = function(e) {
            message(all_files[i], " is required.")
            required_files <- get('required_files', envir = env)
            required_files2 <- c(required_files, all_files[i])
            assign("required_files", required_files2, envir = env)
        })
        file.rename(new_files[i], all_files[i])
    }

    required_files <- get("required_files", envir = env)
    unrequired_files <- all_files[!(all_files %in% required_files)]
    message("Unrequired files: \"", paste0(unrequired_files, collapse = ", "), "\"")
    required_files
}
