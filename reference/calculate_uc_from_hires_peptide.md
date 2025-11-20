# Recovers deuterium uptake from hi-res parameters

This function recovers fractional deuterium uptake from high-resolution
level back to the peptide level. First, the values are aggregated into
high-resolution level using selected aggregation method. If there are no
calculated recovered values, probably the peptide was calssified as
invalid - check that in fit_values_all param to be sure.

## Usage

``` r
calculate_uc_from_hires_peptide(
  fit_dat,
  fit_values_all,
  hires_dat = NULL,
  fractional = TRUE,
  hires_method = c("shortest", "weighted")
)
```

## Arguments

- fit_dat:

  uptake data filtered for given peptide

- fit_values_all:

  fit parameters for whole peptide pool, unaggregated

- fractional:

  indicator if fractional values are used

- hires_method:

  method of aggregation

## See also

[`create_uc_from_hires_dataset`](https://hadexversum.github.io/HRaDeX/reference/create_uc_from_hires_dataset.md)

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat)
fit_values_all <- create_fit_dataset(kin_dat, control = get_example_control(),
                                     fit_k_params = get_example_fit_k_params_2(),
                                     fractional = TRUE)
fit_dat <- kin_dat[kin_dat[["ID"]] == 54, ]
calculate_uc_from_hires_peptide(fit_dat, fit_values_all, hires_method = "weighted")
#>     ID Exposure   Protein      Sequence Start End       State MaxUptake
#> 54  54    0.167 db_eEF1Ba AQYESKKAKKPAL   123 135 ALPHA_Gamma        11
#> 160 54    1.000 db_eEF1Ba AQYESKKAKKPAL   123 135 ALPHA_Gamma        11
#> 266 54    5.000 db_eEF1Ba AQYESKKAKKPAL   123 135 ALPHA_Gamma        11
#> 372 54   25.000 db_eEF1Ba AQYESKKAKKPAL   123 135 ALPHA_Gamma        11
#> 478 54  150.000 db_eEF1Ba AQYESKKAKKPAL   123 135 ALPHA_Gamma        11
#> 584 54 1440.000 db_eEF1Ba AQYESKKAKKPAL   123 135 ALPHA_Gamma        11
#>     frac_deut_uptake err_frac_deut_uptake deut_uptake err_deut_uptake
#> 54         1.0050906          0.005909147    6.914570      0.03778454
#> 160        1.0088279          0.009030163    6.940281      0.06027198
#> 266        1.0002711          0.007308584    6.881414      0.04801324
#> 372        1.0146063          0.003834244    6.980033      0.02160040
#> 478        0.9976205          0.006744683    6.863178      0.04394759
#> 584        1.0000000          0.003067458    6.879549      0.01492188
#>     hr_deut_uptake       hr_diff
#> 54       0.9920498  0.0130408257
#> 160      1.0000000  0.0088278969
#> 266      1.0000000  0.0002711289
#> 372      1.0000000  0.0146062980
#> 478      1.0000000 -0.0023795410
#> 584      1.0000000  0.0000000000
```
