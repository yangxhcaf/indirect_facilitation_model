#!/usr/bin/env r


library(simecol)
library(tidyverse)
library(magrittr)
devtools::load_all()

options(mc.cores = 24)

##########################
#  Complement to bifurc  #
##########################

gradient <- list(
  u = 10,
  b = seq(1, 0.5, by = -0.005),
  g = seq(0, .5, 0.005)
  )

output <- run_scenarii_gradient(
  gradient = gradient,
  model_spec = "two_facilitation_model",
  param = c(protection_type = list("first_protect"), gamma1 = 0.1),
  set_tail = 10
  )
scenar_avg <- avg_runs(output, cut_row = 10)
rm(output)
save(scenar_avg, file = "scenar_birfuc_u_10.RData")
rm(scenar_avg)

##################
#  Cooccurences  #
##################

set.seed(123)
gradient <- list(
  u = seq(0, 10, by = .1),
  del = seq(1, 0, by = -.01),
  g = c(0.1, .2)
  )
output <- run_scenarii_gradient(
  gradient = gradient,
  model_spec = "ca_two_facilitation_model",
  param = c(protection_type = list("first_protect"), gamma1 = 0.1, b = .8),
  time_seq = c(from = 0, to = 10000, by = .5),
  set_tail = 300, nrep = 10
  )

save(output, file = "scenar_ca_cooccurence.Rdata")

options(mc.cores = 5)
scenar_avg <- avg_runs(output, cut_row = 300)
rm(output)
save(scenar_avg, file = "scenar_avg_ca_cooccurence.Rdata")
rm(scenar_avg)
