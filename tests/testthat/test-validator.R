suppressPackageStartupMessages(library(testthat))

test_that("thermaltime_validator accepts valid input", {
    value <- list(x = c(0, 5, 10), y = c(0, 2, 4))

    expect_null(thermaltime_validator(value))
})


test_that("thermaltime_validator requires x and y", {
    expect_error(
        thermaltime_validator(list(x = c(0, 5))),
        "thermaltime must be a list with both x and y"
    )
})


test_that("thermaltime_validator requires matching vector lengths", {
    value <- list(x = c(0, 5, 10), y = c(0, 2))

    expect_error(
        thermaltime_validator(value),
        "thermaltime x and y must have same length"
    )
})


test_that("thermaltime_validator requires numeric vectors", {
    value <- list(x = c("1", 5, 10), y = c(0, 2, 2))

    expect_error(
        thermaltime_validator(value),
        "thermaltime x and y must be numeric vectors"
    )
    value <- list(x = c(1, 5, 10), y = c(0, 2, "2"))

    expect_error(
        thermaltime_validator(value),
        "thermaltime x and y must be numeric vectors"
    )
})
