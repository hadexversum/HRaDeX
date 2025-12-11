# Provides a peptide list

Created peptite list based on the provided data.frame.

## Usage

``` r
get_peptide_list(dat)
```

## Arguments

- dat:

  data.frame

## Value

a data.frame with position values, Start and End.

## Examples

``` r
dat <- HaDeX2::read_hdx(...)
#> Error: '...' used in an incorrect context
get_peptide_list(dat)
#> Error: object 'dat' not found
```
