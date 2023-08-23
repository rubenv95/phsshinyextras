## Set-up an example chart
library(dplyr)
library(phsshinyextras)

data("sample_data")
# Using the in-built sample data set to compare 3 Health Boards
example_data = filter(sample_data,
                      health_board %in% c("NHS Lothian",
                                          "NHS Ayrshire and Arran",
                                          "NHS Orkney"),
                      simd == "Total")
# Standard comparison line chart
example_data |>
  comparison_linechart(x_axis = date,
                       y_axis = number,
                       category_var = health_board)


# Creating a tooltip beforehand as a variable
tooltip_example = example_data |>
  mutate(tooltip = paste0(
    "Date: ", date, "<br>",
    scales::percent(proportion, accuracy = 1), " of records were in ",
    health_board
  ))

# Automatically picks up the tooltip by its name
tooltip_example |>
  comparison_linechart(x_axis = date,
                       y_axis = number,
                       category_var = health_board,
                       # Updating the palette
                       palette = c("Red", "Green", "Blue"))
