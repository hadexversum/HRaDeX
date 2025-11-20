# Creates dataset with uc distances

This function iterates through common list of peptides in two states,
based on their position in the sequence. For each pair of peptide data,
the uc distance is calculated. The method of uc distance calucation is
described in the vigniette TODO.

## Usage

``` r
create_uc_distance_dataset(kin_dat_1, kin_dat_2)
```

## Arguments

- kin_dat_1:

  kinetic data for the first state

- kin_dat_2:

  kinetic data for the second state

## Value

data.frame for plotting functions

## See also

get_uc_distance plot_uc_distance

## Examples

``` r
kin_dat_1 <- prepare_kin_dat(alpha_dat, state = unique(alpha_dat[["State"]])[1])
kin_dat_2 <- prepare_kin_dat(alpha_dat, state = unique(alpha_dat[["State"]])[2])
uc_dist_dataset <- create_uc_distance_dataset(kin_dat_1, kin_dat_2)
head(uc_dist_dataset)
#> # A tibble: 6 × 8
#> # Groups:   MaxUptake, Start [6]
#>   MaxUptake Start   End frac_uptake_diff uptake_diff frac_uptake_dist
#>       <dbl> <dbl> <dbl>            <dbl>       <dbl>            <dbl>
#> 1         9     1    11             74.1       138.              4.23
#> 2         8     2    11             43.4        86.8             3.22
#> 3         7     3    11             34.8        59.6             2.76
#> 4         4     5    10            726.       4834.              3.45
#> 5         5     5    11             24.3        26.2             3.16
#> 6         5     9    14             44.4        58.4             3.67
#> # ℹ 2 more variables: uptake_dist <dbl>, Sequence <chr>
```
