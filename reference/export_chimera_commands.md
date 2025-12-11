# Export coloring commands for ChimeraX

This function prepares the coloring commands for ChimeraX in a form of
file that is downloaded as a results. If you wish only to create
coloring commands in a form of text variable, see
`prepare_chimera_commands` function.

## Usage

``` r
export_chimera_commands(
  hires_params,
  dominant = FALSE,
  state = hires_params[["State"]][1],
  chain = "A"
)
```

## Arguments

- state:

  biological state

- chain:

  chain for which the coloring commands are created

## Examples

``` r
fit_k_params <- get_example_fit_k_params()
control <- get_example_control()
kin_dat <- prepare_kin_dat(alpha_dat)
fit_values <- create_fit_dataset(kin_dat = kin_dat, control = control, fit_k_params = fit_k_params, fractional = TRUE)
hires_params <- calculate_hires(fit_values, method = "weighted", fractional = TRUE)

export_chimera_commands(hires_params, chain = "G")
export_chimera_commands(hires_params, chain = "G", dominant = TRUE)
```
