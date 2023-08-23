#' Sample Health Board Dataset
#'
#' This is a dummy dataset containing all of the Scottish NHS Health Boards.
#' These data are primarily used to demonstrate how to use
#' the functions within this package
#'
#' @format ## `sample_data`
#' A dataframe with 1,008 rows and 5 columns:
#'
#'
#' \describe{
#'   \item{health_board}{Health Board Name}
#'   \item{simd}{Social Index of Multiple Deprivation Quintile (includes Total)}
#'   \item{date}{YYYY-MM-DD, first of the month for all of 2022}
#'   \item{number}{randomly generated numbers (using `sample()`)}
#'   \item{proportion}{Proportion of number within each SIMD quintile by date and health board}
#'   }
"sample_data"
