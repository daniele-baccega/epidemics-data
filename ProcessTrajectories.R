in_dir <- "SEIR_analysis/"
out_dir <- "dataset/Stochastic/data_inf_rate_0.00001-0.015/"

load(paste0(in_dir, "SEIR-analysis.RData"))

listFiles <- list.files(in_dir, pattern = ".trace")

lapply(listFiles, function(x){
  data <- read.csv(paste0(in_dir, x), header=TRUE, sep="")
  
  ID <- strtoi(gsub(".*[-]([^.]+)[.].*", "\\1", x))
  
  S0 <- config[[1]][[ID]][[3]][[1]]
  infection_rate <- config[[3]][[ID]][[3]]
  recovery_rate <- config[[4]][[ID]][[3]]
  
  R0 <- (infection_rate * S0) / recovery_rate
    
  output <- append(data$I, R0)
  
  write.table(output, paste0(out_dir, x), col.names=FALSE, row.names=FALSE)
})