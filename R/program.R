
#' Create the minimum requirements to run an APSIM Next Generation
#'
#' @param install_path The installed path of APSIM Next Generation
#' @param output The output folder
#' @examples
#' \dontrun{
#'  minimum_apsimng("C:/ProgramFiles/APSIMNG", "minimum_apsimng")
#' }
#' @export
minimum_apsimng <- function(install_path, output) {
    if (!file.exists(output)) {
        dir.create(output)
    } else if (length(list.files(output, include.dirs = TRUE))) {
        stop("The output folder is not empty.")
    }
    base_files <- c("MathNet.Numerics.dll",
            "Models.exe",
            #"msvcr120.dll",
            "Newtonsoft.Json.dll",
            "sqlite3.dll",
            "zlib1.dll",
            "APSIM.Shared.dll",
            "FirebirdSql.Data.FirebirdClient.dll",
            "libsqlite3.so")
    files <- file.path(install_path, base_files)
    pos <- !file.exists(files)
    if (sum(pos) > 0) {
        stop("Files are not existed for ", paste(files[pos], collapse = ", "))
    }
    # Copy the APSIM files
    file.copy(files, file.path(output, basename(files)))

    if (file.exists('C:/Windows/SysWOW64/msvcr120.dll')) {
        file.copy('C:/Windows/SysWOW64/msvcr120.dll',
                  file.path(output, 'msvcr120.dll'))
    } else {
        warning('Cannot find C:/Windows/SysWOW64/msvcr120.dll. You have to manually copy it to model folder')
    }
    return(invisible())
}
