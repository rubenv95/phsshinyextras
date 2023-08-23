## Set-up an example chart
library(dplyr)
library(phsshinyextras)

data("sample_data")
# Using the in-built sample data set, filtering to a specific health board
example_data = filter(sample_data, health_board == "NHS Lothian",
                      simd != "Total")

# Stacked bar chart
chart = proportion_barchart(data = example_data,
                            x_axis = date,
                            y_axis = proportion,
                            category_var = simd,
                            stacked = TRUE)

# Using generic titles, month x axis and proportion y axis
chart |>
  phs_plotly_layout(x_axis = "Month", y_axis = "Proportion")

# Relabel titles
chart |>
  phs_plotly_layout(x_axis = "Month", y_axis = "Proportion",
                    x_title = "Month/Year", y_title = "Proportion by SIMD")

