
get_levels <- function(f) {
  r <- NULL

  if (!is.null(f$Specification) && f$Specification != "" &&
      !grepl('^\\[.+\\]$', f$Specification)) {
    pattern <- "^(\\[.+\\]\\..+ *= *)(.+)$"
    if (!grepl(pattern, f$Specification)) {
      stop("Specification should be as [SowingRule].Script.SowingDate = 2003-12-22")
    }
    levels <- gsub(pattern, "\\2", f$Specification)
    if (nchar(levels) == 0) {
      stop("No levels specified")
    }
    r <- strsplit(levels, ", *")[[1]]
  } else if (length(f$Children) > 0) {
    r <- unlist(lapply(f$Children, function(x) x$Name))
  } else {
    stop("Not supported factor")
  }
  r <- gsub("\\n", "", r)
  r <- gsub("\\r", "", r)
  return(r)
}

keep_level <- function(f, v) {
  # Check the value
  levels <- get_levels(f)
  pos <- !(v %in% levels)
  if (sum(pos) > 0) {
    stop("The value(s) (", paste(v[pos], collapse = ","),
         ") is not in the levels (", paste(levels, collapse = ", "), ")")
  }
  # In case of specification for levels
  if (!is.null(f$Specification) && f$Specification != "" &&
      !grepl('^\\[.+\\]$', f$Specification)) {
    pattern <- "^(\\[.+\\]\\..+ *= *)(.+)$"
    if (!grepl(pattern, f$Specification)) {
      stop("Specification should be as [SowingRule].Script.SowingDate = 2003-12-22")
    }
    specification_new <- gsub(pattern, "\\1", f$Specification)
    specification_new <- paste0(specification_new, paste(v, collapse = ", "))
    f$Specification <- specification_new
    # In case of multiple children
  } else if (length(f$Children) > 0) {
    new_children <- list()
    for (i in seq(along = f$Children)) {
      if (f$Children[[i]]$Name %in% v) {
        new_children[[length(new_children) + 1]] <- f$Children[[i]]
      }
    }
    f$Children <- new_children
  } else {
    stop("Not supported factor")
  }
  return(f)
}

get_factors <- function(l) {
  if (is.null(l$`$type`)) {
    stop("No $type element in the list")
  }
  factors <- NULL
  path <- 1
  if (l$`$type` == "Models.Factorial.Permutation, Models") {
    factors <- l
  } else if (l$`$type` == "Models.Factorial.Factors, Models") {
    # Find the permutation in the children
    perm <- search_path(l, "[Permutation]")
    if (length(perm) > 0) {
      factors <- perm$node
      path <- perm$path
    } else {
      if (length(l$Children) > 1) {
        stop("Not support for multiple factors in non permutation test.")
      }
      factors <- l
    }
  } else {
    stop("Not supported models type: ", l$`$type`)
  }
  if (length(factors) < 1) {
    stop("Not factors")
  }
  list(factors = factors, path = path)
}

#' Get simulations for a factorial experiment
#'
#' @param l A list from read_apsim with Factorial.Permutation as root.
#'
#' @return A list with Factor as name and Levels as values
#' @export
#' @examples
#' wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
#' permutation <- search_path(wheat, path = "[Factors].Permutation")
#' get_simulations(permutation$node)
get_simulations <- function(l) {
  factors <- get_factors(l)$factors$Children
  res <- list()
  for (i in seq(along = factors)) {
      if (factors[[i]]$`$type` == "Models.Memo, Models") {
        next
      }
      res[[as.character(factors[[i]]$Name)]] <- get_levels(factors[[i]])
  }
  res
}

#' Keep simulations for a factorial experiment
#'
#' @param l A list from read_apsim with Factorial.Permutation as root.
#' @param s a list with factor as name and levels as value to keep.
#' The factor is kept if it is not specified.
#' @return A new list with removed simulations.
#' @export
#' @examples
#' wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
#' permutation <- search_path(wheat, path = "[Factors].Permutation")
#' permutation_new <- keep_simulations(permutation$node, list(V = "2"))
#' get_simulations(permutation_new)
#'
#' permutation_new <- keep_simulations(permutation$node, list(Cv = c("Axe", "Bolac")))
#' get_simulations(permutation_new)
#'
#' permutation_new <- keep_simulations(permutation$node,
#'                                     list(V = "1", Cv = c("Axe", "Bolac")))
#' get_simulations(permutation_new)
keep_simulations <- function(l, s) {
  if (!methods::is(s, "list")) {
    stop("s requires as a list")
  }

  s_names <- names(s)
  pos <- is.null(s_names)
  if (sum(pos) > 0) {
    stop("All items of s should be named.")
  }

  info <- get_factors(l)
  factors_node <- info$factors
  factors <- factors_node$Children
  path <- info$path
  s_names <- names(s)
  for (i in seq(along = factors)) {
    if (factors[[i]]$Name %in% s_names) {
      factors[[i]] <- keep_level(factors[[i]], s[[factors[[i]]$Name]])
    } else {
      #l$Children[[i]] <- NULL
    }
  }
  factors_node$Children <- factors
  replace_model(l, path, factors_node)
}


#' Get the met file name for an experiment
#'
#' @param l A list or apsimxNode red by read_apsimx
#' @param is_stop Whether stop the function when error
#' @return The met file name in a experiment
#' @export
#'
#' @examples
#' wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
#' exp <- search_path(wheat, path = "[Experiment]")
#' get_metfile(exp)
get_metfile <- function(l, is_stop = TRUE) {
  l <- get_node(l)

  met_node <- search_path(l, "[Weather]")
  if (length(met_node) == 0) {
      if (is_stop) {
          stop("Weather node is not found.")
      } else {
          warning("Weather node is not found.")
          return(NULL)
      }
  }
  if (met_node$node$`$type` != "Models.Climate.Weather, Models") {
    stop("Weather node is not a Models.Climate.Weather")
  }
  met_name <- met_node$node$FileName
  if (is.null(met_name)) {
      if (is_stop) {
         stop("Cannot found element FileName")
      } else {
         warning("Cannot found element FileName")
         return(NULL)
      }
  }
  met_name
}
