# * Author:    Bangyou Zheng (Bangyou.Zheng@csiro.au)
# * Created:   02:53 PM Friday, 19 June 2020
# * Copyright: AS IS


# Models of APSIMNG
pkg_env <- new.env()
.read_assembly <- function() {

  if (!exists(".rapsimng_models", envir = pkg_env)) {

    file <- system.file("extdata/Models.Rds", package = "rapsimng")
    if (!file.exists(file)) {
      file <- "extdata/Models.Rds"
      if (!file.exists(file)) {
        stop("Models.xml doesn't exist.")
      }
    }
    .rapsimng_models <- readRDS(file)
    assign(".rapsimng_models", .rapsimng_models, envir = pkg_env)
  } else {
    .rapsimng_models <- get(".rapsimng_models", envir = pkg_env)
  }
  .rapsimng_models
}

#' List all available models in APSIM NG
#'
#' @return a character vector of available models
#' @export
#'
#' @examples
#' a <- available_models()
#' a[1:10]
available_models <- function() {
  models <- .read_assembly()
  # Find model
  names(models)
}


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
  models <- .read_assembly()
  # Find model
  m <- models[[model]]
  if (is.null(m)) {
    stop("Cannot find the models with name ", model)
  }
  m$Name <- name
  m
}
