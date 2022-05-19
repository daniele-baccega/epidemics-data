library(dplyr)
library(testit)
library(pracma)

in_dir <- "SEIR_analysis/"
out_dir <- "dataset/Stochastic/data_inf_rate_0.00001-0.002/"
out_dir_norm <- "dataset/Stochastic/data_inf_rate_0.00001-0.002_norm/"

load(paste0(in_dir, "SEIR-analysis.RData"))

listFiles <- list.files(in_dir, pattern = ".trace")

data_unique <- data.frame()

lapply(listFiles, function(x){
  data <- read.csv(paste0(in_dir, x), header=TRUE, sep="")
  
  ID <- strtoi(gsub(".*[-]([^.]+)[.].*", "\\1", x))
  
  S0 <- config[[1]][[ID]][[3]][[1]]
  infection_rate <- config[[3]][[ID]][[3]]
  recovery_rate <- config[[4]][[ID]][[3]]
  
  reverse_dataframe <- function(dataframe){
    transpose <- t(dataframe)
    transpose <- as.data.frame(transpose)
    rev_data_frame <- rev(transpose)
    rev_data_frame <- t(rev_data_frame)
    rev_data_frame <- as.data.frame(rev_data_frame)  
    
    return(rev_data_frame)
  }
  
  data <- reverse_dataframe(data)
  data <- distinct(data, Time, .keep_all= TRUE)
  
  R0 <- (infection_rate * S0) / recovery_rate
    
  data <- reverse_dataframe(data)
  
  
  #I <- data$I[0:62]
  #x_data <- seq(0, 61, 1)
  
  #s <- predict(loess(I~x_data, span=0.2))
  #s[s < 0] <- 0
  
  #png(file=paste0(x, ".png"), width=1000, height=550)
  #plot(x_data, s, col='red', type='l')
  #lines(x_data, I, col='black', type='b')
  #dev.off()
  
  
  output <- append(data$I[0:61], R0)
  output_norm <- append(data$I[0:61]/S0, R0)
  #print(output)
  
  write.table(output, paste0(out_dir, x), col.names=FALSE, row.names=FALSE)
  write.table(output_norm, paste0(out_dir_norm, x), col.names=FALSE, row.names=FALSE)
})