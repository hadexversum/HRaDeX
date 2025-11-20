# Calculcate uptake

Function calculates deuterim uptake for one biological state, for
replicates, without additional aggregation of the data.

## Usage

``` r
calculate_replicate_state_uptake(
  rep_peptide_dat,
  state = dat[["State"]][1],
  time_0 = min(dat[["Exposure"]]),
  time_100 = max(dat[["Exposure"]])
)
```

## Arguments

- rep_peptide_dat:

  data from experimental file, but aggregated within technical
  replicates

- state:

  biological state

- time_0:

  minimal exchange control time point

- time_100:

  maximal exchange control time point

## Value

a data.frame object.

## See also

HaDeX::read_hdx

## Examples

``` r
rep_peptide_dat <- ...
#> Error: '...' used in an incorrect context
calculate_replicate_state_uptake(rep_peptide_dat)
#> Error: object 'rep_peptide_dat' not found
```
