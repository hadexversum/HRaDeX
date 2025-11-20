# Plots recovered DU of a peptide

The function recovers deuterium uptake from high-resolution parameters
and returns a plot of uptake curve for chosen peptide. TODO: rewrite as
only plotting function

## Usage

``` r
recreate_uc(
  fit_dat,
  fit_values_all,
  fractional = TRUE,
  hires_method = c("shortest", "weighted")
)
```

## Arguments

- fit_dat:

  experimental uptake data filter for chosen peptide

- fit_values_all:

  fit parameters for whole peptide pool

- fractional:

  indicator if the fractional deuterium uptake is used

- hires_method:

  method of aggregation

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
fit_dat <- kin_dat[kin_dat[["ID"]]==3, ]
fit_values_all <- create_fit_dataset(kin_dat, control = get_example_control(),
                                     fit_k_params = get_example_fit_k_params(),
                                     fractional = T)
recreate_uc(fit_dat, fit_values_all, hires_method = "shortest")
#> Warning: All aesthetics have length 1, but the data has 6 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.
#> Warning: All aesthetics have length 1, but the data has 6 rows.
#> ℹ Please consider using `annotate()` or provide this layer with data containing
#>   a single row.

```
