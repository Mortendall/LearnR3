## code to prepare `mmash` dataset goes here

library(here)
usethis::use_r("package-loading")

source(here::here("R/package-loading.R"))
getwd()

mmash_link <- "https://physionet.org/static/published-projects/mmash/multilevel-monitoring-of-activity-and-sleep-in-healthy-people-1.0.0.zip"
download.file(mmash_link, destfile = here("data-raw/mmash-data.zip"))

usethis::
