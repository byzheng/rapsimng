
#' Get all cultivar parameters in a model
#'
#' @param l The list of apsimx file
#' @param alias Whether to export alias
#'
#' @return A data frame for all cultivar parameters
#' @export
#'
#' @examples
#' wheat <- read_apsimx(system.file("Wheat.json", package = "rapsimng"))
#' get_cultivar(wheat)
#' get_cultivar(wheat, alias = FALSE)
#'
get_cultivar <- function(l, alias = TRUE) {
    culs <- search_node(l, `$type` = "Models.PMF.Cultivar, Models", all = TRUE)
    if (length(culs) == 0) {
        stop("No cultivars found")
    }
    res <- list()
    k <- 0
    for (i in seq(along = culs)) {
        cul_name <- culs[[i]]$node$Name
        cmds <- unlist(culs[[i]]$node$Command)
        k <- k + 1
        res[[k]] <- tibble::tibble(name = cul_name, cmd = cmds)
        # for alias
        if (alias == TRUE && length(culs[[i]]$node$Children) > 0 ){
            aliases <- search_node(culs[[i]]$node, `$type` = 'Models.Core.Alias, Models', all = TRUE)
            if (length(aliases) > 0) {
                for (j in seq(along = aliases)) {
                    k <- k + 1
                    res[[k]] <- tibble::tibble(name = aliases[[j]]$node$Name,
                                               cmd = cmds)
                }
            }
        }
    }
    if (length(res) == 0) {
        stop("No cultivars found")
    }
    r <- dplyr::bind_rows(res) %>%
        dplyr::filter(grepl("=", .data$cmd)) %>%
        tidyr::separate(.data$cmd, into = c("parameter", "value"), sep = " *= *")
    r
}
