

.frost_heat_param_names <- c(
    "FrostLowTT", "FrostMaxReductionRatio", "FrostUpTT", "FrostMinReductionRatio",
    "FrostStartSensitiveGS", "FrostStartMostSensitiveGS",
    "FrostEndMostSensitiveGS", "FrostEndSensitiveGS",
    "HeatLowTT", "HeatMinReductionRatio", "HeatUpTT", "HeatMaxReductionRatio",
    "HeatStartSensitiveGS", "HeatStartMostSensitiveGS",
    "HeatEndMostSensitiveGS", "HeatEndSensitiveGS"
)



.resolve_frost_heat_params <- function(params, crop = NULL) {
    if (!is.list(params)) {
        stop("'params' must be a list.")
    }

    if (all(.frost_heat_param_names %in% names(params))) {
        return(params)
    }

    if (is.null(crop) || length(crop) != 1 || !is.character(crop)) {
        stop("'crop' must be provided when 'params' is a named list of crops.")
    }
    if (!crop %in% names(params)) {
        stop("Crop '", crop, "' is not available in 'params'.")
    }

    params[[crop]]
}


.validate_frost_heat_inputs <- function(temp_min, temp_max, growth_stage, params) {
    if (!is.numeric(temp_min) || !is.numeric(temp_max) || !is.numeric(growth_stage)) {
        stop("'temp_min', 'temp_max', and 'growth_stage' must be numeric vectors.")
    }
    if (!all(length(temp_min) == length(temp_max),
             length(temp_min) == length(growth_stage))) {
        stop("'temp_min', 'temp_max', and 'growth_stage' must have the same length.")
    }

    missing_params <- setdiff(.frost_heat_param_names, names(params))
    if (length(missing_params) > 0) {
        stop("Missing required parameter(s): ", paste(missing_params, collapse = ", "))
    }
}



.check_numeric_vector <- function(x, name) {
    if (!is.numeric(x)) {
        stop("'", name, "' must be a numeric vector.")
    }
    if (length(x) < 1) {
        stop("'", name, "' must not be empty.")
    }
    if (any(!is.finite(x))) {
        stop("'", name, "' contains non-finite values.")
    }
}


.check_equal_length <- function(...) {
    args <- list(...)
    arg_names <- names(args)
    lengths <- vapply(args, length, FUN.VALUE = integer(1))
    if (length(unique(lengths)) > 1) {
        stop("'", paste(arg_names, collapse = "', '"), "' must have the same length.")
    }
}


.check_single_crop_params <- function(params, required = .frost_heat_param_names) {
    if (!is.list(params)) {
        stop("'params' must be a list.")
    }
    missing_params <- setdiff(required, names(params))
    if (length(missing_params) > 0) {
        stop("Missing required parameter(s): ", paste(missing_params, collapse = ", "))
    }
    params
}


.stage_sensitivity <- function(
    growth_stage,
    start_sensitive,
    start_most_sensitive,
    end_most_sensitive,
    end_sensitive
) {
    tidyweather::interpolation_function(
        x = c(start_sensitive, start_most_sensitive, end_most_sensitive, end_sensitive),
        y = c(0, 1, 1, 0),
        values = growth_stage
    )
}


#' Frost and Heat Damage Functions
#'
#' Helper and wrapper functions to calculate frost and heat damage from
#' temperature and growth stage.
#' 
#' @details 
#' 
#' The damage functions are based on the APSIM NG Model [FrostHeatDamageFunctions](https://github.com/APSIMInitiative/ApsimX/blob/3787815684da28c13467942b9d886fa04f54d4c6/Models/Functions/FrostHeatDamageFunctions.cs). See full documentation [here](https://notes.apsimng.bangyou.me/docs/Models/Functions/FrostHeatDamageFunctions.html).
#'
#' @name frost_heat_damage
NULL




#' Default Parameters For Frost And Heat Damage
#'
#' @rdname frost_heat_damage
#'
#' @return A named list with crop-specific parameter lists.
#' @export
#' @examples
#' default_frost_heat_params()
default_frost_heat_params <- function() {
    list(
        Wheat = list(
            FrostLowTT = -4.0, FrostMaxReductionRatio = 0.4,
            FrostUpTT = 1.0, FrostMinReductionRatio = 0,
            FrostStartSensitiveGS = 6.4854544,
            FrostStartMostSensitiveGS = 8.0,
            FrostEndMostSensitiveGS = 9.4983302,
            FrostEndSensitiveGS = 9.4990961,
            HeatLowTT = 30.3459986, HeatMinReductionRatio = 0,
            HeatUpTT = 34.0000667, HeatMaxReductionRatio = 0.2031898,
            HeatStartSensitiveGS = 7.2832313,
            HeatStartMostSensitiveGS = 7.483232,
            HeatEndMostSensitiveGS = 8.9709024,
            HeatEndSensitiveGS = 9.0945434
        ),
        Canola = list(
            FrostLowTT = -4.108862, FrostMaxReductionRatio = 0.3050003,
            FrostUpTT = -0.7549879, FrostMinReductionRatio = 0,
            FrostStartSensitiveGS = 7.222864,
            FrostStartMostSensitiveGS = 7.329504,
            FrostEndMostSensitiveGS = 8.063452,
            FrostEndSensitiveGS = 8.181088,
            HeatLowTT = 27.45271, HeatMinReductionRatio = 0,
            HeatUpTT = 38.8354, HeatMaxReductionRatio = 0.5810167,
            HeatStartSensitiveGS = 5.578273,
            HeatStartMostSensitiveGS = 6.260291,
            HeatEndMostSensitiveGS = 9.200536,
            HeatEndSensitiveGS = 9.428058
        )
    )
}

#' Frost Stage Sensitivity
#'
#' @rdname frost_heat_damage
#'
#' @param growth_stage Numeric vector of daily growth stage.
#' @param params A crop parameter list.
#'
#' @return A numeric vector of frost stage sensitivity (0-1).
#' @export
stage_sens_frost <- function(growth_stage, params) {
    .check_numeric_vector(growth_stage, "growth_stage")
    params <- .check_single_crop_params(
        params,
        required = c(
            "FrostStartSensitiveGS", "FrostStartMostSensitiveGS",
            "FrostEndMostSensitiveGS", "FrostEndSensitiveGS"
        )
    )

    .stage_sensitivity(
        growth_stage,
        params$FrostStartSensitiveGS,
        params$FrostStartMostSensitiveGS,
        params$FrostEndMostSensitiveGS,
        params$FrostEndSensitiveGS
    )
}


#' Heat Stage Sensitivity
#'
#' @rdname frost_heat_damage
#'
#' @param growth_stage Numeric vector of daily growth stage.
#' @param params A crop parameter list.
#'
#' @return A numeric vector of heat stage sensitivity (0-1).
#' @export
stage_sens_heat <- function(growth_stage, params) {
    .check_numeric_vector(growth_stage, "growth_stage")
    params <- .check_single_crop_params(
        params,
        required = c(
            "HeatStartSensitiveGS", "HeatStartMostSensitiveGS",
            "HeatEndMostSensitiveGS", "HeatEndSensitiveGS"
        )
    )

    .stage_sensitivity(
        growth_stage,
        params$HeatStartSensitiveGS,
        params$HeatStartMostSensitiveGS,
        params$HeatEndMostSensitiveGS,
        params$HeatEndSensitiveGS
    )
}


#' Frost Temperature Damage Function
#'
#' @rdname frost_heat_damage
#'
#' @param mint Numeric vector of daily minimum temperature.
#' @param params A crop parameter list.
#'
#' @return A numeric vector of frost damage contribution from temperature.
#' @export
temp_damage_frost <- function(mint, params) {
    .check_numeric_vector(mint, "mint")
    params <- .check_single_crop_params(
        params,
        required = c("FrostLowTT", "FrostUpTT", "FrostMaxReductionRatio", "FrostMinReductionRatio")
    )

    tidyweather::interpolation_function(
        x = c(params$FrostLowTT, params$FrostUpTT),
        y = c(params$FrostMaxReductionRatio, params$FrostMinReductionRatio),
        values = mint
    )
}


#' Heat Temperature Damage Function
#'
#' @rdname frost_heat_damage
#'
#' @param maxt Numeric vector of daily maximum temperature.
#' @param params A crop parameter list.
#'
#' @return A numeric vector of heat damage contribution from temperature.
#' @export
temp_damage_heat <- function(maxt, params) {
    .check_numeric_vector(maxt, "maxt")
    params <- .check_single_crop_params(
        params,
        required = c("HeatLowTT", "HeatUpTT", "HeatMinReductionRatio", "HeatMaxReductionRatio")
    )

    tidyweather::interpolation_function(
        x = c(params$HeatLowTT, params$HeatUpTT),
        y = c(params$HeatMinReductionRatio, params$HeatMaxReductionRatio),
        values = maxt
    )
}


#' Daily Frost Damage
#'
#' @rdname frost_heat_damage
#'
#' @param mint Numeric vector of daily minimum temperature.
#' @param growth_stage Numeric vector of daily growth stage.
#' @param params A crop parameter list.
#'
#' @return A numeric vector of daily frost damage.
#' @export
daily_damage_frost <- function(mint, growth_stage, params) {
    .check_numeric_vector(mint, "mint")
    .check_numeric_vector(growth_stage, "growth_stage")
    .check_equal_length(mint = mint, growth_stage = growth_stage)
    params <- .check_single_crop_params(params)

    temp_damage_frost(mint, params) * stage_sens_frost(growth_stage, params)
}


#' Daily Heat Damage
#'
#' @rdname frost_heat_damage
#'
#' @param maxt Numeric vector of daily maximum temperature.
#' @param growth_stage Numeric vector of daily growth stage.
#' @param params A crop parameter list.
#'
#' @return A numeric vector of daily heat damage.
#' @export
daily_damage_heat <- function(maxt, growth_stage, params) {
    .check_numeric_vector(maxt, "maxt")
    .check_numeric_vector(growth_stage, "growth_stage")
    .check_equal_length(maxt = maxt, growth_stage = growth_stage)
    params <- .check_single_crop_params(params)

    temp_damage_heat(maxt, params) * stage_sens_heat(growth_stage, params)
}


#' Daily Combined Frost And Heat Damage
#'
#' @rdname frost_heat_damage
#'
#' @param mint Numeric vector of daily minimum temperature.
#' @param maxt Numeric vector of daily maximum temperature.
#' @param growth_stage Numeric vector of daily growth stage.
#' @param params A crop parameter list.
#'
#' @return A numeric vector of combined daily frost and heat damage.
#' @export
daily_damage_frost_heat <- function(mint, maxt, growth_stage, params) {
    .check_numeric_vector(mint, "mint")
    .check_numeric_vector(maxt, "maxt")
    .check_numeric_vector(growth_stage, "growth_stage")
    .check_equal_length(mint = mint, maxt = maxt, growth_stage = growth_stage)
    params <- .check_single_crop_params(params)

    frost_damage <- daily_damage_frost(mint, growth_stage, params)
    heat_damage <- daily_damage_heat(maxt, growth_stage, params)
    1 - (1 - frost_damage) * (1 - heat_damage)
}


#' Cumulative Frost Damage
#'
#' @rdname frost_heat_damage
#'
#' @param mint Numeric vector of daily minimum temperature.
#' @param growth_stage Numeric vector of daily growth stage.
#' @param params A crop parameter list.
#'
#' @return A scalar cumulative frost damage.
#' @export
cum_damage_frost <- function(mint, growth_stage, params) {
    .check_numeric_vector(mint, "mint")
    .check_numeric_vector(growth_stage, "growth_stage")
    .check_equal_length(mint = mint, growth_stage = growth_stage)
    params <- .check_single_crop_params(params)

    1 - prod(1 - daily_damage_frost(mint, growth_stage, params))
}


#' Cumulative Heat Damage
#'
#' @rdname frost_heat_damage
#'
#' @param maxt Numeric vector of daily maximum temperature.
#' @param growth_stage Numeric vector of daily growth stage.
#' @param params A crop parameter list.
#'
#' @return A scalar cumulative heat damage.
#' @export
cum_damage_heat <- function(maxt, growth_stage, params) {
    .check_numeric_vector(maxt, "maxt")
    .check_numeric_vector(growth_stage, "growth_stage")
    .check_equal_length(maxt = maxt, growth_stage = growth_stage)
    params <- .check_single_crop_params(params)

    1 - prod(1 - daily_damage_heat(maxt, growth_stage, params))
}


#' Cumulative Combined Frost And Heat Damage
#'
#' @rdname frost_heat_damage
#'
#' @param mint Numeric vector of daily minimum temperature.
#' @param maxt Numeric vector of daily maximum temperature.
#' @param growth_stage Numeric vector of daily growth stage.
#' @param params A crop parameter list.
#'
#' @return A scalar cumulative frost and heat damage.
#' @export
cum_damage_frost_heat <- function(mint, maxt, growth_stage, params) {
    .check_numeric_vector(mint, "mint")
    .check_numeric_vector(maxt, "maxt")
    .check_numeric_vector(growth_stage, "growth_stage")
    .check_equal_length(mint = mint, maxt = maxt, growth_stage = growth_stage)
    params <- .check_single_crop_params(params)

    1 - (1 - cum_damage_frost(mint, growth_stage, params)) *
        (1 - cum_damage_heat(maxt, growth_stage, params))
}


#' Calculate Daily Frost And Heat Diagnostics
#'
#' @rdname frost_heat_damage
#'
#' @param mint Numeric vector of daily minimum temperature.
#' @param maxt Numeric vector of daily maximum temperature.
#' @param growth_stage Numeric vector of daily growth stage.
#' @param crop Crop name to use from `default_frost_heat_params()`.
#' @param params A crop parameter list. If provided, it will override the `crop` argument.
#'
#' @return A tibble with daily stage sensitivity, temperature damage, and daily
#'   frost/heat/combined damage.
#' @export
#' @examples
#' calc_daily_damage_frost_heat(
#'   mint = c(-2, 0, 4),
#'   maxt = c(29, 33, 36),
#'   growth_stage = c(7.0, 8.0, 9.0),
#'   crop = "Wheat"
#' )
calc_daily_damage_frost_heat <- function(
    mint, 
    maxt, 
    growth_stage, 
    crop = c("Wheat", "Canola"),
    params = NULL
) {
    .check_numeric_vector(mint, "mint")
    .check_numeric_vector(maxt, "maxt")
    .check_numeric_vector(growth_stage, "growth_stage")
    .check_equal_length(mint = mint, maxt = maxt, growth_stage = growth_stage)
    if (is.null(params)) {
        crop <- match.arg(crop)
        crop_params <- default_frost_heat_params()[[crop]]
    } else {
        crop_params <- params
    }
    .validate_frost_heat_inputs(mint, maxt, growth_stage, crop_params)

    tibble::tibble(
        mint = mint,
        maxt = maxt,
        growth_stage = growth_stage,
        stage_sens_frost = stage_sens_frost(growth_stage, crop_params),
        stage_sens_heat = stage_sens_heat(growth_stage, crop_params),
        temp_damage_frost = temp_damage_frost(mint, crop_params),
        temp_damage_heat = temp_damage_heat(maxt, crop_params),
        daily_damage_frost = daily_damage_frost(mint, growth_stage, crop_params),
        daily_damage_heat = daily_damage_heat(maxt, growth_stage, crop_params),
        daily_damage_frost_heat = daily_damage_frost_heat(mint, maxt, growth_stage, crop_params)
    )
}

#' Calculate Cumulative Frost And Heat Diagnostics
#'
#' @rdname frost_heat_damage
#'
#' @param mint Numeric vector of daily minimum temperature.
#' @param maxt Numeric vector of daily maximum temperature.
#' @param growth_stage Numeric vector of daily growth stage.
#' @param crop Crop name to use from `default_frost_heat_params()`.
#' @param params A crop parameter list. If provided, it will override the `crop` argument.
#'
#' @return A tibble with cumulative frost damage, cumulative heat damage, and
#'   cumulative combined frost-heat damage.
#' @export
#' @examples
#' calc_cum_damage_frost_heat(
#'   mint = c(-2, 0, 4),
#'   maxt = c(29, 33, 36),
#'   growth_stage = c(7.0, 8.0, 9.0),
#'   crop = "Wheat"
#' )
calc_cum_damage_frost_heat <- function(
    mint, 
    maxt, 
    growth_stage, 
    crop = c("Wheat", "Canola"),
    params = NULL
) {
    .check_numeric_vector(mint, "mint")
    .check_numeric_vector(maxt, "maxt")
    .check_numeric_vector(growth_stage, "growth_stage")
    .check_equal_length(mint = mint, maxt = maxt, growth_stage = growth_stage)
    crop <- match.arg(crop)
    if (is.null(params)) {
        crop_params <- default_frost_heat_params()[[crop]]
    } else {
        crop_params <- params
    }
    .validate_frost_heat_inputs(mint, maxt, growth_stage, crop_params)

    cum_frost <- cum_damage_frost(mint, growth_stage, crop_params)
    cum_heat <- cum_damage_heat(maxt, growth_stage, crop_params)
    cum_frost_heat <- cum_damage_frost_heat(mint, maxt, growth_stage, crop_params)
    tibble::tibble(
        cum_frost = cum_frost,
        cum_heat = cum_heat,
        cum_frost_heat = cum_frost_heat
    )
}

