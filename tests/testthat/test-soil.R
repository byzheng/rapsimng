test_that("get_pawc", {
    wheat <- read_apsimx(system.file("extdata/wheat.apsimx", package = "rapsimng"))
    
    # Test basic PAWC calculation with LL15
    pawc <- get_pawc(wheat)
    expect_true(is.numeric(pawc))
    expect_equal(pawc, 361.23)
    expect_equal(length(pawc), 1)
    
    # Test PAWC with wheat crop-specific LL
    pawc_wheat <- get_pawc(wheat, crop = "Wheat")
    expect_true(is.numeric(pawc_wheat))
    expect_equal(pawc_wheat, 246.015)
    
    # Test PAWC with depth limit
    pawc_1000 <- get_pawc(wheat, depth = 1000)
    expect_true(is.numeric(pawc_1000))
    expect_true(pawc_1000 > 0)
    expect_true(pawc_1000 < pawc)  # Should be less than total
    
    # Test PAWC with non-existent crop (should use LL15)
    expect_warning({
        pawc_other <- get_pawc(wheat, crop = "Maize")
    })
    
    # Test error handling - invalid soil path
    expect_error({
        get_pawc(wheat, soil_path = "[InvalidSoil]")
    })
    
    # Test error handling - invalid depth
    expect_error({
        get_pawc(wheat, depth = -100)
    })
    
    expect_error({
        get_pawc(wheat, depth = "invalid")
    })
})
