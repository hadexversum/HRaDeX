# Create peptide sequence list

This is a wrapper function for get_sequence_bonds - there are the
details. Function from prepHaDeX.

## Usage

``` r
create_sequence_list(dat, threshold = 0.3)
```

## Arguments

- dat:

  daa with peptide sequences

## Value

a peptide list with column containg sequence in convention.

## Examples

``` r
head(create_sequence_list(alpha_dat))
#> # A tibble: 6 × 5
#> # Rowwise: 
#>   Sequence    Start   End seq_bond    n_bonds
#>   <chr>       <dbl> <dbl> <chr>         <int>
#> 1 GFGDLKSPAGL     1    11 gfGDLKSpAGL       8
#> 2 FGDLKSPAGL      2    11 fgDLKSpAGL        7
#> 3 GDLKSPAGL       3    11 gdLKSpAGL         6
#> 4 LKSPAG          5    10 lkSpAG            3
#> 5 LKSPAGL         5    11 lkSpAGL           4
#> 6 AGLQVL          9    14 agLQVL            4
```
