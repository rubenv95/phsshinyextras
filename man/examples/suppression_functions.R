
# Load the sample_data
data("sample_data")

# Apply primary suppression across the board, with no secondary suppression
suppresssed_data1 = sample_data |>
  primary_suppression(suppression_variable = number,
                      no_secondary = TRUE)

# Suppress values below 10
suppresssed_data2 = sample_data |>
  primary_suppression(suppression_variable = number,
                      no_secondary = TRUE,
                      min_unsuppressed = 10)

# Drop the original, unsuppressed column
suppresssed_data3 = sample_data |>
  primary_suppression(suppression_variable = number,
                      no_secondary = TRUE,
                      keep_original = FALSE)

# Apply both primary and secondary suppression

sec_suppressed = sample_data |>
  primary_suppression(suppression_variable = number,
                      no_secondary = FALSE) |>
  # We want to apply secondary suppression within SIMD
  # Therefore group by all categories EXCEPT SIMD
  secondary_suppression(suppression_variable = number,
                        health_board, date)

