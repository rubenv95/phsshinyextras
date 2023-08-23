#' Produces a list for a number y axis layout in a plotly chart
#'
#' This function is internally used by `phs_plotly_layout()`
#' @return A list
#' @keywords Internal
#' @export
y_number = function() {
  list(title = "Number",
       rangemode="tozero",
       fixedrange=TRUE,
       tickfont = list(size=14),
       titlefont = list(size=18),
       showline = FALSE)
}

#' Produces a list for a proportion y axis layout in a plotly chart
#'
#' This function is internally used by `phs_plotly_layout()`
#' @return A list
#' @keywords Internal
#' @export
y_proportion = function() {
  list(title = "Proportion",
       rangemode="tozero",
       fixedrange=TRUE,
       tickfont = list(size=14),
       titlefont = list(size=18),
       showline = FALSE,
       ticksuffix = "%")
}
