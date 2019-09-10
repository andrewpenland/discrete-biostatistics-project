hitting_time <- function(n, lambda) {
  simulated_times <- rexp(n = n, rate = lambda)
  maximum_simulated_time <- max(simulated_times)
  return(maximum_simulated_time)
}

armitage_doll <- function(n, lambda, trials) {
  res <- replicate(trials, hitting_time(n, lambda))
  return(res)
  # Censor data: x data is midpoints of bin-widths, y is count
}

censor <- function(data, bins) {
  # Make list of midpoints
  # Make list of counts
  # Delete any bins with 0 count
}

# lm(log(count)~log(midpoints)) from censor output
