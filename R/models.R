# * Author:    Bangyou Zheng (Bangyou.Zheng@csiro.au)
# * Created:   02:53 PM Friday, 19 June 2020
# * Copyright: AS IS


# Models of APSIMNG

.read_assembly <- function() {
  file <- system.file("Models.xml", package = "RApsimNG")
  if (!file.exists(file)) {
    stop("Models.xml doesn't exist.")
  }
  res <- xml2::read_xml(file)
  res
}


#' Create a new model
#'
#' @param name The name of new model
#' @param namespace The namespace in the model
#'
#' @examples
#' new_model("Cultivar")
#' @export
new_model <- function(name, namespace = "PMF") {
  doc <- .read_assembly()
  # Find model
  m <- xml2::xml_find_first(doc, paste0('//member[@name="T:Models.', namespace, '.', name, '"]'))
  if (length(m) == 0) {
    stop("Cannot find the models with name ", name)
  }
  res <- list()
  res[["$type"]] <- paste0("Models.", namespace, ".", name, ", Models")

  res$Name <- name
  res$Children <- list()
  res$IncludeInDocumentation <- TRUE
  res$Enabled <- TRUE
  res$ReadOnly <- FALSE
  # Find attributes
  path <- paste0("//member[contains(@name, 'P:Models.", namespace,  ".", name, "')]")
  members <- xml2::xml_find_all(doc, xpath = path)
  for (i in seq(along = members)) {
    attr_name <- xml2::xml_attr(members[[i]], "name")
    attr_name <- gsub(paste0("P:Models\\.", namespace, "\\.", name, '\\.(.+)'), '\\1', attr_name)
    res[[attr_name]] <- list()
  }
  res
}
