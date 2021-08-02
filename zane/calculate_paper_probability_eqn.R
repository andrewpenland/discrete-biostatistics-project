
calculate_probability <- function(p,k,n) {
  if ((0 <= n) & (n < k)) {
    return(1)
  } else if( (n < 0)) {
    return(0)
  } else {
   out = p^(n-k+1)
   for (r in 1:(n-k+1)) {
     for (m in (r+1):(r+k-1)) {
       out = out + calculate_probability(p,k,n-m) * p^r * (1-p)^(m-r)
     }
   }
   return(out)
  }
}
