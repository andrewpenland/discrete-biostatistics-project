##
# Hitting Time Regression
# Zane Billings
# Created 2019-09-04
# Provides functions to generate random Armitage-Doll model data, censor the 
#  data into midpoints and factor level counts, and perform log-log regression 
#  on the censored data.
##

# This loop installs the 'dplyr' package if not present, then loads it.
if (require('dplyr')==FALSE) {
  install.packages('dplyr', 
                   repos="https://cran.rstudio.com"); 
  require(dplyr)
}

# To-do:
#  Add ROxygen documentation?
#  Make pop. simulation more general.
#  Update censor function to bin with hist()?
#  Set up log_log_lm to accept a data frame OR two vectors.
#  Write a wrapper function that takes as input a simulation function and 
#   its parameters, and n, replicates it n times, does the log-log model and
#   returns the coefficients.
# Write at least six unit tests for these functions.

simulate_individual_hitting_time <- function(n, lambda) {
  # Inputs: n is an integer, lambda is numeric scalar.
  simulated_times <- rexp(n = n, rate = lambda)
  maximum_simulated_time <- max(simulated_times)
  return(maximum_simulated_time)
  # Output is numeric scalar.
}

simulate_population_hitting_time <- function(n, lambda, trials) {
  # Inputs: n is an integer, lambda is numeric, trials is an integer.
  # Need to update this so it more generally takes in an individual simulation
  #  function and its parameters, instead of only this specific Armitage-Doll
  #  simualtion function.
  res <- replicate(trials, hitting_time(n, lambda))
  return(res)
  # Outputs a numeric vector.
}

censor <- function(data, bins) {
  # Inputs: data and bins are both numeric vectors
  midpoints <- (bins[2:length(bins)] + bins[1:(length(bins)-1)]) / 2
  
  # Group data into bins
  binned_data <- cut(data, breaks = bins, labels = midpoints)
  # Note. The cut function returns NA when a number is higher than the largest
  # bin size. What to do about this? Is this working as intended for us?
  
  # Group data into a data frame, and count factor level occurances.
  # Additionally, make midpoints a numeric value, and remove all midpoints
  # where the count within the bin is 0.
  dirty_data <- as.data.frame(binned_data) %>% 
    group_by(binned_data) %>% 
    summarize(n = length(binned_data))
  
  # Clean up the data: remove empty bins, and make the midpoint a number.
  # Binned data has to go from fct -> str -> num, because fct -> num
  #  returns R's intrinsic factor levels rather than the values.
  censored_data <- dirty_data %>% 
    mutate(binned_data = as.numeric(paste(binned_data))) %>% 
    filter(., n != 0)
  
  # Return the cleaned midpoint data.
  return(censored_data)
}

# Take in two numeric vectors IN ORDER and compute the log of both vectors. 
#  Then, fit a linear model to the logs. This essentially fits a power law
#  model to the data.
log_log_lm <- function(x,y) {
  logx <- log(x)
  logy <- log(y)
  model <- lm(logy~logx)
  return(model)
}

# Take in a log-log linear model object, extract coefficients and return
#  "un-transformed coefficients".

untransform_power_law_coefs <- function(model) {
  coefs <- model$coefficients #entry one is the intercept, two is the slope
  # Recall a power law is of the form y = ax^b
  scale_parameter <- e^coefs[[1]] # This "un-transforms" the a parameter.
  exponent <- coefs[[2]] # Doesn't need to be "un-transformed".
  output_vector <- list(scale_parameter,exponent)
  return(output_vector)
}

# End of file.