# * Author:    Bangyou Zheng (Bangyou.Zheng@csiro.au)
# * Created:   01:09 PM Thursday, 21 February 2019
# * Copyright: MIT


#' Find an element in the apsimx file
#'
#' @param l the list of apsimx file
#' @param ... Other names arguments for property
#'
#' @return A list matching all criterias
#' @export
#'
#' @examples
#' m <- read_json('https://raw.githubusercontent.com/APSIMInitiative/ApsimX/master/Models/Resources/Wheat.json')
#' # Find the potential branching rate
#' potential <- find_element(model,
#'             Name = 'PotentialBranchingRate',
#'             XProperty = "[Structure].LeafTipsAppeared")
find_element <- function(l, ...) {
  conds <- list(...)
  ele_names <- names(conds)


  if (!(!is.null(ele_names) && all(nchar(ele_names) > 0))) {
    stop('All elements should be named.')
  }
  r_find_element <- function(l, conds, ele_names){

    check <- TRUE
    for (i in seq(along = conds)) {
      check <- check && !is.null(l[[ele_names[i]]]) && l[[ele_names[i]]] == as.character(conds[i])
    }
    if (check) {
      return(l)
    }

    if (!is.null(l$Children)) {
      for (i in seq(along = l$Children)) {
        res <- r_find_element(l$Children[[i]], conds, ele_names)
        if (!is.null(res)) {
          return(res)
        }
      }
      return(res)

    }
  }
  r_find_element(l, conds, ele_names)
}


#' Find a xypair element in the apsimx file
#'
#' @param l the list of apsimx file
#' @param ... Other names arguments for property
#'
#' @return a data.frame for X and Y values.
#' @export
#'
#' @examples

#' m <- read_json('https://raw.githubusercontent.com/APSIMInitiative/ApsimX/master/Models/Resources/Wheat.json')
#' # Find the potential branching rate
#' potential <- find_element_xypair(model,
#'             Name = 'PotentialBranchingRate',
#'             XProperty = "[Structure].LeafTipsAppeared")

find_element_xypair <- function(l, ...) {
  r <- find_element(l, ...)
  data.frame(X = unlist(r$Children[[1]]$X),
             Y = unlist(r$Children[[1]]$Y))
}

