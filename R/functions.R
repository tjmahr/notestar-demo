# R/functions.R
# Put code that want to source into "_targets.R" here.

# run once to set up demo
write_out_data <- function() {
  readr::write_csv(lme4::sleepstudy, "data/sleepstudy.csv")
}

fit_ri_model <- function(data) {
  model <- brm(
    Reaction ~ Days + (1 | Subject),
    data = data,
    family = gaussian(),
    backend = "cmdstanr"
  )

  model <- add_criterion(model, "loo")
  model <- add_criterion(model, "loo_R2")
  model
}

fit_rs_model <- function(data) {
  model <- brm(
    Reaction ~ Days + (Days | Subject),
    data = data,
    family = gaussian(),
    backend = "cmdstanr"
  )

  model <- add_criterion(model, "loo")
  model <- add_criterion(model, "loo_R2")
  model
}
