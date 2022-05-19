init_generation <- function(min_init , max_init, n)
{
  S = runif(n=1, min=min_init, max=max_init)
  # It returns a vector of lenght equal to 3 since the marking is 
  # defined by the three places: S, I, and R.
  return(c(S, 0, 0, 0))
}

fun.recovery <- function(optim_v, n)
{
  return(optim_v[1])
}

fun.infection <- function(optim_v, n)
{
  return(optim_v[2])
}

mse <- function(reference, output)
{
  reference[1,] -> times_ref
  reference[2,] -> infect_ref
  
  # We will consider the same time points
  Infect <- output[which(output$Time %in% times_ref),"I"]
  infect_ref <- infect_ref[which(times_ref %in% output$Time)]
  
  diff.Infect <- 1/length(times_ref) * sum((Infect - infect_ref)^2)
  
  return(diff.Infect)
}

add_infects <- function(marking, time)
{
  df.delta <- read.csv(file = 'outside_infected.csv', sep="")
  
  delta <- df.delta$infects[which( df.delta$time == time)]
  if(marking[1] >= delta){
    marking[1] <- marking[1] - delta
    marking[2] <- marking[2] + delta
  }
  
  return(marking)
}
