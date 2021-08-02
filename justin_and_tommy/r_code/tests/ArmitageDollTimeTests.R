source('C:/Users/boba-fett/Documents/school/2019Fall/discreet_biostatistics_project/ArmitageDoll.R')

###
# tests the execution time of the hitting_time function
###
time_hitting_time <- function (num_cells, lambda) {
  start_time <- proc.time()
  hitting_time(num_cells, lambda)
  end_time <- proc.time()
  diff <- end_time - start_time
  time <- c(as.double(diff['elapsed']))
  return(time)
}

###
# tests the execution time of the popilation_sim function
###
time_population_sim <- function (num_cells, lambda, trials) {
  start_time <- proc.time()
  population_sim(num_cells, lambda, trials)
  end_time <- proc.time()
  diff <- end_time - start_time
  time <- as.double(diff['elapsed'])
  return(time)
}

###
# tests the execution time of the main function
###
time_main <- function (num_cells, lambda, trials, bins) {
  start_time <- proc.time()
  main(num_cells, lambda, trials, bins)
  end_time <- proc.time()
  diff <- end_time - start_time
  time <- as.double(diff['elapsed'])
  return(time)
}

vec <- c(100000, 400000, 1600000, 6400000, 25600000)
#result1 <- lapply(vec, time_hitting_time, lambda = .01)
#result2 <- lapply(vec, time_population_sim, num_cells = 7, lambda = .01)
result3 <- lapply(vec, time_main, num_cells = 7, lambda = .01, bins = c(0, 100, 10))
print(result1)
print(result2)
print(result3)