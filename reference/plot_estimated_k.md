# Plots estimated k

Plots the estimated k for residues. Estimated k for each are calculated
from classification results, treating the n (population) as the
probability of getting corresponding rate of exchange. The aggregation
of results is described in the vignette.

## Usage

``` r
plot_estimated_k(hires_params, interactive = FALSE)
```

## Arguments

- hires_params:

  data.frame with hires results, calculate using calculate_hires.

- interactive:

  ...

## Value

a girafe object.

## See also

calculate_hires

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat)
fit_k_params <- get_example_fit_k_params()
control <- get_example_control()
fit_values <- create_fit_dataset(kin_dat, fit_k_params, control)
hires_params <- calculate_hires(fit_values)
#> Error in if (method == "shortest") {    hires_params_ <- lapply(seq(1:protein_length), function(pos) {        if (fractional) {            tmp_params <- fit_values %>% filter(start <= pos &                 pos <= end & n_1 + n_2 + n_3 < 1.25)        }        else {            tmp_params <- fit_values %>% filter(start <= pos &                 pos <= end & n_1 + n_2 + n_3 - max_uptake <=                 0)        }        tmp_params <- tmp_params %>% filter(!class_name %in%             c("invalid", "invalid_uc")) %>% arrange(nchar(sequence),             class_name) %>% .[1, ]        if (nrow(tmp_params) == 0) {            data.frame(Protein = Protein, State = State, position = pos,                 n_1 = NA, k_1 = NA, n_2 = NA, k_2 = NA, n_3 = NA,                 k_3 = NA, k_est = NA, class_name = NA, color = NA)        }        else {            data.frame(Protein = Protein, State = State, position = pos,                 n_1 = tmp_params[["n_1"]], k_1 = tmp_params[["k_1"]],                 n_2 = tmp_params[["n_2"]], k_2 = tmp_params[["k_2"]],                 n_3 = tmp_params[["n_3"]], k_3 = tmp_params[["k_3"]],                 k_est = tmp_params[["k_est"]], class_name = tmp_params[["class_name"]],                 color = tmp_params[["color"]])        }    }) %>% bind_rows()}: the condition has length > 1
plot_estimated_k(hires_params)
#> Error: object 'hires_params' not found
```
