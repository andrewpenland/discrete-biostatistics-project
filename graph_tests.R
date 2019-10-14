library(testthat)
## usage: source('absolute/path/graph.R') ##

##
# A Series of tests pertaining to graphs.
#
# @author Justin Clifton
# @author Tommy Meek
# @version October, 2019
##

# declaring graphs.
g1 = list(c('a', 'b', 'c'), c('b', 'a', 'd', 'e'), c('c', 'a', 'f'), c('d', 'b'), c('e', 'b'), c('f', 'c'))
g2 = list(c(1, 3, 4), c(2, 4, 5), c(3, 1, 5), c(4, 1, 2), c(5, 2, 3))
edge1 <- c(1,2,3) #declare edge1
edge2 <- c(2,1,4) #declare edge2
edge3 <- c(3,1,5,6,7) #declare edge3
edge4 <- c(4,2) #declare edge4
edge5 <- c(5,3) #declare edge5
edge6 <- c(6,3) #declare edge6
edge7 <- c(7,3) #declare edge7
g3 <- list(edge1,edge2,edge3,edge4,edge5,edge6,edge7)

# testing DFS with g1
test_that('DFS works with the first test graph', {
  expect_equal(DFS('a', g1), c('a', 'b', 'd', 'e', 'c', 'f'))
  expect_equal(DFS('b', g1), c('b', 'a', 'c', 'f', 'd', 'e'))
  expect_equal(DFS('c', g1), c('c', 'a', 'b', 'd', 'e', 'f'))
  expect_equal(DFS('d', g1), c('d', 'b', 'a', 'c', 'f', 'e'))
  expect_equal(DFS('e', g1), c('e', 'b', 'a', 'c', 'f', 'd'))
  expect_equal(DFS('f', g1), c('f', 'c', 'a', 'b', 'd', 'e'))
})

# testing DFS with g2
test_that('DFS works with the second test graph', {
  expect_equal(DFS(1, g2), c(1, 3, 5, 2, 4))
  expect_equal(DFS(2, g2), c(2, 4, 1, 3, 5))
  expect_equal(DFS(3, g2), c(3, 1, 4, 2, 5))
  expect_equal(DFS(4, g2), c(4, 1, 3, 5, 2))
  expect_equal(DFS(5, g2), c(5, 2, 4, 1, 3))
})

# testing DFS with g3
test_that('DFS works with the third test graph', {
  expect_equal(DFS(1, g3),c(1,2,4,3,5,6,7))
  expect_equal(DFS(2, g3),c(2,1,3,5,6,7,4))
  expect_equal(DFS(3, g3),c(3,1,2,4,5,6,7))
  expect_equal(DFS(4, g3),c(4,2,1,3,5,6,7))
  expect_equal(DFS(5, g3),c(5,3,1,2,4,6,7))
  expect_equal(DFS(6, g3),c(6,3,1,2,4,5,7))
})

# testing find_neighbors with g1
test_that('Find Neighbors works with the first test graph', {
  expect_equal(find_neighbors('a',g1),c('b','c'))
  expect_equal(find_neighbors('b',g1),c('a','d','e'))
  expect_equal(find_neighbors('c',g1),c('a','f'))
  expect_equal(find_neighbors('d',g1),c('b'))
  expect_equal(find_neighbors('e',g1),c('b'))
  expect_equal(find_neighbors('f',g1),c('c'))
})

# testing find_neighbors with g2
test_that('Find Neighbors works with the second test graph', {
  expect_equal(find_neighbors(1,g2),c(3,4))
  expect_equal(find_neighbors(2,g2),c(4,5))
  expect_equal(find_neighbors(3,g2),c(1,5))
  expect_equal(find_neighbors(4,g2),c(1,2))
  expect_equal(find_neighbors(5,g2),c(2,3))
})

# testing find_neighbors with g3
test_that('Find Neighbors works with the third test graph', {
  expect_equal(find_neighbors(1,g3),c(2,3))
  expect_equal(find_neighbors(2,g3),c(1,4))
  expect_equal(find_neighbors(3,g3),c(1,5,6,7))
  expect_equal(find_neighbors(4,g3),c(2))
  expect_equal(find_neighbors(5,g3),c(3))
  expect_equal(find_neighbors(6,g3),c(3))
  expect_equal(find_neighbors(7,g3),c(3))
})
