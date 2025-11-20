# Plots the classification results for two states

Function plots the classfication results in color code for two
biological states at the same time. The results for the second state are
on top, and for the first state on the bottom. The grey color indicates
no data.

## Usage

``` r
plot_two_states(
  hires_params_1,
  hires_params_2,
  type = c("aggregated", "classes", "coverage"),
  interactive = F
)
```

## Arguments

- hires_params_1:

  hires parameters for the first state

- hires_params_2:

  hires parameters for the second state

- type:

  not supported right now

- interactive:

  logical, true for GUI

## Value

a ggiraph object.

## See also

calculate_hires create_fit_dataset

## Examples

``` r
fit_k_params <- get_example_fit_k_params()
control <- get_example_control()
control <- get_example_control()
kin_dat <- prepare_kin_dat(alpha_dat)
fit_values <- create_fit_dataset(kin_dat, control, fit_k_params)
#> Error in rbind(deparse.level, ...): numbers of columns of arguments do not match
hires_params <- calculate_hires(fit_values)
#> Error: object 'fit_values' not found
# the same for the second state, and then:
# plot_two_states(hires_params_1, hires_params_2)
```
