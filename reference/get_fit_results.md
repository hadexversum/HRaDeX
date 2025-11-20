# Uptake curve fitting function

This function analyses the supplied deuterium uptake curve for specific
peptide and provides the fitting results or assigned class. Firstly,
based on the absolute uptake values, the function check if the data
fulfills requirements to be assigned a class (invalid, none exchange).
If not, it is possible to fit a function in a specific workflow. To
create results for more than one peptide, see
[`create_fit_dataset`](https://hadexversum.github.io/HRaDeX/reference/create_fit_dataset.md)

## Usage

``` r
get_fit_results(
  fit_dat,
  fit_k_params,
  control = list(maxiter = 1000, scale = "levenberg"),
  trace = FALSE,
  workflow = 31,
  fractional = TRUE,
  omit_t_100 = FALSE,
  edge_times = c(min(fit_dat[["Exposure"]]), max(fit_dat[["Exposure"]]))
)
```

## Arguments

- fit_dat:

  uptake data used for fit, filtered uptake data for specific peptide

- fit_k_params:

  boundaries for exchange groups, example in prepare_kin_dat

- control:

  control options for the fitting process, example in
  [`get_example_control`](https://hadexversum.github.io/HRaDeX/reference/get_example_control.md)

- trace:

  logical, indicator if fitting trace is to be displayed

- workflow:

  workflow type, options: 321, 31, 21, indicating the types of functions
  used in fitting process

- fractional:

  logical, indicator if normalized values are used in the fitting
  process

- omit_t_100:

  logical, indicator if the measurement associated with t_100 is
  included in the fitting process or not

- edge_times:

  edge measurement times of the uptake curve

## Value

a data.frame object.

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat)
fit_dat <- kin_dat[kin_dat[["ID"]]==1,  ]
fit_k_params <- get_example_fit_k_params()
get_fit_results(fit_dat, fit_k_params)
#>       Protein       State    sequence start end max_uptake       n_1     k_1
#> n_1 db_eEF1Ba ALPHA_Gamma GFGDLKSPAGL     1  11          9 0.4770774 5.87002
#>           n_2       k_2       n_3        k_3          rss      bic class_name
#> n_1 0.3216569 0.1471729 0.2012657 0.01783039 2.773339e-32 -417.157         NA
#>        k_est fitted   color
#> n_1 2.851382      3 #7A5233
```
