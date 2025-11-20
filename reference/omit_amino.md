# Omit first amino of peptides

In some approach, ommitting the first amino residue in the peptide is a
way to correct back-exchange. This function modifies provided dataset
and omits desired number of residues (omit parameter) effectively
changing the Start position of each peptide.

## Usage

``` r
omit_amino(dat, omit = 1)
```

## Arguments

- dat:

  dataset to be modified

- omit:

  numer of residues to me omitted for each peptide

## Value

data.frame in the same format as provided.

## Examples

``` r
fixed_dat <- omit_amino(alpha_dat)
head(fixed_dat)
#>      Protein Start   End   Sequence Modification MaxUptake      MHP       State
#>       <char> <num> <num>     <char>       <char>     <num>    <num>      <char>
#> 1: db_eEF1Ba     2    11 FGDLKSPAGL                      8 1061.563 ALPHA_Gamma
#> 2: db_eEF1Ba     2    11 FGDLKSPAGL                      8 1061.563 ALPHA_Gamma
#> 3: db_eEF1Ba     2    11 FGDLKSPAGL                      8 1061.563 ALPHA_Gamma
#> 4: db_eEF1Ba     2    11 FGDLKSPAGL                      8 1061.563 ALPHA_Gamma
#> 5: db_eEF1Ba     2    11 FGDLKSPAGL                      8 1061.563 ALPHA_Gamma
#> 6: db_eEF1Ba     2    11 FGDLKSPAGL                      8 1061.563 ALPHA_Gamma
#>    Exposure                              File     z  Inten    Center
#>       <num>                            <char> <int>  <num>     <num>
#> 1:    0.000 Tania_161112_eEF1Ba_KSCN_IMS_seq1     1 138844 1062.1913
#> 2:    0.000 Tania_161112_eEF1Ba_KSCN_IMS_seq1     2 728218  531.6754
#> 3:    0.167  Tania_161109_1eEF1Bag_KSCN_10sec     1  41100 1064.0150
#> 4:    0.167  Tania_161109_1eEF1Bag_KSCN_10sec     2 393115  532.4975
#> 5:    0.167  Tania_161109_2eEF1Bag_KSCN_10sec     1  46642 1063.9682
#> 6:    0.167  Tania_161109_2eEF1Bag_KSCN_10sec     2 466233  532.4951
```
