# Presents classification results on 3D structure

Plots the color classification on supplied 3d structure.

## Usage

``` r
plot_3d_structure_hires(hires_params, pdb_file_path)
```

## Arguments

- hires_params:

  ...

- pdb_file_path:

  ...

## Value

a r3dmol object.

## See also

calculate_hires

## Examples

``` r
pdb_file_path <- ...
#> Error: '...' used in an incorrect context
fit_k_params <- get_example_fit_k_params()
control <- get_example_control()
kin_dat <- prepare_kin_dat(alpha_dat)
fit_values <- create_fit_dataset(kin_dat = kin_dat, control = control, fit_k_params = fit_k_params)
hires_params <- calculate_hires(fit_values, method = "weighted")
plot_3d_structure_hires(hires_params, pdb_file_path)
#> Error: object 'pdb_file_path' not found
```
