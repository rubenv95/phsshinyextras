library(dplyr)
library(phsshinyextras)

data("sample_data")
# Using the in-built sample data set, filtering to a specific health board
example_data = filter(sample_data, health_board == "NHS Lothian",
                      simd != "Total")
# Standard side by side chart
proportion_barchart(data = example_data,
                    x_axis = date,
                    y_axis = proportion,
                    category_var = simd)

# Stacked bar chart
proportion_barchart(data = example_data,
                    x_axis = date,
                    y_axis = proportion,
                    category_var = simd,
                    stacked = TRUE)

# Changing the palette
proportion_barchart(data = example_data,
                    x_axis = date,
                    y_axis = proportion,
                    category_var = simd,
                    stacked = TRUE,
                    palette = c("#15138f", "#927dc1", "#f1f1f1",
                                "#ec9c9d", "#de425b"))

# Remove bar gap
proportion_barchart(data = example_data,
                    x_axis = date,
                    y_axis = proportion,
                    category_var = simd,
                    stacked = TRUE,
                    bargap = FALSE)

# Creating a tooltip beforehand as a variable
tooltip_example = example_data |>
  mutate(tooltip = paste0(
    "Date: ", date, "<br>",
    scales::percent(proportion, accuracy = 1), " of records were in ",
    "SIMD quintile ", simd
  ))

# Automatically picks up the tooltip by its name
proportion_barchart(data = tooltip_example,
                    x_axis = date,
                    y_axis = proportion,
                    category_var = simd,
                    stacked = TRUE)
