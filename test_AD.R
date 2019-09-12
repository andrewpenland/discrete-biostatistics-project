## 
# Testing Hitting Time functions
# Zane Billings
# 2019-09-11
# Create (replicable) dummy data to make sure all functions in
#  hitting_time_functions.R are working as intended. Need to upgrade this
#  to actual unit testing in the future.
##

set.seed(300)
sample <- armitage_doll(500, 0.1, 1000)
bins <- seq(from = 0, to = max(sample + 10), by = 10)
test <- censor(sample, bins)

test_model <- log_log_lm(test$binned_data, test$n)
plot(test)
summary(test_model)