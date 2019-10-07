library(testthat)
source('C:/users/boba-fett/Documents/school/2019Fall/discreet_biostatistics_project/graph.R')

g1 = list(c('a', 'b', 'c'), c('b', 'a', 'd', 'e'), c('c', 'a', 'f'), c('d', 'b'), c('e', 'b'), c('f', 'c'))
g2 = list(c(1, 3, 4), c(2, 4, 5), c(3, 1, 5), c(4, 1, 2), c(5, 2, 3))
edge1 <- c(1,2,3) #declare edge1
edge2 <- c(2,1,4) #declare edge2
edge3 <- c(3,5,6,7) #declare edge3
edge5 <- c(5,3) #declare edge5
edge6 <- c(6,3) #declare edge6
edge7 <- c(7,3) #declare edge7
graph <- list(edge1,edge2,edge3,edge5,edge6,edge7)

test_that('DFS works with the first test graph', {
  expect_equal(DFS('a', g1), C('a', 'b', 'd', 'e', 'c', 'f'))
  expect_equal(DFS('b', g1), C('b', 'a', 'c', 'f', 'd', 'e'))
  expect_equal(DFS('c', g1), C('c', 'a', 'b', 'd', 'e', 'f'))
  expect_equal(DFS('d', g1), C('d', 'b', 'a', 'c', 'f', 'e'))
  expect_equal(DFS('e', g1), C('e', 'b', 'a', 'c', 'f', 'd'))
  expect_equal(DFS('f', g1), C('f', 'c', 'a', 'b', 'd', 'e'))
})

test_that('DFS works with the second test graph', {
  expect_equal(DFS(1, g2), C(1, 3, 5, 2, 4))
  expect_equal(DFS(2, g2), C(2, 4, 1, 3, 5))
  expect_equal(DFS(3, g2), C(3, 1, 4, 2, 5))
  expect_equal(DFS(4, g2), C(4, 1, 3, 5, 2))
  expect_equal(DFS(5, g2), C(5, 2, 4, 1, 3))
})

test_that('DFS works with the third test graph',{
  expect_equal(DFS(1,graph),c(1,2,4,3,5,6,7))
  expect_equal(DFS(2,graph),c(2,1,3,5,6,7,4))
  expect_equal(DFS(3,graph),c(3,1,2,4,5,6,7))
  expect_equal(DFS(4,graph),c(4,2,1,3,5,6,7))
  expect_equal(DFS(5,graph),c(5,3,1,2,4,6,7))
  expect_equal(DFS(6,graph),c(6,3,1,2,4,5,7))
})

test_that('Find Neighbors works correctly',{
  expect_equal(find_neighbors(1,graph),c(1,2,3))
  expect_equal(find_neighbors(3,graph),c(3,1,5,6,7))
  expect_equal(find_neighbors(1,g2),c(1,3,4))
  expect_equal(find_neighbors(2,g2),c(2,4,5))
  expect_equal(find_neighbors(3,g2),c(3,1,5))
  expect_equal(find_neighbors(4,g2),c(4,1,2))
  expect_equal(find_neighbors(5,g2),c(5,2,3))
})
