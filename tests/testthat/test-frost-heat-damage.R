suppressPackageStartupMessages(library(testthat))

test_that("default_frost_heat_params returns expected crop list", {
    p <- default_frost_heat_params()
    expect_true(is.list(p))
    expect_true(all(c("Wheat", "Canola") %in% names(p)))
    expect_true(all(c("FrostLowTT", "HeatLowTT") %in% names(p$Wheat)))
})


test_that("stage_sens_frost returns valid values and validates input", {
    p <- default_frost_heat_params()$Wheat
    out <- stage_sens_frost(c(6.0, 8.0, 9.8), p)
    expect_equal(length(out), 3)
    expect_equal(out, c(0, 1, 0))
    expect_true(all(out >= 0 & out <= 1))
    expect_error(stage_sens_frost(c(6, NA), p))
})


test_that("stage_sens_heat returns valid values and validates input", {
    p <- default_frost_heat_params()$Wheat
    out <- stage_sens_heat(c(6.0, 8.0, 9.8), p)
    expect_equal(length(out), 3)
    expect_equal(out, c(0, 1, 0))
    expect_true(all(out >= 0 & out <= 1))

    expect_error(stage_sens_heat(c(6, Inf), p))
})


test_that("temp_damage_frost returns valid values and validates input", {
    p <- default_frost_heat_params()$Wheat
    out <- temp_damage_frost(c(-10, -2, 4), p)
    expect_equal(length(out), 3)
    expect_equal(out, c(0.4, 0.24, 0))
    expect_true(all(out >= 0 & out <= 1))

    expect_error(temp_damage_frost(character(0), p))
})


test_that("temp_damage_heat returns valid values and validates input", {
    p <- default_frost_heat_params()$Wheat
    out <- temp_damage_heat(c(25, 33, 40), p)
    expect_equal(length(out), 3)
    expect_true(all(out >= 0 & out <= 1))
    expect_equal(round(out, 4), c(0, 0.1476, 0.2032))
    expect_error(temp_damage_heat(c(25, NaN), p))
})


test_that("daily_damage_frost returns valid values and validates input", {
    p <- default_frost_heat_params()$Wheat
    out <- daily_damage_frost(c(-4, -2, 1), c(7, 8, 9), p)
    expect_equal(length(out), 3)
    expect_true(all(out >= 0 & out <= 1))
    expect_equal(round(out, 4), c(0.1359, 0.2400, 0))
    expect_error(daily_damage_frost(c(-4, -2), c(7), p))
    expect_error(daily_damage_frost(c(-4, -2, 1), c(7, 8, NA), p))
})


test_that("daily_damage_heat returns valid values and validates input", {
    p <- default_frost_heat_params()$Wheat
    out <- daily_damage_heat(c(30, 35, 38), c(7, 8, 9), p)
    expect_equal(length(out), 3)
    expect_true(all(out >= 0 & out <= 1))
    expect_equal(round(out, 4), c(0, 0.2032, 0.1554))
    expect_error(daily_damage_heat(c(30), c(7, 8), p))
})


test_that("daily_damage_frost_heat combines daily damage correctly", {
    p <- default_frost_heat_params()$Wheat
    mint <- c(-4, -2, 1)
    maxt <- c(30, 35, 38)
    gs <- c(7, 8, 9)

    df <- daily_damage_frost(mint, gs, p)
    dh <- daily_damage_heat(maxt, gs, p)
    out <- daily_damage_frost_heat(mint, maxt, gs, p)

    expect_equal(out, 1 - (1 - df) * (1 - dh))
    expect_error(daily_damage_frost_heat(c(-4), c(30, 35), c(7, 8), p))
})


test_that("cum_damage_frost returns scalar and expected formula", {
    p <- default_frost_heat_params()$Wheat
    mint <- c(-4, -2, 1)
    gs <- c(7, 8, 9)
    df <- daily_damage_frost(mint, gs, p)

    out <- cum_damage_frost(mint, gs, p)
    expect_equal(length(out), 1)
    expect_equal(out, 1 - prod(1 - df))
})


test_that("cum_damage_heat returns scalar and expected formula", {
    p <- default_frost_heat_params()$Wheat
    maxt <- c(30, 35, 38)
    gs <- c(7, 8, 9)
    dh <- daily_damage_heat(maxt, gs, p)

    out <- cum_damage_heat(maxt, gs, p)
    expect_equal(length(out), 1)
    expect_equal(out, 1 - prod(1 - dh))
})


test_that("cum_damage_frost_heat returns scalar and expected formula", {
    p <- default_frost_heat_params()$Wheat
    mint <- c(-4, -2, 1)
    maxt <- c(30, 35, 38)
    gs <- c(7, 8, 9)

    cf <- cum_damage_frost(mint, gs, p)
    ch <- cum_damage_heat(maxt, gs, p)
    out <- cum_damage_frost_heat(mint, maxt, gs, p)

    expect_equal(length(out), 1)
    expect_equal(out, 1 - (1 - cf) * (1 - ch))
})


test_that("calc_daily_damage_frost_heat returns expected columns", {
    out <- calc_daily_damage_frost_heat(
        mint = c(-4, 0, 5),
        maxt = c(25, 33, 40),
        growth_stage = c(6.5, 8.0, 9.3),
        crop = "Wheat"
    )

    expect_equal(nrow(out), 3)
    expect_true(all(c(
        "mint", "maxt", "growth_stage", "stage_sens_frost", "stage_sens_heat",
        "temp_damage_frost", "temp_damage_heat", "daily_damage_frost",
        "daily_damage_heat", "daily_damage_frost_heat"
    ) %in% names(out)))
    expect_error(calc_daily_damage_frost_heat(c(-1), c(30), c(7), crop = "Rice"))
})


test_that("calc_cum_damage_frost_heat returns expected columns", {
    out <- calc_cum_damage_frost_heat(
        mint = c(-4, 0, 5),
        maxt = c(25, 33, 40),
        growth_stage = c(6.5, 8.0, 9.3),
        crop = "Canola"
    )

    expect_equal(nrow(out), 1)
    expect_true(all(c("cum_frost", "cum_heat", "cum_frost_heat") %in% names(out)))
})

