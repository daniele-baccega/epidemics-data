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
  # events <- read.csv(file = 'Input/outside_infected.csv', sep="")
  df.delta <- data.frame(time = seq(from=0, to=60, by=1),
                         infects=c(0.0000,11.5671,11.3387,10.3868,9.4669,7.6433,5.8557,5.3808,5.2745,3.1704,
                                  1.8076,0.9659,0.5130,0.2606,0.2424,0.2285,0.1022,0.1002,0.0361,0.0220,0.0201,
                                  0.0300,0.0221,0.0300,0.0141,0.0120,0.0180,0.0201,0.0140,0.0060,0.0180,0.0081,
                                  0.0100,0.0100,0.0120,0.0060,0.0141,0.0060,0.0080,0.0140,0.0100,0.0080,0.0081,
                                  0.0080,0.0060,0.0020,0.0020,0.0120,0.0000,0.0040,0.0060,0.0000,0.0081,0.0020,
                                  0.0060,0.0060,0.0020,0.0020,0.0040,0.0000,0.0080))
  delta <- df.delta$infects[which( df.delta$time == time)]
  if(marking[1] >= delta){
    marking[1] <- marking[1] - delta
    marking[2] <- marking[2] + delta
  }
  
  return(marking)
} 
