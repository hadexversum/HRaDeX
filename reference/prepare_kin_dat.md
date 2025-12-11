# Creates uptake data from mass measurements

Function calculates deuterium uptake for each time point in the original
data with respect to the parameters.

## Usage

``` r
prepare_kin_dat(
  dat,
  state = dat[["State"]][1],
  time_0 = min(dat[["Exposure"]]),
  time_100 = max(dat[["Exposure"]]),
  replicate = FALSE,
  FD = FALSE
)
```

## Arguments

- dat:

  experimental data read by HaDeX2::read_hdx

- state:

  biological state

- time_0:

  minimal exchange control time point

- time_100:

  maximal exchange control time point

- replicate:

  indicator, if the replicate values should be provided, or aggregated

- FD:

  indicator, if the time_100 value should be used as fully deuterated
  control, only for normalization purposes, or left as time point of
  measurement

## Value

a data.frame object.

## See also

HaDeX2::read_hdx

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat)
head(kin_dat)
#>   ID Exposure   Protein    Sequence Start End       State MaxUptake
#> 1  1    0.167 db_eEF1Ba GFGDLKSPAGL     1  11 ALPHA_Gamma         9
#> 2  2    0.167 db_eEF1Ba  FGDLKSPAGL     2  11 ALPHA_Gamma         8
#> 3  3    0.167 db_eEF1Ba   GDLKSPAGL     3  11 ALPHA_Gamma         7
#> 4  4    0.167 db_eEF1Ba      LKSPAG     5  10 ALPHA_Gamma         4
#> 5  5    0.167 db_eEF1Ba     LKSPAGL     5  11 ALPHA_Gamma         5
#> 6  6    0.167 db_eEF1Ba      AGLQVL     9  14 ALPHA_Gamma         5
#>   frac_deut_uptake err_frac_deut_uptake deut_uptake err_deut_uptake
#> 1       0.30648518          0.002215405   1.6650534     0.003059254
#> 2       0.45857271          0.004640503   1.9851358     0.015897816
#> 3       0.46212246          0.004916810   2.0723573     0.018277096
#> 4       0.37704598          0.003147925   1.0428597     0.008524509
#> 5       0.37237034          0.002004330   1.1624757     0.006165483
#> 6       0.06834131          0.010370966   0.2395107     0.036235039
```
