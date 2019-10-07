g2 = list(c(1, 3, 4), c(2, 4, 5), c(3, 1, 5), c(4, 1, 2), c(5, 2, 3))

##
# depth first search of a graph
#
# @param vertex: the vertex from which to start
# @param graph: a vertex edge list
# @returns a path containing all verticies connected to the starting vertex
##
DFS <- function (vertex, graph) {
  visited <- c()
  to_visit <- c()
  # mimics a do while loop. #
  repeat {
    append(visited, vertex)
    tmp <- find_neighbors(vertex, graph)
    tmp <- tmp[!contains(to_visit, tmp)] # ensures no duplicates from to_visit
    tmp <- tmp[!contains(visited, tmp)] # ensures no duplicates from visited
    to_visit <- append(tmp, to_visit) # pushes neighbors onto stack
    vertex <- to_visit[1]
    # TODO: remove first element from to_visit
    if (length(to_visit) == 0) {
      break
    }
  }
  return (visited)
}

contains <- function (collection, item) {
  return(length(collection[collection == item]) > 0)
}

##
# finds all verticies ajacent to the given vertex and returns them in a list
# 
# @param vertex: the vertex of intrest
# @param graph: a vertex edge list
# @returns all the neighbors of the vertex
##
find_neighbors <- function (vertex, graph) {
  i <- 1
  while (i <= length(graph)) {
    if (graph[[i]][1] == vertex) {
      neighbors <- graph[i]
    }
    i <- i + 1
  }
  #  mask <- c(0, 1, 1)
  #  neighbors <- neighbors[as.logical(mask)]
  return (neighbors)
}
