#' Create a 100% proportion bar chart
#'
#' Creates a generic proportion bar chart in plotly. This function makes it
#' quick and easy to reuse similar code, such as in a dashboard
#'
#' @param data The dataframe you want to create a chart from
#' @param x_axis The x axis variable (usually a date)
#' @param y_axis The proportion y axis variable in decimal format
#' @param category_var The category variable you want to split by, like color in
#'   plotly or fill in ggplot2
#' @param bargap TRUE or FALSE whether you'd like to have a gap between the bars
#' @param stacked TRUE or FALSE whether you'd like the chart stacked (FALSE =
#'   side by side)
#' @param palette A vector of hex codes for changing the palette. Default is PHS
#'   colours
#'
#' @return A plotly chart
#'
#' @import rlang
#'
#' @example man/examples/proportion_barchart.R
#' @export


proportion_barchart = function(data,
                               x_axis,
                               y_axis,
                               category_var,
                               bargap = TRUE,
                               stacked = FALSE,
                               palette = c("#3F3685", "#9B4393", "#1E7F84",
                                           "#83BB26", "#3393DD", "#6B5C85")) {

  if (stacked) {
    bar_mode_opt = "stack"
  } else {
    bar_mode_opt = "group"
  }

  plotly_x = dplyr::enquo(x_axis)
  plotly_y = dplyr::enquo(y_axis)
  plotly_cat = dplyr::enquo(category_var)

  # Getting the length of the category variable
  plotly_palette = palette[1:length(unique(data |>
                                             dplyr::pull(!!plotly_cat)))]


  if (!("tooltip" %in% names(data))) {
    message("Creating a generic tooltip. Create a variable called 'tooltip' to specify format")

    data = data |>
      dplyr::mutate(tooltip = paste0(!!plotly_x, "<br>",
                                     scales::percent(!!plotly_y, accuracy = 1)))
  }

  p = rlang::eval_tidy(
    rlang::quo_squash(rlang::quo(
      data |>
        plotly::plot_ly(x=~!!plotly_x,
                        y=~!!plotly_y*100,
                        color = ~!!plotly_cat,
                        colors = plotly_palette,
                        marker = list(line = list(width=1,
                                                  color = 'rgb(0,0,0)')),
                        type = 'bar',
                        text = ~tooltip,
                        hoverinfo = "text",
                        textposition = "none")
    ))) |>
    plotly::layout(barmode = bar_mode_opt)

  # TRUE/FALSE input. FALSE means there will be no bar gap
  if(!bargap) {
    p = p |>
      plotly::layout(bargap = 0)
  }

  return(p)
}

