# * Author:    Bangyou Zheng (Bangyou.Zheng@csiro.au)
# * Created:   02:53 PM Friday, 19 June 2020
# * Copyright: AS IS


# Models of APSIMNG

.read_assembly <- function() {
  file <- system.file("Models.xml", package = "rapsimng")
  if (!file.exists(file)) {
    stop("Models.xml doesn't exist.")
  }
  res <- xml2::read_xml(file)
  res
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
  doc <- .read_assembly()
  # Find model
  m <- xml2::xml_find_all(doc, paste0('//member[contains(@name,"T:Models.")]'))
  m <- xml2::xml_attr(m, "name")
  gsub("T:Models\\.", "", m)
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
  # remove name space
  if (name == model) {
    name <- gsub("^([a-zA-Z_]+)(\\.*)(.*)$", "\\3", model)
    if (nchar(name) == 0) {
      name <- model
    }
  }
  doc <- .read_assembly()
  # Find model
  m <- xml2::xml_find_first(doc, paste0('//member[@name="T:Models.', model, '"]'))
  if (length(m) == 0) {
    stop("Cannot find the models with name ", model)
  }
  res <- list()
  res[["$type"]] <- paste0("Models.", model, ", Models")

  res$Name <- name
  res$Children <- list()
  res$IncludeInDocumentation <- TRUE
  res$Enabled <- TRUE
  res$ReadOnly <- FALSE
  # Find attributes
  path <- paste0("//member[contains(@name, 'P:Models.",  model, "')]")
  members <- xml2::xml_find_all(doc, xpath = path)
  for (i in seq(along = members)) {
    attr_name <- xml2::xml_attr(members[[i]], "name")
    attr_name <- gsub(paste0("P:Models\\.", model, '\\.(.+)'), '\\1', attr_name)
    res[[attr_name]] <- list()
  }
  res
}
