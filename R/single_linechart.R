#' Create a single line chart
#'
#' Creates a generic single line chart in plotly. This function makes it quick
#' and easy to reuse similar code, such as in a dashboard
#'
#' @param data The dataframe you want to create a chart from
#' @param x_axis The x axis variable (usually a date)
#' @param y_axis A y axis variable (usually a number)
#' @param category_var The category variable you want to split by, like color in
#'   plotly or fill in ggplot2
#' @param palette A vector of hex codes for changing the palette. Default is PHS
#'   colours
#'
#' @return A plotly chart
#'
#' @example man/examples/comparison_linechart.R
#' @export

comparison_linechart = function(data,
                                x_axis,
                                y_axis,
                                category_var,
                                palette = c("#3F3685", "#9B4393", "#1E7F84",
                                            "#83BB26", "#3393DD", "#6B5C85")) {

  plotly_x = dplyr::enquo(x_axis)
  plotly_y = dplyr::enquo(y_axis)
  plotly_cat = dplyr::enquo(category_var)


  # Getting the length of the category variable
  plotly_palette = palette[1:length(unique(data |>
                                             dplyr::pull(!!plotly_cat)))]


  if (!("tooltip" %in% names(data))) {
    message("Creating a generic tooltip. Create a variable called 'tooltip' to specify format")
    data = data |>
      dplyr::mutate(tooltip = paste0(!!plotly_cat, "<br>",
                                     !!plotly_x, "<br>",
                                     !!plotly_y))
  }

  rlang::eval_tidy(
    rlang::quo_squash(rlang::quo(
      data |>
        plotly::plot_ly(x=~!!plotly_x,
                        y=~!!plotly_y,
                        color = ~!!plotly_cat,
                        colors = plotly_palette,
                        type = 'scatter',
                        text = ~tooltip,
                        hoverinfo = "text",
                        mode = 'line',
                        textposition="none")
    )))
}



