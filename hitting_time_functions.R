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

hitting_time <- function(n, lambda) {
  # Inputs: n is an integer, lambda is numeric.
  simulated_times <- rexp(n = n, rate = lambda)
  maximum_simulated_time <- max(simulated_times)
  return(maximum_simulated_time)
  # Output is numeric
}

armitage_doll <- function(n, lambda, trials) {
  # Inputs: n is an integer, lambda is numeric, trials is an integer.
  res <- replicate(trials, hitting_time(n, lambda))
  return(res)
  # Outputs a numeric vector
}

censor <- function(data, bins) {
  # Inputs: data and bins are both numeric vectors
  midpoints = (bins[2:length(bins)] + bins[1:(length(bins)-1)]) / 2
  
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

# lm(log(count)~log(midpoints)) from censor output
log_log_lm <- function(x,y) {
  logx <- log(x)
  logy <- log(y)
  model <- lm(logy~logx)
  return(model)
}

# End of file.