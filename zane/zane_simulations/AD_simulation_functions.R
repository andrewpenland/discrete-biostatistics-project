##
# Armitage-Doll Large Scale Simulation
# Author: Zane Billings
# Date created: 2019-10-28
# Last updated: 2019-11-06
# Runs the AD hitting time model created by Tommy and Justin for several
#  values of n and lambda, and generates a table of plots.
##

# Import the model functions written by Tommy and Justin.
source('~/Stuff/Research/Penland/discrete-biostatistics-project/ArmitageDoll.R')

armitage_doll_model <- function(num_cells, lambda_val, num_trials, bins) {
  # Runs the complete suite of Armitage-Doll model functions.
  #
  #   Provides a wrapper for the population_sim(), censor(), and 
  #   log_log_fit() functions written by Tommy and Justin so that the entire
  #   Armitage-Doll hitting time model can be run in one step.
  #
  #   Args:
  #     num_cells:
  #     lambda_val:
  #     num_trials:
  #     bins:
  #   Returns:
  #     model_coefs: a vector where the first entry is the slope of the fitted
  #       log-log model, and the second entry is the intercept of the fitted
  #       log-log model.
  
  this_run <- population_sim(num_cells, lambda_val, num_trials)
  censored_data <- censor(this_run, bins)
  model_coefs <- log_log_fit(censored_data)
  return(model_coefs)
}

simulate_armitage_doll <- function(num_cells, lambda_list, num_trials_list, bins, num_sims) {
  # Runs the Armitage-Doll model several times for lists of parameters.
  #
  #   Takes in the num_cells parameter, bins, and number of sims to run for the 
  #   AD model, as well as two lists of parameters: a list of lambda values and 
  #   a list of num_trials values. Runs the simulation for all given combos of
  #   parameters and returns a data frame of results.
  #
  #   Args:
  #     num_cells:
  #     lambda_list:
  #     num_trials_list:
  #     bins:
  #     num_sims:
  #   Returns:
  #     model_data: a data frame where each row is one run of the simulation,
  #       which has fields corresponding to the lambda value, num_trials, 
  #       replicate number, slope, and intercept of the fitted model.
  
  lambda_vec = intercept_vec = slope_vec = rep_vec = trials_vec <- 
    numeric(length = length(lambda_list) * num_sims)
  index <- 1
    
  for (num_trials in num_trials_list) {
    for (lambda_val in lambda_list) {
      for (i in 1:num_sims) {
        # Run the model
        this_run <- armitage_doll_model(num_cells, lambda_val, num_trials, bins)
        # Store the coefficients 
        lambda_vec[index] <- lambda_val
        trials_vec[index] <- num_trials
        intercept_vec[index] <- this_run[[2]]
        slope_vec[index] <- this_run[[1]]
        rep_vec[index] <- i
        index <- index + 1
      }
    }
  }
  
  model_data <- data.frame(
    "lambda" = lambda_vec, 
    "rep" = rep_vec, 
    "slope" = slope_vec, 
    "intercept" = intercept_vec
  )
  
  return(model_data)
}

make_AD_histograms <- function(model_data) {
  
  # Plot table of slopes
  slope_plot <-
    model_data %>%
    select("slope", "rep", "lambda") %>%
    ggplot(aes(x = slope)) +
    geom_histogram(bins = num_bins, col = "black", fill = "white") +
    facet_wrap(~lambda) +
    theme_minimal()
  
  # Plot table of intercepts
  intercept_plot <-
    model_data %>%
    select("intercept", "rep", "lambda") %>%
    ggplot(aes(x = intercept)) +
    geom_histogram(bins = num_bins, col = "black", fill = "white") +
    facet_wrap(~lambda) +
    theme_minimal()
  
}
