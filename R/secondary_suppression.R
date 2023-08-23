#' Apply secondary suppression
#'
#' @rdname primary_suppression
#' @export

secondary_suppression = function(data,
                                 suppression_variable,
                                 ...) {
  # Making variables useable

  # Suppression column
  var = dplyr::enquo(suppression_variable)

  browser()

  data |>
    dplyr::group_by(...) |>
    dplyr::mutate(
      # Getting positive of -999999
      abs_number = abs(!!var)) |>
    # Arranging in numeric order on absolute number
    dplyr::arrange(..., abs_number) |>
    dplyr::mutate(
      row_n = dplyr::row_number(),
      # This must be done after primary suppression
      # Also suppresses the next lowest figure if only one suppressed number
      # By only doing row_n == 1, only the second lowest number will be
      # suppressed (even if the 3rd is equal)
      !!var := ifelse(
        abs(!!var) == min(abs(!!var)) & sum(suppression_flag) == 1 & row_n == 1,
        -999999,
        !!var
      ),

      # Convert -999 to *
      !!var := ifelse(
        !!var == -999999,
        "*",
        as.character(!!var)
      ))
}
