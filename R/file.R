
#' Read APSIMX file
#'
#' @param path The file path or URL to apsimx file
#'
#' @return A list object of apsimx file
#' @export
#'
#' @examples
#' file <- system.file("extdata/wheat.apsimx", package = "rapsimng")
#' m <- read_apsimx(file)
read_apsimx <- function(path) {

    jsonlite::read_json(path, simplifyDataFrame = FALSE,
                        simplifyVector = FALSE, simplifyMatrix = FALSE)
}


#' Write APSIMX file
#'
#' @param l the list of apsimx file
#' @param file The file path to apsimx file
#'
#' @return A list object of apsimx file
#' @export
write_apsimx <- function(l, file) {
    jsonlite::write_json(l, file, pretty = TRUE, auto_unbox = TRUE, null = 'null')
}
