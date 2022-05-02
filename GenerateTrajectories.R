library(devtools)
install_github("https://github.com/qBioTurin/epimod", ref="master")
library(epimod)

downloadContainers()

# Sensitivity analysis
sensitivity<-model.sensitivity(n_config = 10000,
                               solver_fname = "Net/SEIR.solver",
                               parameters_fname = "Input/Functions_list.csv",
                               reference_data = "Input/reference_data.csv",
                               functions_fname = "Rfunction/Function.R",
                               distance_measure = "mse",
                               event_function = "add_infects",
                               event_times = seq(from=1, to=60, by=1),
                               i_time = 0,
                               f_time = 60,
                               s_time = 1,
                               parallel_processors = 8)

source("./Rfunction/SensitivityPlot.R")
pl = SensitivityPlot(rank=T, folder = "SEIR_sensitivity/")

pl$TrajI
pl$TrajI_best
pl$TrajE
pl$Points


analysis <-model.analysis(n_config = 10000,
                         solver_fname = "Net/SEIR.solver",
                         solver_type = "SSA",
                         parameters_fname = "Input/Functions_list.csv",
                         functions_fname = "Rfunction/Function.R",
                         event_function = "add_infects",
                         event_times = seq(from=1, to=60, by=1),
                         i_time = 0,
                         f_time = 60,
                         s_time = 1,
                         parallel_processors = 8)