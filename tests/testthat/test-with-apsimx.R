suppressPackageStartupMessages(library(testthat))
test_that("with_apsimx", {

    # Get models
    models <- Sys.getenv("APSIMNG_MODELS")
    skip_if(nchar(models) == 0)
    skip_if_not(file.exists(models))

    # Get example file
    file <- system.file("extdata/wheat.apsimx", package = "rapsimng")
    skip_if_not(file.exists(file))

    mets <- system.file("extdata/example.met", package = "rapsimng")
    skip_if_not(file.exists(mets))

    expect_error({
        a <- with_apsimx("A", file, mets)
    })

    expect_error({
        a <- with_apsimx(models, "AAA", mets)
    })
    expect_error({
        a <- with_apsimx(models, file, "AAA")
    })

    expect_error({
        a <- with_apsimx(models, file, mets, csv = TRUE, clean = "no-type")
    })

    expect_no_error({
        a <- with_apsimx(models, file, mets, csv = TRUE, clean = "all")
    })

    expect_no_error({
        a <- with_apsimx(models, file, mets, csv = TRUE, clean = "simulations")
    })
    expect_warning({
        a <- with_apsimx(models, file, mets, csv = TRUE, clean = "mets")
    })


    post_process <- function(folder, para1 = 10) {
        output_files <- list.files(folder, full.names = TRUE)
        message(output_files)
        harvest_report <- output_files[grepl("HarvestReport", output_files)]
        if (length(harvest_report) == 0) {
            return(NULL)
        }
        read.csv(harvest_report)
    }

    expect_no_error({
        res <- with_apsimx(models, file, mets, csv = TRUE, clean = "all", post_process = post_process)
    })

    expect_equal(nrow(res), 12)


    post_process <- function(folder, para1 = 10) {
        return(para1)
    }
    expect_no_error({
        res <- with_apsimx(models, file, mets, csv = TRUE, clean = "all", post_process = post_process)
    })
    expect_equal(res, 10)

    expect_no_error({
        res <- with_apsimx(models, file, mets, csv = TRUE, clean = "all", post_process = post_process, para1 = 100)
    })
    expect_equal(res, 100)
})
