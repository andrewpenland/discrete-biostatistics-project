##
# Histograms of average model parameters
# Author: Zane Billings
# Date created: 2019-10-28
# Last updated: 2019-10-28
# Runs the AD hitting time model created by Tommy and Justin for several
#  values of n and lambda, and generates a table of plots.
##

library(tidyverse)
source('~/Stuff/Research/Penland/discrete-biostatistics-project/ArmitageDoll.R')

# Input values for parameters here
lambda_list <- seq(from = 0.01, to = 0.1, by = 0.01)
#num_cells_list <- seq(from = 1, to = 100, by = 10)
num_cells <- 100
num_trials <- 100000
num_bins <- 15
num_sims <- 100 # Number of sims per lambda
# observations <- length(lambda_list) * length(num_cells_list)

# Initialize vectors to hold data
n_vec = lambda_vec = intercept_vec = slope_vec = rep_vec <- 
  numeric(length = length(lambda_list) * num_sims)
#i <- 1

# Modify censor to accept title argument
censor <- function(ages, bins, title) {
  #ages <- ages[ages <= 80] #restrict ages to <= 80. After this, funny things start happening.
  my_hist <- hist(x = ages, breaks = seq(bins[1], bins[2], bins[3]), main = title) #for extracting midpoints
  df <- data.frame(mids = my_hist$mids, counts = my_hist$counts)
  df <- df[df$counts != 0,] #gets rid of zero rows
  return(df)
}

index <- 1
# Run model for all of these
for (lambda_val in lambda_list) {
  for (i in 1:num_sims) {
    # Run the model
    this_title <- paste("lambda = ", lambda_val, "; n = ", num_cells, sep = "")
    this_run <- population_sim(num_cells, lambda_val, num_sims)
    bins <- c(min(this_run), max(this_run), (max(this_run) - min(this_run))/num_bins)
    censored_data <- censor(this_run, bins, this_title)
    model <- log_log_fit(censored_data)
    # Store the coefficients 
    lambda_vec[index] <- lambda_val
    intercept_vec[index] <- model[[2]]
    slope_vec[index] <- model[[1]]
    rep_vec[index] <- i
    index <- index + 1
  }
}

model_data <- data.frame(
  "lambda" = lambda_vec, 
  "rep" = rep_vec, 
  "slope" = slope_vec, 
  "intercept" = intercept_vec
)

# Plot table of slopes
model_data %>%
  select("slope", "rep", "lambda") %>%
  ggplot(aes(x = slope)) +
  geom_histogram(bins = num_bins, col = "black", fill = "white") +
  facet_wrap(~lambda) +
  theme_minimal()
