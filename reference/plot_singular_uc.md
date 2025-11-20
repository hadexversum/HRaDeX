# Plots singular uptake curve

Function plots deuterium uptake plot (uc) for one peptide, in a
traditional mode. Currently not in use in GUIs.

## Usage

``` r
plot_singular_uc(
  fit_dat,
  fit_values,
  include_uc = TRUE,
  replicate = FALSE,
  fractional = TRUE,
  interactive = FALSE
)
```

## Arguments

- fit_dat:

  deuterium uptake data for one peptide

- fit_values:

  fit parameters for that one peptide, not used

- include_uc:

  indicator if regular uc should be plotted as well

- replicate:

  indicator if data for replicates should be plotted, or aggregated

- fractional:

  ...

- interactive:

  ...

## Value

a ggplot object. Need a conversion to girafe for interactive mode.

## See also

...

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat)
```
