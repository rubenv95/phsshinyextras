
### Suppression Functions ----
# Apply primary suppression
# Input a data frame + variable you want to suppress
# Changes 1-5 numbers to -999 (temporarily)

#' Apply primary suppression to numbers > 0 and < 5
#'
#' @param data A dataset to suppress
#'
#' @param suppression_variable A numeric/integer column to suppress
#' @param no_secondary TRUE means you don't need to apply secondary suppression
#'
#' @examples man/examples/primary_suppression.R
#'
#' @export
primary_suppression = function(data,
                               suppression_variable,
                               no_secondary = FALSE) {
  # Make variable usable in function
  var = dplyr::enquo(suppression_variable)

  data = data |>
    # Apply -999 to values between 1-5
    dplyr::mutate(
      !!var := ifelse(
        !!var > 0 & !!var < 5,
        -999,
        !!var
      ),
      # Flag where suppression is applied
      suppression_flag := ifelse(
        !!var == -999, 1, 0
      ))

  # When only primary suppression is required, converts to *
  if (no_secondary) {
    data = data |>
      dplyr::mutate(!!var := ifelse(
        !!var == -999, "*", as.character(!!var)
      )) |>
      # Drop flag variable
      dplyr::select(-suppression_flag)
  }
  return(data)
}
