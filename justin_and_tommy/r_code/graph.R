##
# A Series of functions pertaining to graphs.
#
# @author Justin Clifton
# @author Tommy Meek
# @version October, 2019
##

##
# A Depth First Search of a graph. This function traverses a graph, starting 
# at a given vertex and proceding down each branch until a vertex is reached 
# with no new neghbors. It then recedes back up the branch and repeats the 
# process with each branch. When completed it returns a list of all the 
# verticies reachable from that vertex in the order in which they were 
# visited.
#
# @param vertex: the vertex from which to start
# @param graph: a vertex edge list
# @returns all verticies connected to the starting vertex in the order visited
##
DFS <- function (vertex, graph) {
  visited <- c()
  v_stack <- c(vertex) # LIFO vector containing verticies we are examining
  while (length(v_stack > 0)) {
    vertex <- v_stack[1] # examine the head of the stack for this itteration
    if (!vertex %in% visited) {
      visited <- append(visited, vertex) # add vertex to visited if not yet
    }
    tmp <- find_neighbors(vertex, graph) # tmp is the neighbors of vertex
    tmp <- tmp[!tmp %in% v_stack] # ensures no duplicates from to_visit
    tmp <- tmp[!tmp %in% visited] # ensures no duplicates from visited
    if (is.na(tmp[1])) {
      v_stack <- v_stack[-1] # pop first element off stack
    } else {
      v_stack <- append(tmp[1], v_stack) # pushes first neighbor onto stack
    }
  }
  return (visited)
} # end DFS()

##
# does not work as intended.
# functionality supplanted by the %in% operator.
#
# contains <- function (collection, item) {
#   return(length(collection[collection == item]) > 0)
# }

##
# finds all verticies ajacent to the given vertex and returns them in a list
# 
# @param vertex: the vertex of intrest
# @param graph: a vertex edge list
# @returns all the neighbors of the vertex
##
find_neighbors <- function (vertex, graph) {
  stopifnot(!is.na(vertex)) # ensures vertex is not NA
  i <- 1
  while (i <= length(graph)) {
    if (graph[[i]][1] == vertex) {
      neighbors <- graph[[i]]
    }
    i <- i + 1
  }
  return (neighbors[-1]) # [-1] gets rid of the first element
} # end find_neighbors()
