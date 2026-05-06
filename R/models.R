
#' Create a new model
#'
#' @param model The name of new model
#' @param name The new name
#'
#' @examples
#' new_model(model = "PMF.Cultivar")
#' new_model(model = "PMF.Cultivar", name = "example")
#' @export
new_model <- function(model, name = model) {
    if (length(model) != 1 || length(name) != 1) {
        stop("Only support 1 character value model")
    }
    # remove name space
    if (name == model) {
        name <- gsub("^([a-zA-Z_]+)(\\.*)(.*)$", "\\3", model)
        if (nchar(name) == 0) {
        name <- model
        }
    }
    models <- .get_models()
    # Find model
    m <- models[[model]]
    if (is.null(m)) {
        stop("Cannot find the models with name ", model)
    }
    m$Name <- name
    m
}


.get_models <- function() {
    define <- list(
        "PMF.Cultivar" = list(
            "$type" = "Models.PMF.Cultivar, Models",
            "Command" =  list(),
            "Name" = "Cultivar",
            "ResourceName" = NULL,
            "Children" = list(),
            "Enabled" = TRUE,
            "ReadOnly" = TRUE
        ), 
        "Core.Folder" = list(
            "$type" = "Models.Core.Folder, Models",
            "ShowInDocs" = FALSE,
            "Name" = "Folder",
            "ResourceName" = NULL,
            "Children" = list(),
            "Enabled" = TRUE,
            "ReadOnly" = FALSE
        )
    )
    define[["Core.Replacements"]] <- define[["Core.Folder"]]
    define[["Core.Replacements"]]$Name <- "Replacements"
    define[["PMF.CultivarFolder"]] <- define[["Core.Folder"]]
    define[["PMF.CultivarFolder"]]$Name <- "CultivarFolder"
    define
}