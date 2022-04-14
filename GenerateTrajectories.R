library(epimod)

downloadContainers()

# Sensitivity analysis
sensitivity<-model.sensitivity(n_config = 100000,
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
                               parallel_processors = 24)

source("./Rfunction/SensitivityPlot.R")
pl = SensitivityPlot(rank=T, folder = "SEIR_sensitivity/")

pl$TrajI
pl$TrajI_best
pl$TrajE
pl$Points

# Calibration analysis
calibration <- model.calibration(solver_fname = "./Net/SIR.solver",
                                 parameters_fname = "./Input/Functions_list_Calibration.csv",
                                 functions_fname = "./Rfunction/FunctionCalibration.R",
                                 reference_data = "./Input/reference_data.csv",
                                 distance_measure = "mse",
                                 i_time = 1,
                                 f_time = 60, # days
                                 s_time = 1, # day
                                 # Vectors to control the optimization
                                 ini_v = c(0.035,0.00035),
                                 ub_v = c(0.05, 0.0005),
                                 lb_v = c(0.025, 0.00025),
                                 max.time = 1)