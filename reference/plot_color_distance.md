# Plots assigned color distance

Function plots the difference between assigned color codes from hires
parameters for two biological states. The color diffrence is calucluated
as common distance = sqrt((red_1 - red_2)^2 + (green_1 - green_2)^ +
(blue_1 - blue_2)^2). The difference is always positive, as it is
difficult to get the direction of change simultaneusly for three
parameters.

## Usage

``` r
plot_color_distance(two_state_dataset, interactive = FALSE)
```

## Arguments

- two_state_dataset:

  data.frame produced by
  [create_two_state_dataset](https://hadexversum.github.io/HRaDeX/reference/create_two_state_dataset.md)

- interactive:

  logical, true for GUI

## Value

a ggiraph object.

## See also

create_two_state_dataset

## Examples

``` r
fit_k_params <- get_example_fit_k_params()
control <- get_example_control()
kin_dat <- prepare_kin_dat(alpha_dat)
fit_values <- create_fit_dataset(kin_dat, control, fit_k_params)
#> Error in rbind(deparse.level, ...): numbers of columns of arguments do not match
hires_params <- calculate_hires(fit_values)
#> Error: object 'fit_values' not found
# the same for the second state, and then:
# two_states_dataset <- create_two_state_dataset(hires_params_1, hires_params_2)
# plot_color_distance(two_states_dataset)
```
