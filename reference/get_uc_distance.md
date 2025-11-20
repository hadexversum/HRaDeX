# Calculates the uc distance for uptake curve

Calculates the uc distance between uptake curves for one peptide in two
biological states. The possible methods of caluclation is described in
the vignette TODO. This function supports comparison of two different
peptides provided that the values `Start`, `End`, `MaxUptake` and
`Exposure` are the same.

## Usage

``` r
get_uc_distance(fit_dat_1, fit_dat_2)
```

## Arguments

- fit_dat_1:

  data.frame with uc data for peptide in first state

- fit_dat_2:

  data.frame with uc data for peptide in second state

## Value

a one-row data.frame

## See also

create_uc_distance_dataset

## Examples

``` r
kin_dat_1 <- prepare_kin_dat(alpha_dat, state = unique(alpha_dat[["State"]])[1])
kin_dat_2 <- prepare_kin_dat(alpha_dat, state = unique(alpha_dat[["State"]])[2])
fit_dat_1 <- kin_dat_1[kin_dat_1[["ID"]] == 1, ]
fit_dat_2 <- kin_dat_2[kin_dat_2[["ID"]] == 1, ]
get_uc_distance(fit_dat_1, fit_dat_2)
#> # A tibble: 1 × 8
#> # Groups:   MaxUptake, Start [1]
#>   MaxUptake Start   End frac_uptake_diff uptake_diff frac_uptake_dist
#>       <dbl> <dbl> <dbl>            <dbl>       <dbl>            <dbl>
#> 1         9     1    11             74.1        138.           0.0423
#> # ℹ 2 more variables: uptake_dist <dbl>, Sequence <chr>
```
