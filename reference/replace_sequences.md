# Replace sequence with sequences within convention

The original peptide sequences are replaced with the peptide
convention - described in the get_sequence_bonds function. Moreover the
maximal uptake value is calculated based on the number of exchangeable
bonds according to the convention. Function from prepHaDeX.

## Usage

``` r
replace_sequences(dat, threshold = 0.3)
```

## Arguments

- dat:

  data with sequences to be replaced

## Examples

``` r
replace_sequences(alpha_dat)
#>          Sequence Start   End   Protein Modification       MHP       State
#>            <char> <num> <num>    <char>       <char>     <num>      <char>
#>    1: gfGDLKSpAGL     1    11 db_eEF1Ba              1061.5626 ALPHA_Gamma
#>    2: gfGDLKSpAGL     1    11 db_eEF1Ba              1061.5626 ALPHA_Gamma
#>    3: gfGDLKSpAGL     1    11 db_eEF1Ba              1061.5626 ALPHA_Gamma
#>    4: gfGDLKSpAGL     1    11 db_eEF1Ba              1061.5626 ALPHA_Gamma
#>    5: gfGDLKSpAGL     1    11 db_eEF1Ba              1061.5626 ALPHA_Gamma
#>   ---                                                                     
#> 9600:       dvAAF   217   221 db_eEF1Ba               522.2558  Alpha_KSCN
#> 9601:       dvAAF   217   221 db_eEF1Ba               522.2558  Alpha_KSCN
#> 9602:       dvAAF   217   221 db_eEF1Ba               522.2558  Alpha_KSCN
#> 9603:       dvAAF   217   221 db_eEF1Ba               522.2558  Alpha_KSCN
#> 9604:       dvAAF   217   221 db_eEF1Ba               522.2558  Alpha_KSCN
#>       Exposure                              File     z   Inten    Center
#>          <num>                            <char> <int>   <num>     <num>
#>    1:    0.000 Tania_161112_eEF1Ba_KSCN_IMS_seq1     1  138844 1062.1913
#>    2:    0.000 Tania_161112_eEF1Ba_KSCN_IMS_seq1     2  728218  531.6754
#>    3:    0.167  Tania_161109_1eEF1Bag_KSCN_10sec     1   41100 1064.0150
#>    4:    0.167  Tania_161109_1eEF1Bag_KSCN_10sec     2  393115  532.4975
#>    5:    0.167  Tania_161109_2eEF1Bag_KSCN_10sec     1   46642 1063.9682
#>   ---                                                                   
#> 9600:  150.000    Tania_161111_2eEF1Ba_KSCN_2_5h     1 1359937  524.7925
#> 9601:  150.000    Tania_161111_3eEF1Ba_KSCN_2_5h     1 1294714  524.7521
#> 9602: 1440.000     Tania_161111_1eEF1Ba_KSCN_out     1 1420195  524.7612
#> 9603: 1440.000     Tania_161112_2eEF1Ba_KSCN_out     1 1385283  524.7661
#> 9604: 1440.000     Tania_161112_3eEF1Ba_KSCN_out     1 1191113  524.7790
#>       MaxUptake
#>           <int>
#>    1:         8
#>    2:         8
#>    3:         8
#>    4:         8
#>    5:         8
#>   ---          
#> 9600:         3
#> 9601:         3
#> 9602:         3
#> 9603:         3
#> 9604:         3
```
