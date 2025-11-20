# Plots uc with linear fit

Plots uptake curve for a peptide with linear fit. Used in GUI to present
uptake curves for edge cases, where the three-exponential model cannot
be fitted.

## Usage

``` r
plot_lm(fit_dat, class_name = NA, interactive = TRUE)
```

## Arguments

- fit_dat:

  deuterium uptake data for selected peptide.

- class_name:

  class name assigned to selected peptide.

- interactive:

  ...

## Value

a ggplot2 object. For interactive mode, conversion to girafe is needed.

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat)
fit_dat <- kin_dat[kin_dat[["ID"]]==1, ]
plot_lm(fit_dat, class_name = unique(fit_dat[["class_name"]]))
#> Warning: Ignoring unknown aesthetics: tooltip
#> Error in geom_point(aes(x = Exposure, y = deut_uptake, tooltip = glue("Sequence: {sequence}\n                                                Exposure: {Exposure}\n                                                DU = {formatC(deut_uptake, 2) Da}\n                                                Err DU = {formatC(err_deut_uptake, 2) Da}")),     shape = 1, size = 3): Problem while computing aesthetics.
#> ℹ Error occurred in the 1st layer.
#> Caused by error:
#> ! Failed to parse glue component
#> Caused by error in `parse()`:
#> ! <text>:1:25: unexpected symbol
#> 1: formatC(deut_uptake, 2) Da
#>                             ^
```
