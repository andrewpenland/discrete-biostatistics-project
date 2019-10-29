##
# Histograms of average model parameters
# Author: Zane Billings
# Date created: 2019-10-28
# Last updated: 2019-10-28
# Runs the AD hitting time model created by Tommy and Justin for several
#  values of n and lambda, and generates a table of plots.
##

# Input values for parameters here
r_list = seq()
lambda_list = seq()

# Initialize vectors to hold data
slopes = data.frame()
intercepts = data.frame()

# Run model for all of these
for (r_val in r_list) { 
  for (lambda_val in lambda_list) {
    # Run the model
    
    # Store the coefficients 
    
  } 
}

# Plot table of slopes
slopes %>% 
  gather() %>% 
  ggplot() +
  geom_histogram()

# Plot table of intercepts
intercepts %>% 
  gather() %>% 
  ggplot() +
  geom_histogram()
