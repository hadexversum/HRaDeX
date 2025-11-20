# Plots high resolution classification plot

Plot the result of color classification analysis in high resolution in a
linear form.

## Usage

``` r
plot_hires(hires_params, interactive = FALSE)
```

## Arguments

- hires_params:

  data.frame with hires results, calculate using calculate_hires.

- interactive:

  ...

## Value

a girafe object.

## See also

calculate_hires

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat)
fit_k_params <- get_example_fit_k_params()
control <- get_example_control()
fit_values <- create_fit_dataset(kin_dat, control, fit_k_params)
#> Error in rbind(deparse.level, ...): numbers of columns of arguments do not match
hires_params <- calculate_hires(fit_values)
#> Error: object 'fit_values' not found
plot_hires(hires_params)
#> Error: object 'hires_params' not found
```
