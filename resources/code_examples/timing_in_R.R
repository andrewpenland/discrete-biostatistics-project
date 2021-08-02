x <- 0
tic <- proc.time()
replicate(100, x <- x + 1)
toc <- proc.time()
gone <- toc - tic
gone

