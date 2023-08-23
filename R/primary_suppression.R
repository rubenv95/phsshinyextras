#' Apply primary and secondary suppression
#'
#' `primary_suppression()` and `secondary_suppression()` suppress values in
#' a column based on disclosure control principles.
#'
#' `primary_suppression()` will apply primary suppression to a numeric or integer
#' column.
#' It is designed to be used in tandem with `secondary_suppression()` by default.
#' It converts values ready to be suppressed to -999 temporarily, which
#' get converted to an asterisk in the `secondary_suppression()` function.
#' To only use primary suppression, use `no_secondary = TRUE` as an input.
#' This will convert suppressed values to an asterisk in the first instance.
#'
#'
#' By default, the original column is retained for QA purposes and suppression
#' is applied to numbers between 1-4. There are inputs to change these defaults
#' `secondary_suppression()` is applied after primary suppression to data that
#' displays a total (such as having SIMD 1-5 and Total).
#'
#'
#' Secondary suppression ensures a suppressed value cannot be calculated when
#' only one value is suppressed. It does so by suppressing the next lowest value
#' when only one number is suppressed.
#'
#' @param data A dataset to suppress
#' @param suppression_variable A numeric/integer column to suppress
#' @param no_secondary TRUE means you don't need to apply secondary suppression
#' @param min_unsuppressed The minimum number that should not be suppressed
#' 5 as a default (which means numbers between 1-4 will be suppressed)
#' @param keep_original TRUE or FALSE whether you would like a version of the
#' original column to check suppression has been applied correctly
#' @param ... A list of variables to group the data by before suppressing
#' (see examples for usage)
#'
#' @example man/examples/suppression_functions.R
#'
#' @export
primary_suppression = function(data,
                               suppression_variable,
                               no_secondary = FALSE,
                               min_unsuppressed = 5,
                               keep_original = TRUE) {
  # Make variable usable in function
  var = dplyr::enquo(suppression_variable)
  original_name = paste0(rlang::quo_name(var), "_original")

  data = data |>
    # Getting original
    dplyr::mutate(orig := !!var) |>
    # Apply -999 to values between 1-5
    dplyr::mutate(
      !!var := ifelse(
        !!var > 0 & !!var < min_unsuppressed,
        -999999,
        !!var
      ),
      # Flag where suppression is applied
      suppression_flag := ifelse(
        !!var == -999999, 1, 0
      ))

  if (keep_original) {
    data = data |>
      dplyr::rename({{original_name}} := orig)
  } else {
    data = data |>
      dplyr::select(-orig)
  }


  # When only primary suppression is required, converts to *
  if (no_secondary) {
    data = data |>
      dplyr::mutate(!!var := ifelse(
        !!var == -999999, "*", as.character(!!var)
      )) |>
      # Drop flag variable
      dplyr::select(-suppression_flag)
  }
  return(data)
}
