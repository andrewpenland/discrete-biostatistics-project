# authors: Justin Clifton and Tommy Meek

# Determine when all necessary mutations have occurred in a single subject
#
# num_cells: number of mutations needed
# lambda: rate parameter. Should be small. (.001-.01) note: lambda < .003 gives funny results.
hitting_time <- function (num_cells, lambda) {
    return(max(rexp(num_cells, lambda)))
}

# Calls the hitting_time function once for each trial. This simulates finding the age at which all 
# necessary mutations have occurred for an entire population.
#
# num_cells: number of mutations needed
# lambda: rate parameter
# trials: number of subjects in population. Should be > 10,000,000 to be accurate
# returns a vector of hit ages
population_sim <- function(num_cells, lambda, trials) {
    ages <- c()
    ages <- replicate(trials, hitting_time(num_cells, lambda))
    return(ages)
}

# Stores the data from population_sim in a dataframe
#
# ages: vector of ages created by population_sim
# bins: starting age, ending age, and bin width for a histogram. 1 in bin: 0.5
# returns a dataframe with midpoints as column 1 and number of hits in each bin in column 2
censor <- function(ages, bins) {
    ages <- ages[ages <= 80] #restrict ages to <= 80. After this, funny things start happening.
    if (length(ages) <= 1) {
        if (is.na(ages[1])) {
            stop("No ages less than 80.")
        }
        stop("1 observation after removing ages > 80.")
    }
    my_hist <- hist(x = ages, breaks = seq(bins[1], bins[2], bins[3]), plot = FALSE) #for extracting midpoints
    df <- data.frame(mids = my_hist$mids, counts = my_hist$counts)
    df <- df[df$counts != 0,] #gets rid of zero rows
    return(df)
}


#print(censor(c(1,1,1,1,1,2,2,2,2,2,6,6,6,6,8,8), c(0, 10, 1)))

# Runs a linear regression model of the log transform of the number of hits as a function of the 
# midpoints of their respective bins. Then extracts the slope and intercept of the model.
#
# df: dataframe from censor
# returns the slope and intercept
log_log_fit <- function(df) {
    df$counts <- log(df$counts) #log transform
    df$mids <- log(df$mids) #log transform
    model <- lm(df$counts ~ df$mids)
    slope <- coef(model)[2]
    int <- exp((coef(model)[1])) #converting back from the log transform gives intercept = e^b
    return(c(slope, int))
}

#print(log_log_fit(censor(population_sim(7, .003, 1000000), c(0,200,10))))

# power law degree 6 loglog line of fit 4.97 - 6.26
