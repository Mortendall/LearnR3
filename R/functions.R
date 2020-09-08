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
