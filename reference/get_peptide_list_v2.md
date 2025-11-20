# Provides a peptide list

Created peptite list from two binded data.frames. The peptides are
selected based on their position values. If there are two peptides with
the same position but different sequence, both sequences are shown in
the final data.frame.

## Usage

``` r
get_peptide_list_v2(dat_1, dat_2)
```

## Arguments

- dat_1:

  data.frame

- dat_2:

  data.frame

## Value

a data.frame with sequence and position values.

## Examples

``` r
dat_1 <- HaDeX::read_hdx(...)
#> Error: '...' used in an incorrect context
dat_2 <- HaDeX::read_hdx(...)
#> Error: '...' used in an incorrect context
get_peptide_list_v2(dat_1, dat_2)
#> Error: object 'dat_1' not found
```
