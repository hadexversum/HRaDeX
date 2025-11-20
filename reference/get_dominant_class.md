# Get get dominant class and color from hires data

Get get dominant class and color from hires data

## Usage

``` r
get_dominant_class(hires_params)
```

## Examples

``` r
fit_k_params <- get_example_fit_k_params()
control <- get_example_control()
kin_dat <- prepare_kin_dat(alpha_dat)
fit_values <- create_fit_dataset(kin_dat = kin_dat, control = control, fit_k_params = fit_k_params, fractional = TRUE)
hires_params <- calculate_hires(fit_values, method = "weighted", fractional = TRUE)
hires_params_dom <- get_dominant_class(hires_params)
```
