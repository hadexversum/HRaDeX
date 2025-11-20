# Calculate rmse of recovered deuterium uptake

Function calculates the RMSE of recovered deuterium uptake from
high-resolution parameters with regard to the experimental deuterium
uptake in measured time points.

## Usage

``` r
calculate_recovered_uc_rmse(rec_uc_dat, sort = c("ID", "rmse"))
```

## Arguments

- rec_uc_dat:

  recovered deuterium uptake data, produced by
  create_uc_from_hires_dataset function

- sort:

  sorting parameter

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
fit_values_all <- create_fit_dataset(kin_dat, control = get_example_control(),
                                     fit_k_params = get_example_fit_k_params(),
                                     fractional = T)
rec_uc_dat <- create_uc_from_hires_dataset(kin_dat,
                                       fit_values_all,
                                       hires_method = "shortest")
calculate_recovered_uc_rmse(rec_uc_dat, sort = "rmse")
#> Error in desc(rmse): could not find function "desc"
```
