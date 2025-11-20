# Creates deuterium uptake replicate dataset

Wrapper for calculate_replicate_state_uptake, interating throught all
the peptides in provided data.

## Usage

``` r
create_replicate_state_uptake_dataset(
  rep_dat,
  state = dat[["State"]][1],
  time_0 = min(dat[["Exposure"]]),
  time_100 = max(dat[["Exposure"]])
)
```

## Arguments

- rep_dat:

  data

- state:

  biological state

- time_0:

  minimal exchange control time point

- time_100:

  maximal exchange control time point

## Value

a data.frame object.

## See also

calculate_replicate_state_uptake

## Examples

``` r
TODO
#> Error: object 'TODO' not found
```
