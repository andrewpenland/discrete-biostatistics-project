library(testthat)
source(ArmitageDoll.R)
##
# hitting_time test
# Tommy Meek
# 09-19-19
##


##
# population_sim test
# Tommy Meek
# 09-19-19
##


##
# censor test
# Tommy Meek
# 09-19-19
##

##
# TEST 1
# evenly_spaced_float_test
# Asserts that censor sorts evenly spaced floating point numbers into correct bins.
##
evenly_spaced_float_test_result <- 
    data.frame(
        mids   = seq(from = 2, to = 98, by = 4),
        counts = rep(40, time = 25L)
    )
expect.identical(
    censor(seq(.1, 100, .1), c(0, 100, 4)), 
    evenly_spaced_float_test_result
)

##
# TEST 2
# 
# 
##

##
# log_log_fit test
# Tommy Meek
# 09-19-19
##


