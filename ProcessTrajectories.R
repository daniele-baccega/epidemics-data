library(dplyr)
library(testit)

in_dir <- "SEIR_analysis/"
out_dir <- "dataset/Stochastic/data_inf_rate_0.00001-0.015/"

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
  
  output <- append(data$I[0:62], R0)
  
  write.table(output, paste0(out_dir, x), col.names=FALSE, row.names=FALSE)
})