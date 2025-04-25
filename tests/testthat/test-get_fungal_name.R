# tests/testthat/test-get_fungal_name.R

library(testthat)
library(dplyr)

test_that("get_fungal_name returns NA for genus names", {
  expect_warning({
    result <- get_fungal_name("Amanita")
  }, "The function can only update names for taxa classified as species")

  expect_equal(result, NA)
})

test_that("get_fungal_name returns updated name for species", {
  result <- get_fungal_name("Amanita muscaria")
  expect_equal(result, "Amanita muscaria")
})

test_that("get_fungal_name returns NA for unrecognized species", {
  expect_warning({
    result <- get_fungal_name("Amanita deliciosus")
  }, "Failed to query Index Fungorum")

  expect_equal(result, NA)
})

test_that("get_fungal_name handles missing or NA input", {
  result <- get_fungal_name(NA)
  expect_equal(result, NA)
})

test_that("get_fungal_name returns a character vector with add_info = FALSE", {
  result <- get_fungal_name("Lactarius deliciosus", add_info = FALSE)
  expect_true(is.character(result))
})
