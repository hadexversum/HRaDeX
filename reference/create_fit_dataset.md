# Create fits for the whole peptide pool

This function calls the fitting function
[`get_fit_results`](https://hadexversum.github.io/HRaDeX/reference/get_fit_results.md)
for each peptide in supplied kin_dat creating the dataset for whole
peptide pool.

## Usage

``` r
create_fit_dataset(
  kin_dat,
  fit_k_params,
  control = list(maxiter = 1000, scale = "levenberg"),
  trace = FALSE,
  fractional = FALSE,
  omit_t_100 = FALSE,
  workflow = 321
)
```

## Arguments

- kin_dat:

  calculated uptake data for one biological state, result of e.q.
  [`prepare_kin_dat`](https://hadexversum.github.io/HRaDeX/reference/prepare_kin_dat.md)

- fit_k_params:

  boundaries for exchange groups, example in prepare_kin_dat

- control:

  control options for the fitting process, example in
  [`get_example_control`](https://hadexversum.github.io/HRaDeX/reference/get_example_control.md)

- trace:

  logical, indicator if fitting trace is to be displayed

- fractional:

  logical, indicator if normalized values are used in the fitting
  process

- workflow:

  workflow type, options: 321, 31, 21, indicating the types of functions
  used in fitting process

## Value

a data.frame object.

## See also

[`get_fit_results`](https://hadexversum.github.io/HRaDeX/reference/get_fit_results.md)
[`prepare_kin_dat`](https://hadexversum.github.io/HRaDeX/reference/prepare_kin_dat.md)
[`get_example_fit_k_params`](https://hadexversum.github.io/HRaDeX/reference/get_example_fit_k_params.md)
[`get_example_control`](https://hadexversum.github.io/HRaDeX/reference/get_example_control.md)

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat)
fit_k_params <- get_example_fit_k_params()
head(create_fit_dataset(kin_dat, fit_k_params))
#>   id   Protein       State    sequence start end max_uptake      n_1      k_1
#> 1  1 db_eEF1Ba ALPHA_Gamma GFGDLKSPAGL     1  11          9 2.591836 5.870020
#> 2  2 db_eEF1Ba ALPHA_Gamma  FGDLKSPAGL     2  11          8 2.649596 7.234888
#> 3  3 db_eEF1Ba ALPHA_Gamma   GDLKSPAGL     3  11          7 2.701359 7.507887
#> 4  4 db_eEF1Ba ALPHA_Gamma      LKSPAG     5  10          4 1.395326 6.717443
#> 5  5 db_eEF1Ba ALPHA_Gamma     LKSPAGL     5  11          5 1.526319 6.866652
#> 6  6 db_eEF1Ba ALPHA_Gamma      AGLQVL     9  14          5 1.000000 1.000000
#>        n_2       k_2      n_3          k_3          rss         bic class_name
#> 1 1.747477 0.1471729 1.093423 0.0178303882 1.183291e-30 -394.636496         NA
#> 2 1.671734 0.4732856 0.000000 0.0000000000 8.022972e-03  -13.717175         NA
#> 3 1.805400 0.4905359 0.000000 0.0000000000 2.168912e-03  -21.565674         NA
#> 4 1.356225 0.4680721 0.000000 0.0000000000 1.133739e-03  -25.457904         NA
#> 5 1.585653 0.4754323 0.000000 0.0000000000 1.075759e-03  -25.772868         NA
#> 6 1.660464 0.2151596 1.783585 0.0004384549 1.059401e-02   -8.465776         NA
#>       k_est fitted   color
#> 1 2.8513818      3 #7A5233
#> 2 4.6191186      2 #9C6300
#> 3 4.6967479      2 #996600
#> 4 3.6371609      2 #817E00
#> 5 3.6101125      2 #7D8200
#> 6 0.3055877      3 #395F66
```
