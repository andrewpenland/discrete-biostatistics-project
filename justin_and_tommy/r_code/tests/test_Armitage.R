library(testthat)
source('C:/Users/Justin/Desktop/Work/ArmitageDoll.R')
test_that("Censor is right inclusive",{
  data <- c(1, 1.5 , 1.6 , 6 , 6 , 7.9 , 8.3 , 
           8.4, 8.8 ,8.5 ,9 ,10)
  midpoints <- c(0.5,1.5,5.5,7.5,8.5,9.5)
  counts <- c(1,2,2,1,5,1)
  censor_df <- censor(data,c(0,10,1))
  expect_equal(midpoints,censor_df$mids)
  expect_equal(counts,censor_df$counts)
}
)
test_that("Censor is producing correct values",{
  data <- c(1,1,1,5,6,6,7,8,8,8,8,9,10)
  midpoints <- c(0.5,4.5,5.5,6.5,7.5,8.5,9.5)
  counts <- c(3,1,2,1,4,1,1)
  censor_df <- censor(data,c(0,10,1))
  expect_equal(midpoints,censor_df$mids)
  expect_equal(counts,censor_df$counts)
}
)
test_that("Test that no columns greater than 80 are included", {
  data <- seq(0.1, 100, 0.1) #todo ask dr.penland if this is better than explicitly typing the vector
  censor_df <- censor(data,c(0,100,10))
  midpoints <- seq(5,75,10)
  counts <- c(100,100,100,100,100,100,100,100)
  expect_equal(midpoints,censor_df$mids)
  expect_equal(counts,censor_df$counts)
}
)
test_that("All datapoints fall in the same bin", {
  data <- seq(10.01,20,0.01)
  censor_df <- censor(data,c(0,50,10))
  midpoints <- c(15)
  counts <- c(1000)
  expect_equal(midpoints,censor_df$mids)
  expect_equal(counts, censor_df$counts)
})
test_that("Test with a large amount of data", {
  data <- seq(0.00001, 100, 0.00001) #todo ask dr.penland if this is better than explicitly typing the vector
  censor_df <- censor(data,c(0,100,10))
  midpoints <- seq(5,75,10)
  counts <- c(1000000,1000000,1000000,1000000,1000000,1000000,1000000,1000000)
  expect_equal(midpoints,censor_df$mids)
  expect_equal(counts,censor_df$counts)
})