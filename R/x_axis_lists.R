#' Produces a list for a month x axis layout in a plotly chart
#'
#' This function is internally used by `phs_plotly_layout()`
#' @return A list
#' @keywords Internal
#' @export
x_month = function() {
  list(title = "Month",
       type = 'date',
       tickformat = "%b<br>%Y",
       tickfont = list(size=14),
       titlefont = list(size=18),
       showline = TRUE,
       fixedrange=TRUE)
}

#' Produces a list for a year x axis layout in a plotly chart
#'
#' This function is internally used by `phs_plotly_layout()`
#' @return A list
#' @keywords Internal
#' @export
x_year = function() {
  list(title = "Year",
       tickfont = list(size=14),
       titlefont = list(size=18),
       showline = TRUE,
       fixedrange=TRUE)
}

#' Produces a list for a categorical x axis layout in a plotly chart
#'
#' This function is internally used by `phs_plotly_layout()`
#' @return A list
#' @keywords Internal
#' @export
x_categorical = function() {
  list(title = "Category",
       tickfont = list(size=14),
       titlefont = list(size=18),
       showline = TRUE,
       fixedrange = TRUE)
}


