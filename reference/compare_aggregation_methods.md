# Compare aggregation methods

The function plots the analogical plots as plot_recovered_uc_coverage
but for the two aggregation methods at the same time. TODO: rewrite for
optimization purposes.

## Usage

``` r
compare_aggregation_methods(
  kin_dat,
  fit_values_all,
  style = c("coverage", "butterfly")
)
```

## Arguments

- kin_dat:

  uptake data for the whole peptide pool

- fit_values_all:

  fit parameters for whole peptide pool, unaggregated

- style:

  plotting style

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
fit_values_all <- create_fit_dataset(kin_dat, control = get_example_control(),
                                     fit_k_params = get_example_fit_k_params(),
                                     fractional = T)
compare_aggregation_methods(kin_dat, fit_values_all, style = "coverage")
#> Error in scale_linetype(""): could not find function "scale_linetype"
compare_aggregation_methods(kin_dat, fit_values_all, style = "butterfly")
```
