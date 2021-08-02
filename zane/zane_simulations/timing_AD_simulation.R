##
# Timing Armitage Doll Simulation
# Author: Zane Billings
# Date created: 2019-11-06
# Last updated: 2019-11-06
# Checks the histogram function running time from make_histograms.R
##

# This file contains the simulation to run.
source('~/Stuff/Research/Penland/discrete-biostatistics-project/zane_simulations/AD_simulation_functions.R')

# Input values for parameters here.
lambda_list <- c(0.1)
num_cells <- 7
num_trials_list <-  c(4, 40, 400, 4000, 40000, 400000, 4000000)
num_sims <- 1000 # Number of sims per lambda value.
bins <- c(0, 80, 5)

# Initialize vectors to hold model data.
lambda_vec = intercept_vec = slope_vec = rep_vec = trials_vec <- 
  numeric(length = length(lambda_list) * num_sims)
index <- 1

# Initialize vector to hold simulation times.
t_vec = n_vec <- 
  numeric(length = (length(lambda_list) * length(num_trials_list)))
t_index <- 1

  
### THIS PART RUNS THE MODEL
for (num_trials in num_trials_list) {
  start_sim_time <- Sys.time() # Record time at start of loop
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
  end_sim_time <- Sys.time() # Record time at end of loop
  t_vec[t_index] <- difftime(end_sim_time, start_sim_time, units = "secs")
  n_vec[t_index] <- num_trials
  t_index <- t_index + 1
}
### END OF MODEL RUN ###
  
timing_data <- data.frame(n_vec, t_vec)



