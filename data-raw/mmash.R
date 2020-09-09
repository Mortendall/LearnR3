library(here)
library(fs)
library(tidyverse)
devtools::load_all()

mmash_link <- "https://physionet.org/static/published-projects/mmash/multilevel-monitoring-of-activity-and-sleep-in-healthy-people-1.0.0.zip"
#download.file(mmash_link, destfile = here("data-raw/mmash-data.zip"))

#
# unzip(
#   here("data-raw/mmash-data.zip"),
#   exdir = here("data-raw"),
#   junkpaths = T
# )

# unzip(here("data-raw/MMASH.zip"),
#       exdir = here("data-raw"))
#
#
# file_delete(here(c("data-raw/MMASH.zip",
#                    "data-raw/SHA256SUMS.txt",
#                   "data-raw/LICENSE.txt")))
# file_move(here("data-raw/DataPaper"),
#           here("data-raw/mmash"))

user_data <- import_multiple_files("user_info.csv", import_user_info)
saliva_df <- import_multiple_files("saliva.csv", import_saliva_data)
actigraph_df <-
  import_multiple_files("Actigraph.csv", import_actigraph_data)
rr_df <- import_multiple_files("RR.csv", import_rr_data)


summarized_rr_df <- rr_df %>%
  group_by(user_id, day) %>%
  summarise(across(ibi_s, list(mean=mean, sd=sd), na.rm = T))

saliva_with_day_df <- saliva_df %>%
  mutate(day = case_when(
    samples == "before sleep" ~ 1,
    samples == "wake up" ~ 2,
    TRUE ~ NA_real_
  ))

actigraph_df_sum <- actigraph_df %>%
  select(-c(axis_1,axis_2,axis_3, inclinometer_off,inclinometer_standing, inclinometer_sitting, inclinometer_lying)) %>%
  group_by(user_id, day) %>%
  summarise(across(c(steps, hr, vector_magnitude), list(mean = mean, sd = sd), na.rm = T))

mmash <-
  reduce(list(
    user_data,
    saliva_with_day_df,
    summarized_rr_df,
    actigraph_df_sum
  ),
  full_join)

usethis::use_data(mmash, overwrite = T)

