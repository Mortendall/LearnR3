#' An algebra function
#'
#' @param num1 a number
#' @param num2 another number
#'
#' @return the summed value of parameters

add_numbers <- function(num1, num2){
  added <- num1+num2
  return(added)
}

#' Imports MMASH user info
#'
#' @param file_path defines the location of the file
#'
#' @return imports and formats the user info

import_user_info <- function(file_path){
  info_data <- vroom::vroom(
    file_path,
    col_select = -1,
    col_types = vroom::cols(
      Gender = vroom::col_character(),
      Weight = vroom::col_double(),
      Height = vroom::col_double(),
      Age = vroom::col_double()
    ),
    .name_repair = snakecase::to_snake_case)
  return(info_data)
}

#' Import saliva data
#'
#' @param import_path file directiory
#'
#' @return the imported data set

import_saliva_data <- function(import_path) {
  saliva_data <- vroom::vroom(
    import_path,
    col_select = -1,
    col_types = vroom::cols(
      SAMPLES = vroom::col_character(),
      `Cortisol NORM` = vroom::col_double(),
      `Melatonin NORM` = vroom::col_double()
    ),
    .name_repair = snakecase::to_snake_case
  )
  return(saliva_data)
}

#' RR file importer
#'
#' @param file_path file directory
#'
#' @return the imported data

import_rr_data <- function(file_path){
  import_data <- vroom::vroom(
    file_path,
    col_select = -1,
    col_types = vroom::cols(
      ibi_s = vroom::col_double(),
      day = vroom::col_double(),
      time = vroom::col_time(format = "")),
    .name_repair = snakecase::to_snake_case)
  return(import_data)
}

#' Actigraph Data Importer
#'
#' @param file_path the file directory
#'
#' @return the imported data

import_actigraph_data <- function(file_path) {
  data_import <- vroom::vroom(
    file_path,
    col_select = -1,
    col_types = vroom::cols(
      Axis1 = vroom::col_double(),
      Axis2 = vroom::col_double(),
      Axis3 = vroom::col_double(),
      Steps = vroom::col_double(),
      HR = vroom::col_double(),
      `Inclinometer Off` = vroom::col_double(),
      `Inclinometer Standing` = vroom::col_double(),
      `Inclinometer Sitting` = vroom::col_double(),
      `Inclinometer Lying` = vroom::col_double(),
      `Vector Magnitude` = vroom::col_double(),
      day = vroom::col_double(),
      time = vroom::col_time(format = "")
    ),
    .name_repair = snakecase::to_snake_case
  )
  return(data_import)
}

#' Import data sets
#'
#' @param file_pattern The file pattern we want to search for
#' @param import_function The import function for this data type
#'
#' @return an assembled file with data from each user

import_multiple_files <- function(file_pattern, import_function){
  data_files <- fs::dir_ls(here::here("data-raw/mmash/"),
                           regexp = file_pattern,
                           recurse = T)
  combined_data <- purrr::map_dfr(data_files,import_function, .id = "file_path_id" )
  return(combined_data)
}
