# Creates dataset with merged hires parameters for two states.

This function merges the hires parameters for two biological states,
provided the same position values. It also calculates the color distance
and estimed k diffrence for each position. This function is part of
comparative feature.

## Usage

``` r
create_two_state_dataset(hires_params_1, hires_params_2)
```

## Arguments

- hires_params_1:

  data.frame with hires parameters for the first state

- hires_params_2:

  data.frame with hires parameters for the second state

## Value

data.frame for plotting functions

## See also

calculate_color_distance calculate_hires

## Examples

``` r
fit_k_params <- get_example_fit_k_params()
control <- get_example_control()
kin_dat <- prepare_kin_dat(alpha_dat)
fit_values <- create_fit_dataset(kin_dat, fit_k_params, control)
hires_params <- calculate_hires(fit_values)
#> Error in if (method == "shortest") {    hires_params_ <- lapply(seq(1:protein_length), function(pos) {        if (fractional) {            tmp_params <- fit_values %>% filter(start <= pos &                 pos <= end & n_1 + n_2 + n_3 < 1.25)        }        else {            tmp_params <- fit_values %>% filter(start <= pos &                 pos <= end & n_1 + n_2 + n_3 - max_uptake <=                 0)        }        tmp_params <- tmp_params %>% filter(!class_name %in%             c("invalid", "invalid_uc")) %>% arrange(nchar(sequence),             class_name) %>% .[1, ]        if (nrow(tmp_params) == 0) {            data.frame(Protein = Protein, State = State, position = pos,                 n_1 = NA, k_1 = NA, n_2 = NA, k_2 = NA, n_3 = NA,                 k_3 = NA, k_est = NA, class_name = NA, color = NA)        }        else {            data.frame(Protein = Protein, State = State, position = pos,                 n_1 = tmp_params[["n_1"]], k_1 = tmp_params[["k_1"]],                 n_2 = tmp_params[["n_2"]], k_2 = tmp_params[["k_2"]],                 n_3 = tmp_params[["n_3"]], k_3 = tmp_params[["k_3"]],                 k_est = tmp_params[["k_est"]], class_name = tmp_params[["class_name"]],                 color = tmp_params[["color"]])        }    }) %>% bind_rows()}: the condition has length > 1
# same for the second state, and then:
# create_two_state_dataset(hires_params, hires_params_2)
```
