#' Add layout formatting to a plotly chart
#'
#' `phs_plotly_layout` can be used to add a built-in layout format for a plotly
#' chart, using the plotly::layout() function
#'
#' @param plotly_chart A plotly chart to update
#' @param x_axis A string to determine x axis layout. Options include "Month",
#'   "Year", "Categorical", with slightly different formatting, but consistent
#'   font and size (Arial)
#' @param y_axis A string to determine y axis layout. Options include "Number"
#'   and "Proportion", with slightly different formatting, but consistent font
#'   and size. Proportion chart should be applied to 100% bar charts
#' @param x_title A string to rename the x axis title. "Default" uses an
#'   in-built option based on the x_axis chosen.
#' @param y_title A string to rename the y axis title. "Default" uses an
#'   in-built option based on the y_axis chosen.
#'
#' @return A plotly chart with updated layout
#'
#' @example man/examples/phs_plotly_layout.R
#'
#' @export
#'


phs_plotly_layout = function(plotly_chart,
                             x_axis,
                             y_axis,
                             x_title = "Default",
                             y_title = "Default") {


  # Define x axis lists
  if (x_axis == "Month") {
    x_axis_list = x_month()
  } else if (x_axis == "Categorical") {
    x_axis_list = x_categorical()
  } else if (x_axis == "Year") {
    xaxis_year = x_year()
  }

  # Define y axis lists

  if (y_axis == "Number") {
    y_axis_list = y_number()
  } else if (y_axis == "Proportion") {
    y_axis_list = y_proportion()
  }


  # Update axes titles
  if (x_title != "Default") {
    x_axis_list[["title"]] == x_title
  }
  if (y_title != "Default") {
    y_axis_list[["title"]] == y_title
  }

  # Add layout
  plotly_chart |>
    plotly::layout(
      xaxis = x_axis_list,
      yaxis = y_axis_list
    )



}
