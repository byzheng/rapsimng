
#' Estimate Plant Available Water Capacity (PAWC) from an apsimx file
#' 
#' This function calculates the Plant Available Water Capacity (PAWC) from soil 
#' properties in an APSIM Next Generation (.apsimx) file. PAWC represents the 
#' amount of water that can be stored in the soil and is available for plant uptake.
#' 
#' @details
#' 
#' PAWC represents the soil's water storage capacity between field capacity (DUL) and 
#' the permanent wilting point (LL). It is a critical parameter for:
#' 
#' PAWC is calculated for each soil layer using the formula:
#' 
#' **When crop = NULL and depth = NULL:**
#' \deqn{PAWC_i = (DUL_i - LL15_i) \times Thickness_i}
#' 
#' **When crop is specified:**
#' \deqn{PAWC_i = (DUL_i - LL_i) \times Thickness_i \times XF_i}
#' 
#' **When depth is specified (with or without crop):**
#' \deqn{PAWC_i = (DUL_i - LL_i) \times Thickness_i \times [XF_i] \times Weight_i}
#' 
#' Where:
#' \itemize{
#'   \item \strong{DUL} (Drained Upper Limit): The volumetric water content (mm/mm) 
#'         after the soil has drained under gravity, typically 2-3 days after saturation
#'   \item \strong{LL} (Lower Limit): The volumetric water content (mm/mm) below which 
#'         plants cannot extract water. This can be either:
#'         \itemize{
#'           \item \strong{LL15}: Generic lower limit at 15 bar suction (used when crop = NULL)
#'           \item \strong{Crop-specific LL}: Lower limit specific to a crop type, 
#'                 accounting for different rooting characteristics
#'         }
#'   \item \strong{Thickness}: Layer thickness in millimeters
#'   \item \strong{XF}: Exploration factor (0-1), representing the fraction of a layer 
#'         explored by roots. Only applied when crop is specified; represents the 
#'         proportion of the layer volume that roots can explore
#'   \item \strong{Weight}: Depth weighting factor (0-1), only applied when depth is specified:
#'         \itemize{
#'           \item 1.0 for layers completely within the specified depth
#'           \item Proportional fraction for layers partially within the depth
#'           \item 0.0 for layers completely beyond the specified depth
#'         }
#' }
#' 
#' The total PAWC is the sum across all layers:
#' \deqn{PAWC_{total} = \sum_{i=1}^{n} PAWC_i}
#' 
#' @param l The list of apsimx file
#' @param soil_path The path to the soil model. If NULL (default), searches for the 
#'   first Soil model. Can be a character string specifying the soil name.
#' @param crop The crop name for crop-specific lower limit (LL). 
#'   If NULL (default), uses LL15 and does not apply XF. If provided, uses the 
#'   crop-specific LL and XF values from the SoilCrop parameters.
#' @param depth The depth (in mm) to which PAWC should be calculated. 
#'   If NULL (default), calculates for all layers. If specified, applies proportional 
#'   weighting to layers that are partially or completely beyond this depth.
#'   
#' @return A numeric value of PAWC in mm
#' 
#' @export
#' 
#' @examples
#' wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
#' 
#' # Get total PAWC using LL15 (generic)
#' pawc <- get_pawc(wheat)
#' pawc
#' 
#' # Get PAWC for wheat crop (uses crop-specific LL and XF)
#' pawc_wheat <- get_pawc(wheat, crop = "Wheat")
#' pawc_wheat
#' 
#' # Get PAWC to 1200 mm depth
#' pawc_1200 <- get_pawc(wheat, depth = 1200)
#' pawc_1200
#' 
#' # Get wheat PAWC to 1500 mm depth
#' pawc_wheat_1500 <- get_pawc(wheat, crop = "Wheat", depth = 1500)
#' pawc_wheat_1500
get_pawc <- function(l, soil_path = NULL, crop = NULL, depth = NULL) {
    if (is.null(soil_path)) {
        soil_node <- search_node(l, `$type` = "Models.Soils.Soil, Models")
    } else {
        stopifnot(is.character(soil_path) && length(soil_path) == 1)
        soil_node <- search_path(l, soil_path)
    }
    # Find the soil node
    
    if (length(soil_node) == 0) {
        stop("Soil node not found at path: ", soil_path)
    }
    
    # Find the Physical node
    physical_node <- search_node(soil_node$node, 
                                `$type` = "Models.Soils.Physical, Models")
    if (length(physical_node) == 0) {
        stop("Physical node not found in soil")
    }
    
    # Get soil properties
    thickness <- unlist(physical_node$node$Thickness)
    dul <- unlist(physical_node$node$DUL)
    ll15 <- unlist(physical_node$node$LL15)
    
    if (length(thickness) == 0 || length(dul) == 0 || length(ll15) == 0) {
        stop("Required soil properties (Thickness, DUL, LL15) not found")
    }
    
    # Check if all vectors have the same length
    if (!(length(thickness) == length(dul) && length(dul) == length(ll15))) {
        stop("Soil property vectors have different lengths")
    }
    
    # Determine which LL to use
    ll <- ll15
    xf <- rep(1, length(ll))  # Default XF = 1 for LL15
    # If crop is specified, look for crop-specific LL
    if (!is.null(crop)) {
        stopifnot(is.character(crop) && length(crop) == 1)
        # Find SoilCrop node for the specified crop
        soil_crops <- search_node(physical_node$node, 
                                    `$type` = "Models.Soils.SoilCrop, Models",
                                    all = TRUE)
        
        crop_found <- FALSE
        for (i in seq_along(soil_crops)) {
            if (grepl(tolower(crop), tolower(soil_crops[[i]]$node$Name))) {
                crop_ll <- unlist(soil_crops[[i]]$node$LL)
                stopifnot(length(crop_ll) == length(thickness))
                xf <- unlist(soil_crops[[i]]$node$XF)
                stopifnot(length(xf) == length(crop_ll))
                ll <- crop_ll
                crop_found <- TRUE
                break
            }
        }
        
        if (!crop_found) {
            warning("Crop '", crop, "' not found in SoilCrop. Using LL15 instead.")
        }
    }
    
    # Calculate cumulative depth
    cum_depth <- cumsum(thickness)
    
    # Create weight vector based on depth parameter
    weight <- rep(1, length(thickness))
    
    if (!is.null(depth)) {
        if (length(depth) != 1 || !is.numeric(depth) || depth <= 0) {
            stop("depth must be a positive number")
        }
        
        for (i in seq_along(cum_depth)) {
            if (i == 1) {
                depth_from <- 0
            } else {
                depth_from <- cum_depth[i - 1]
            }
            depth_to <- cum_depth[i]
            
            if (depth_from >= depth) {
                # Layer is completely beyond the specified depth
                weight[i] <- 0
            } else if (depth_to > depth) {
                # Layer is partially within the specified depth
                weight[i] <- (depth - depth_from) / thickness[i]
            }
            # else: Layer is completely within depth, weight remains 1
        }
    }
    
    # Calculate PAWC for each layer (mm)
    pawc_layer <- (dul - ll) * thickness * xf * weight
    
    # Return total PAWC
    total_pawc <- sum(pawc_layer)
    
    return(total_pawc)
}

