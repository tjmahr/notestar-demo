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


# To modify the notebook theme or the locations of the files used by notestar,
# edit config.yml.
targets_notebook <- list(
  tar_notebook_index_rmd(
    title = "An example notebook created using notestar",
    author = "TJ Mahr",
    ## notestar::use_notestar_references() will provide these files
    ## in the notebook folder. then uncomment these lines and modify
    ## files as needed:
    bibliography = "refs.bib",
    csl = "apa.csl",
    index_rmd_body_lines =
      "Source code for demo available here: https://github.com/tjmahr/notestar-demo"
  ),
  tar_notebook_pages(),
  tar_notebook(
    ## We can tell notestar to make the notebook depend on any extra targets by
    ## creating the targets and passing them through here:
    # extra_deps = list(...)
  ),

  # Remove the following three targets to disable spellchecking
  # or add new exceptions here
  tar_target(
    spellcheck_exceptions,
    # add new exceptions here
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
