# Recreating fit values for peptide from hires values

Recreating fit values for peptide from hires values

## Usage

``` r
recreate_fit_values(peptide_sequence, peptide_start, peptide_end, hires_dat)
```

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
fit_values_all <- create_fit_dataset(kin_dat, control = get_example_control(),
                                     fit_k_params = get_example_fit_k_params(),
                                     fractional = TRUE)
hires_dat <- calculate_hires(fit_values = fit_values_all, method = "weighted", fractional = TRUE)
recreate_fit_values(peptide_sequence = "GFGDLKSPAGL", peptide_start = 1, peptide_end = 11,
                    hires_dat = hires_dat)
#>        n_1     k_1       n_2       k_2        n_3         k_3
#> 1 0.739994 8.62881 0.2122736 0.7086178 0.04871829 0.003279383

```
