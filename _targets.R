library(targets)
library(tarchetypes)
library(notestar)
library(tidyverse)
library(brms)

source("R/functions.R")

tar_option_set(
  packages = c("tidyverse", "notestar", "brms"),
  imports = c("notestar")
)


# Develop your main targets here
targets_main <- list(
  tar_file(file_sleep, "data/sleepstudy.csv"),
  tar_target(sleep_data, readr::read_csv(file_sleep)),
  tar_target(model_1, fit_ri_model(sleep_data)),
  tar_target(model_2, fit_rs_model(sleep_data))
)


targets_notebook <- list(
  tar_notebook_pages(
    dir_notebook = "notebook",
    dir_md = "notebook/book",
    notebook_helper = "notebook/book/knitr-helpers.R"
  ),
  tar_file(notebook_csl_file, "notebook/book/assets/apa.csl"),
  tar_file(notebook_bib_file, "notebook/book/assets/refs.bib"),
  tar_notebook(
    extra_deps = list(notebook_csl_file, notebook_bib_file)
  ),

  # Remove the following three targets to disable spellchecking
  # or add new exceptions here
  tar_target(
    spellcheck_exceptions,
    c(
      "brms", "LOOIC", "lme",
      "tibble", "notestar", "pandoc"
    )
  ),

  tar_target(
    spellcheck_notebook,
    spelling::spell_check_files(notebook_rmds, ignore = spellcheck_exceptions)
  ),

  # Prints out spelling mistakes when any are found
  tar_force(
    spellcheck_report_results,
    print(spellcheck_notebook),
    nrow(spellcheck_notebook) > 0
  )
)


list(
  targets_main,
  targets_notebook
)
