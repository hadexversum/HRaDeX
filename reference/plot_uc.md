# Plots uc and fit parameters for peptide in two states.

This function plots the uptake curves for both biological states of a
peptide, alongside with the fit parameters. The peptides in two states
can be compared obly if have the same position in the whole protein
sequence.The biological states are distinguishable by the line type.
This is a part of comparative feature.

## Usage

``` r
plot_uc(
  fit_dat_1,
  fit_dat_2,
  fit_values_1,
  fit_values_2,
  fractional = FALSE,
  interactive = FALSE
)
```

## Arguments

- fit_dat_1:

  data.frame with uptake data for the peptide in first state

- fit_dat_2:

  data.frame with uptake data for the peptide in second state

- fit_values_1:

  data.frame with fit values for the peptide in first state

- fit_values_2:

  data.frame with fit values for the peptide in second state

- fractional:

  indicator if the values are fractional type

- interactive:

  logical, true for GUI

## Value

a ggiraph object.

## See also

create_fit_dataset prepare_kin_dat

## Examples

``` r
kin_dat_1 <- prepare_kin_dat(alpha_dat, state = unique(alpha_dat[["State"]])[1])
fit_dat_1 <- kin_dat_1[kin_dat_1[["ID"]] == 1, ]
fit_values_1 <- create_fit_dataset(fit_dat_1, control, fit_k_params)
#> Error: object 'control' not found
# the same for the second state, and then:
# plot_uc(fit_dat_1, fit_dat_2, fit_values_1, fit_values_2)
```
