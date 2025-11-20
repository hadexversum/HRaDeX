# Plots initial fit parameters

Plots a visualization of selected excahnge group limits, with initial
parameters for the fit. It is helpful for additional self-control of
chosen limits.

## Usage

``` r
plot_start_params(fit_k_params)
```

## Arguments

- fit_k_params:

  data.frame with k values for exchange groups

## Value

a ggplot2 object.

## Examples

``` r
fit_k_params <- get_example_fit_k_params()
plot_start_params(fit_k_params)
#> Warning: log-10 transformation introduced infinite values.
#> Warning: log-10 transformation introduced infinite values.
#> Warning: log-10 transformation introduced infinite values.
#> Warning: log-10 transformation introduced infinite values.
#> Warning: log-10 transformation introduced infinite values.
#> Warning: log-10 transformation introduced infinite values.

```
