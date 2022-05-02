in_dir <- "data/"
out_dir <- "dataset/data_inf_rate_0.00001-0.015/"

load(paste0(in_dir, "SEIR-sensitivity.RData"))

listFiles <- list.files(in_dir, pattern = ".trace")

S0 <- 255

lapply(listFiles, function(x){
  data <- read.csv(paste0(in_dir, x), header=TRUE, sep="")
  
  ID <- strtoi(gsub(".*[-]([^.]+)[.].*", "\\1", x))
  
  infection_rate <- config[[6]][[ID]][[3]]
  recovery_rate <- config[[7]][[ID]][[3]]
  
  R0 <- (infection_rate * S0) / recovery_rate
    
  output <- append(data$I, R0)
  
  write.table(output, paste0(out_dir, x), col.names=FALSE, row.names=FALSE)
})