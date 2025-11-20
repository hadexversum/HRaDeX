# Plots two uc plots side by side

This function plots two plots side by side for a peptide. The left plot
is uc plot with fitted model with its components. The right plot is
singular uc without logarithmic axis for the comparison of shape.
Basically, this function calls for other functions and plots the results
side by side. This function is aimed for the summary `Plots` panel in
HRaDeXGUI and does not have an interactive mode.

## Usage

``` r
plot_double_uc(fit_dat, fit_values, replicate = FALSE, fractional = TRUE)
```

## Arguments

- fit_dat:

  uptake data for selected peptide.

- fit_values:

  fit values for selected peptide.

- replicate:

  ...

- fractional:

  ...

## Value

a ggplot object.

## See also

plot_fitted_uc plot_singular_uc

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat)
fit_dat <- kin_dat[kin_dat[["ID"]]==1, ]
fit_k_params <- get_example_fit_k_params()
control <- get_example_control()
fit_values_all <- create_fit_dataset(kin_dat, fit_k_params, control)
fit_values <- fit_values_all[fit_values_all[["ID"]]==1, ]
plot_double_uc(fit_dat, fit_values)
#> Error in if (!is.na(fit_values[["class_name"]])) {    final_plot <- plot_lm(fit_dat, class_name = unique(fit_values[["class_name"]]),         interactive = interactive)}: argument is of length zero
```
