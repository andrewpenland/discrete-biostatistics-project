##
# Hitting Time Testing
# Zane Billings
# Created 2019-09-19
# This function contains all of the unit tests for the hitting_time_functions.R
#  script.
##
library(testthat)
source("hitting_time_functions.R")

# Tests for the censor function

## Test 1: This test makes sure that the censor function creates bins and
# correctly sorts floating point numbers into the correct bin.
floating_point_numbers_test_result <- 
  data.frame(
    "binned_data" = seq(from = 2, to = 98, by = 4),
    "n" = rep(40, times = 25L)
  )
expect_identical(
  censor(seq(0.1, 100, .1), seq(from = 2, to = 98, by = 4)),
  floating_point_numbers_test_result
)