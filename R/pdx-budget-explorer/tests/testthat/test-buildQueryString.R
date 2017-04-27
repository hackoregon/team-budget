library(testthat)

context("buildQueryString")

test_that("field and value delimited by =", {
  expect_equal(buildQueryString(fields = c("fiscal_year"), values = c("2016-17")), 
               "?fiscal_year=2016-17")
})

test_that("multiple parameters delimited by &", {
  expect_equal(buildQueryString(fields = c("fiscal_year", "bureau_code"), 
                                values = c("2016-17", "PK")), 
               "?fiscal_year=2016-17&bureau_code=PK")
})

test_that("Empty parameter spec returns empty string", {
  expect_equal(buildQueryString(), "")
  expect_equal(buildQueryString(fields = c()), "")
  expect_equal(buildQueryString(values = c()), "")
  expect_equal(buildQueryString(fields = c(), values = c()), "")
})

test_that("No field spec returns empty string, even if values are given", {
  expect_equal(buildQueryString(fields = c(), values = c("2016-17")), "")
})

test_that("Only field, value pairs are returned, even if there are other fields given", {
  expect_equal(buildQueryString(fields = c("fiscal_year", "bureau_code"), 
                                values = c("2016-17")), 
               "?fiscal_year=2016-17")
})
