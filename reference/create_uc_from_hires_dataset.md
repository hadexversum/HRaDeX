# Creates recovered deuterium uptake dataset

Wrapper for
[`calculate_uc_from_hires_peptide`](https://hadexversum.github.io/HRaDeX/reference/calculate_uc_from_hires_peptide.md)
to create the data for whole pepitde pool.

## Usage

``` r
create_uc_from_hires_dataset(
  kin_dat,
  fit_values_all,
  fractional = TRUE,
  hires_method = c("shortest", "weighted")
)
```

## Arguments

- kin_dat:

  uptake data for the whole peptide pool

- fit_values_all:

  fit parameters for whole peptide pool, unaggregated

- fractional:

  indicator if fractional values are used

- hires_method:

  method of aggregation

## See also

[`calculate_uc_from_hires_peptide`](https://hadexversum.github.io/HRaDeX/reference/calculate_uc_from_hires_peptide.md)

## Examples

``` r
kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
fit_values_all <- create_fit_dataset(kin_dat, control = get_example_control(),
                                     fit_k_params = get_example_fit_k_params(),
                                     fractional = T)
create_uc_from_hires_dataset(kin_dat, fit_values_all, hires_method = "shortest")
#>      ID   Protein      State                     Sequence Start End MaxUptake
#> 1     1 db_eEF1Ba Alpha_KSCN                  GFGDLKSPAGL     1  11         9
#> 2     1 db_eEF1Ba Alpha_KSCN                  GFGDLKSPAGL     1  11         9
#> 3     1 db_eEF1Ba Alpha_KSCN                  GFGDLKSPAGL     1  11         9
#> 4     1 db_eEF1Ba Alpha_KSCN                  GFGDLKSPAGL     1  11         9
#> 5     1 db_eEF1Ba Alpha_KSCN                  GFGDLKSPAGL     1  11         9
#> 6     1 db_eEF1Ba Alpha_KSCN                  GFGDLKSPAGL     1  11         9
#> 7     2 db_eEF1Ba Alpha_KSCN                   FGDLKSPAGL     2  11         8
#> 8     2 db_eEF1Ba Alpha_KSCN                   FGDLKSPAGL     2  11         8
#> 9     2 db_eEF1Ba Alpha_KSCN                   FGDLKSPAGL     2  11         8
#> 10    2 db_eEF1Ba Alpha_KSCN                   FGDLKSPAGL     2  11         8
#> 11    2 db_eEF1Ba Alpha_KSCN                   FGDLKSPAGL     2  11         8
#> 12    2 db_eEF1Ba Alpha_KSCN                   FGDLKSPAGL     2  11         8
#> 13    3 db_eEF1Ba Alpha_KSCN                    GDLKSPAGL     3  11         7
#> 14    3 db_eEF1Ba Alpha_KSCN                    GDLKSPAGL     3  11         7
#> 15    3 db_eEF1Ba Alpha_KSCN                    GDLKSPAGL     3  11         7
#> 16    3 db_eEF1Ba Alpha_KSCN                    GDLKSPAGL     3  11         7
#> 17    3 db_eEF1Ba Alpha_KSCN                    GDLKSPAGL     3  11         7
#> 18    3 db_eEF1Ba Alpha_KSCN                    GDLKSPAGL     3  11         7
#> 19    4 db_eEF1Ba Alpha_KSCN                       LKSPAG     5  10         4
#> 20    4 db_eEF1Ba Alpha_KSCN                       LKSPAG     5  10         4
#> 21    4 db_eEF1Ba Alpha_KSCN                       LKSPAG     5  10         4
#> 22    4 db_eEF1Ba Alpha_KSCN                       LKSPAG     5  10         4
#> 23    4 db_eEF1Ba Alpha_KSCN                       LKSPAG     5  10         4
#> 24    4 db_eEF1Ba Alpha_KSCN                       LKSPAG     5  10         4
#> 25    5 db_eEF1Ba Alpha_KSCN                      LKSPAGL     5  11         5
#> 26    5 db_eEF1Ba Alpha_KSCN                      LKSPAGL     5  11         5
#> 27    5 db_eEF1Ba Alpha_KSCN                      LKSPAGL     5  11         5
#> 28    5 db_eEF1Ba Alpha_KSCN                      LKSPAGL     5  11         5
#> 29    5 db_eEF1Ba Alpha_KSCN                      LKSPAGL     5  11         5
#> 30    5 db_eEF1Ba Alpha_KSCN                      LKSPAGL     5  11         5
#> 31    6 db_eEF1Ba Alpha_KSCN                       AGLQVL     9  14         5
#> 32    6 db_eEF1Ba Alpha_KSCN                       AGLQVL     9  14         5
#> 33    6 db_eEF1Ba Alpha_KSCN                       AGLQVL     9  14         5
#> 34    6 db_eEF1Ba Alpha_KSCN                       AGLQVL     9  14         5
#> 35    6 db_eEF1Ba Alpha_KSCN                       AGLQVL     9  14         5
#> 36    6 db_eEF1Ba Alpha_KSCN                       AGLQVL     9  14         5
#> 37    7 db_eEF1Ba Alpha_KSCN                        QVLND    12  16         4
#> 38    7 db_eEF1Ba Alpha_KSCN                        QVLND    12  16         4
#> 39    7 db_eEF1Ba Alpha_KSCN                        QVLND    12  16         4
#> 40    7 db_eEF1Ba Alpha_KSCN                        QVLND    12  16         4
#> 41    7 db_eEF1Ba Alpha_KSCN                        QVLND    12  16         4
#> 42    7 db_eEF1Ba Alpha_KSCN                        QVLND    12  16         4
#> 43    8 db_eEF1Ba Alpha_KSCN                       QVLNDY    12  17         5
#> 44    8 db_eEF1Ba Alpha_KSCN                       QVLNDY    12  17         5
#> 45    8 db_eEF1Ba Alpha_KSCN                       QVLNDY    12  17         5
#> 46    8 db_eEF1Ba Alpha_KSCN                       QVLNDY    12  17         5
#> 47    8 db_eEF1Ba Alpha_KSCN                       QVLNDY    12  17         5
#> 48    8 db_eEF1Ba Alpha_KSCN                       QVLNDY    12  17         5
#> 49    9 db_eEF1Ba Alpha_KSCN                       NDYLAD    15  20         5
#> 50    9 db_eEF1Ba Alpha_KSCN                       NDYLAD    15  20         5
#> 51    9 db_eEF1Ba Alpha_KSCN                       NDYLAD    15  20         5
#> 52    9 db_eEF1Ba Alpha_KSCN                       NDYLAD    15  20         5
#> 53    9 db_eEF1Ba Alpha_KSCN                       NDYLAD    15  20         5
#> 54    9 db_eEF1Ba Alpha_KSCN                       NDYLAD    15  20         5
#> 55   10 db_eEF1Ba Alpha_KSCN                      NDYLADK    15  21         6
#> 56   10 db_eEF1Ba Alpha_KSCN                      NDYLADK    15  21         6
#> 57   10 db_eEF1Ba Alpha_KSCN                      NDYLADK    15  21         6
#> 58   10 db_eEF1Ba Alpha_KSCN                      NDYLADK    15  21         6
#> 59   10 db_eEF1Ba Alpha_KSCN                      NDYLADK    15  21         6
#> 60   10 db_eEF1Ba Alpha_KSCN                      NDYLADK    15  21         6
#> 61   11 db_eEF1Ba Alpha_KSCN                       YLADKS    17  22         5
#> 62   11 db_eEF1Ba Alpha_KSCN                       YLADKS    17  22         5
#> 63   11 db_eEF1Ba Alpha_KSCN                       YLADKS    17  22         5
#> 64   11 db_eEF1Ba Alpha_KSCN                       YLADKS    17  22         5
#> 65   11 db_eEF1Ba Alpha_KSCN                       YLADKS    17  22         5
#> 66   11 db_eEF1Ba Alpha_KSCN                       YLADKS    17  22         5
#> 67   12 db_eEF1Ba Alpha_KSCN                      YLADKSY    17  23         6
#> 68   12 db_eEF1Ba Alpha_KSCN                      YLADKSY    17  23         6
#> 69   12 db_eEF1Ba Alpha_KSCN                      YLADKSY    17  23         6
#> 70   12 db_eEF1Ba Alpha_KSCN                      YLADKSY    17  23         6
#> 71   12 db_eEF1Ba Alpha_KSCN                      YLADKSY    17  23         6
#> 72   12 db_eEF1Ba Alpha_KSCN                      YLADKSY    17  23         6
#> 73   13 db_eEF1Ba Alpha_KSCN            YLADKSYIEGYVPSQAD    17  33        15
#> 74   13 db_eEF1Ba Alpha_KSCN            YLADKSYIEGYVPSQAD    17  33        15
#> 75   13 db_eEF1Ba Alpha_KSCN            YLADKSYIEGYVPSQAD    17  33        15
#> 76   13 db_eEF1Ba Alpha_KSCN            YLADKSYIEGYVPSQAD    17  33        15
#> 77   13 db_eEF1Ba Alpha_KSCN            YLADKSYIEGYVPSQAD    17  33        15
#> 78   13 db_eEF1Ba Alpha_KSCN            YLADKSYIEGYVPSQAD    17  33        15
#> 79   14 db_eEF1Ba Alpha_KSCN              ADKSYIEGYVPSQAD    19  33        13
#> 80   14 db_eEF1Ba Alpha_KSCN              ADKSYIEGYVPSQAD    19  33        13
#> 81   14 db_eEF1Ba Alpha_KSCN              ADKSYIEGYVPSQAD    19  33        13
#> 82   14 db_eEF1Ba Alpha_KSCN              ADKSYIEGYVPSQAD    19  33        13
#> 83   14 db_eEF1Ba Alpha_KSCN              ADKSYIEGYVPSQAD    19  33        13
#> 84   14 db_eEF1Ba Alpha_KSCN              ADKSYIEGYVPSQAD    19  33        13
#> 85   15 db_eEF1Ba Alpha_KSCN                KSYIEGYVPSQAD    21  33        11
#> 86   15 db_eEF1Ba Alpha_KSCN                KSYIEGYVPSQAD    21  33        11
#> 87   15 db_eEF1Ba Alpha_KSCN                KSYIEGYVPSQAD    21  33        11
#> 88   15 db_eEF1Ba Alpha_KSCN                KSYIEGYVPSQAD    21  33        11
#> 89   15 db_eEF1Ba Alpha_KSCN                KSYIEGYVPSQAD    21  33        11
#> 90   15 db_eEF1Ba Alpha_KSCN                KSYIEGYVPSQAD    21  33        11
#> 91   16 db_eEF1Ba Alpha_KSCN                        SYIEG    22  26         4
#> 92   16 db_eEF1Ba Alpha_KSCN                        SYIEG    22  26         4
#> 93   16 db_eEF1Ba Alpha_KSCN                        SYIEG    22  26         4
#> 94   16 db_eEF1Ba Alpha_KSCN                        SYIEG    22  26         4
#> 95   16 db_eEF1Ba Alpha_KSCN                        SYIEG    22  26         4
#> 96   16 db_eEF1Ba Alpha_KSCN                        SYIEG    22  26         4
#> 97   17 db_eEF1Ba Alpha_KSCN                 SYIEGYVPSQAD    22  33        10
#> 98   17 db_eEF1Ba Alpha_KSCN                 SYIEGYVPSQAD    22  33        10
#> 99   17 db_eEF1Ba Alpha_KSCN                 SYIEGYVPSQAD    22  33        10
#> 100  17 db_eEF1Ba Alpha_KSCN                 SYIEGYVPSQAD    22  33        10
#> 101  17 db_eEF1Ba Alpha_KSCN                 SYIEGYVPSQAD    22  33        10
#> 102  17 db_eEF1Ba Alpha_KSCN                 SYIEGYVPSQAD    22  33        10
#> 103  18 db_eEF1Ba Alpha_KSCN                  YIEGYVPSQAD    23  33         9
#> 104  18 db_eEF1Ba Alpha_KSCN                  YIEGYVPSQAD    23  33         9
#> 105  18 db_eEF1Ba Alpha_KSCN                  YIEGYVPSQAD    23  33         9
#> 106  18 db_eEF1Ba Alpha_KSCN                  YIEGYVPSQAD    23  33         9
#> 107  18 db_eEF1Ba Alpha_KSCN                  YIEGYVPSQAD    23  33         9
#> 108  18 db_eEF1Ba Alpha_KSCN                  YIEGYVPSQAD    23  33         9
#> 109  19 db_eEF1Ba Alpha_KSCN                       IEGYVP    24  29         4
#> 110  19 db_eEF1Ba Alpha_KSCN                       IEGYVP    24  29         4
#> 111  19 db_eEF1Ba Alpha_KSCN                       IEGYVP    24  29         4
#> 112  19 db_eEF1Ba Alpha_KSCN                       IEGYVP    24  29         4
#> 113  19 db_eEF1Ba Alpha_KSCN                       IEGYVP    24  29         4
#> 114  19 db_eEF1Ba Alpha_KSCN                       IEGYVP    24  29         4
#> 115  20 db_eEF1Ba Alpha_KSCN                    IEGYVPSQA    24  32         7
#> 116  20 db_eEF1Ba Alpha_KSCN                    IEGYVPSQA    24  32         7
#> 117  20 db_eEF1Ba Alpha_KSCN                    IEGYVPSQA    24  32         7
#> 118  20 db_eEF1Ba Alpha_KSCN                    IEGYVPSQA    24  32         7
#> 119  20 db_eEF1Ba Alpha_KSCN                    IEGYVPSQA    24  32         7
#> 120  20 db_eEF1Ba Alpha_KSCN                    IEGYVPSQA    24  32         7
#> 121  21 db_eEF1Ba Alpha_KSCN                   IEGYVPSQAD    24  33         8
#> 122  21 db_eEF1Ba Alpha_KSCN                   IEGYVPSQAD    24  33         8
#> 123  21 db_eEF1Ba Alpha_KSCN                   IEGYVPSQAD    24  33         8
#> 124  21 db_eEF1Ba Alpha_KSCN                   IEGYVPSQAD    24  33         8
#> 125  21 db_eEF1Ba Alpha_KSCN                   IEGYVPSQAD    24  33         8
#> 126  21 db_eEF1Ba Alpha_KSCN                   IEGYVPSQAD    24  33         8
#> 127  22 db_eEF1Ba Alpha_KSCN                      YVPSQAD    27  33         5
#> 128  22 db_eEF1Ba Alpha_KSCN                      YVPSQAD    27  33         5
#> 129  22 db_eEF1Ba Alpha_KSCN                      YVPSQAD    27  33         5
#> 130  22 db_eEF1Ba Alpha_KSCN                      YVPSQAD    27  33         5
#> 131  22 db_eEF1Ba Alpha_KSCN                      YVPSQAD    27  33         5
#> 132  22 db_eEF1Ba Alpha_KSCN                      YVPSQAD    27  33         5
#> 133  23 db_eEF1Ba Alpha_KSCN                        VAVFE    34  38         4
#> 134  23 db_eEF1Ba Alpha_KSCN                        VAVFE    34  38         4
#> 135  23 db_eEF1Ba Alpha_KSCN                        VAVFE    34  38         4
#> 136  23 db_eEF1Ba Alpha_KSCN                        VAVFE    34  38         4
#> 137  23 db_eEF1Ba Alpha_KSCN                        VAVFE    34  38         4
#> 138  23 db_eEF1Ba Alpha_KSCN                        VAVFE    34  38         4
#> 139  24 db_eEF1Ba Alpha_KSCN                  FEAVSSPPPAD    37  47         7
#> 140  24 db_eEF1Ba Alpha_KSCN                  FEAVSSPPPAD    37  47         7
#> 141  24 db_eEF1Ba Alpha_KSCN                  FEAVSSPPPAD    37  47         7
#> 142  24 db_eEF1Ba Alpha_KSCN                  FEAVSSPPPAD    37  47         7
#> 143  24 db_eEF1Ba Alpha_KSCN                  FEAVSSPPPAD    37  47         7
#> 144  24 db_eEF1Ba Alpha_KSCN                  FEAVSSPPPAD    37  47         7
#> 145  25 db_eEF1Ba Alpha_KSCN                 FEAVSSPPPADL    37  48         8
#> 146  25 db_eEF1Ba Alpha_KSCN                 FEAVSSPPPADL    37  48         8
#> 147  25 db_eEF1Ba Alpha_KSCN                 FEAVSSPPPADL    37  48         8
#> 148  25 db_eEF1Ba Alpha_KSCN                 FEAVSSPPPADL    37  48         8
#> 149  25 db_eEF1Ba Alpha_KSCN                 FEAVSSPPPADL    37  48         8
#> 150  25 db_eEF1Ba Alpha_KSCN                 FEAVSSPPPADL    37  48         8
#> 151  26 db_eEF1Ba Alpha_KSCN               FEAVSSPPPADLCH    37  50        10
#> 152  26 db_eEF1Ba Alpha_KSCN               FEAVSSPPPADLCH    37  50        10
#> 153  26 db_eEF1Ba Alpha_KSCN               FEAVSSPPPADLCH    37  50        10
#> 154  26 db_eEF1Ba Alpha_KSCN               FEAVSSPPPADLCH    37  50        10
#> 155  26 db_eEF1Ba Alpha_KSCN               FEAVSSPPPADLCH    37  50        10
#> 156  26 db_eEF1Ba Alpha_KSCN               FEAVSSPPPADLCH    37  50        10
#> 157  27 db_eEF1Ba Alpha_KSCN              FEAVSSPPPADLCHA    37  51        11
#> 158  27 db_eEF1Ba Alpha_KSCN              FEAVSSPPPADLCHA    37  51        11
#> 159  27 db_eEF1Ba Alpha_KSCN              FEAVSSPPPADLCHA    37  51        11
#> 160  27 db_eEF1Ba Alpha_KSCN              FEAVSSPPPADLCHA    37  51        11
#> 161  27 db_eEF1Ba Alpha_KSCN              FEAVSSPPPADLCHA    37  51        11
#> 162  27 db_eEF1Ba Alpha_KSCN              FEAVSSPPPADLCHA    37  51        11
#> 163  28 db_eEF1Ba Alpha_KSCN                  EAVSSPPPADL    38  48         7
#> 164  28 db_eEF1Ba Alpha_KSCN                  EAVSSPPPADL    38  48         7
#> 165  28 db_eEF1Ba Alpha_KSCN                  EAVSSPPPADL    38  48         7
#> 166  28 db_eEF1Ba Alpha_KSCN                  EAVSSPPPADL    38  48         7
#> 167  28 db_eEF1Ba Alpha_KSCN                  EAVSSPPPADL    38  48         7
#> 168  28 db_eEF1Ba Alpha_KSCN                  EAVSSPPPADL    38  48         7
#> 169  29 db_eEF1Ba Alpha_KSCN                EAVSSPPPADLCH    38  50         9
#> 170  29 db_eEF1Ba Alpha_KSCN                EAVSSPPPADLCH    38  50         9
#> 171  29 db_eEF1Ba Alpha_KSCN                EAVSSPPPADLCH    38  50         9
#> 172  29 db_eEF1Ba Alpha_KSCN                EAVSSPPPADLCH    38  50         9
#> 173  29 db_eEF1Ba Alpha_KSCN                EAVSSPPPADLCH    38  50         9
#> 174  29 db_eEF1Ba Alpha_KSCN                EAVSSPPPADLCH    38  50         9
#> 175  30 db_eEF1Ba Alpha_KSCN               EAVSSPPPADLCHA    38  51        10
#> 176  30 db_eEF1Ba Alpha_KSCN               EAVSSPPPADLCHA    38  51        10
#> 177  30 db_eEF1Ba Alpha_KSCN               EAVSSPPPADLCHA    38  51        10
#> 178  30 db_eEF1Ba Alpha_KSCN               EAVSSPPPADLCHA    38  51        10
#> 179  30 db_eEF1Ba Alpha_KSCN               EAVSSPPPADLCHA    38  51        10
#> 180  30 db_eEF1Ba Alpha_KSCN               EAVSSPPPADLCHA    38  51        10
#> 181  31 db_eEF1Ba Alpha_KSCN                   AVSSPPPADL    39  48         6
#> 182  31 db_eEF1Ba Alpha_KSCN                   AVSSPPPADL    39  48         6
#> 183  31 db_eEF1Ba Alpha_KSCN                   AVSSPPPADL    39  48         6
#> 184  31 db_eEF1Ba Alpha_KSCN                   AVSSPPPADL    39  48         6
#> 185  31 db_eEF1Ba Alpha_KSCN                   AVSSPPPADL    39  48         6
#> 186  31 db_eEF1Ba Alpha_KSCN                   AVSSPPPADL    39  48         6
#> 187  32 db_eEF1Ba Alpha_KSCN                    VSSPPPADL    40  48         5
#> 188  32 db_eEF1Ba Alpha_KSCN                    VSSPPPADL    40  48         5
#> 189  32 db_eEF1Ba Alpha_KSCN                    VSSPPPADL    40  48         5
#> 190  32 db_eEF1Ba Alpha_KSCN                    VSSPPPADL    40  48         5
#> 191  32 db_eEF1Ba Alpha_KSCN                    VSSPPPADL    40  48         5
#> 192  32 db_eEF1Ba Alpha_KSCN                    VSSPPPADL    40  48         5
#> 193  33 db_eEF1Ba Alpha_KSCN                  VSSPPPADLCH    40  50         7
#> 194  33 db_eEF1Ba Alpha_KSCN                  VSSPPPADLCH    40  50         7
#> 195  33 db_eEF1Ba Alpha_KSCN                  VSSPPPADLCH    40  50         7
#> 196  33 db_eEF1Ba Alpha_KSCN                  VSSPPPADLCH    40  50         7
#> 197  33 db_eEF1Ba Alpha_KSCN                  VSSPPPADLCH    40  50         7
#> 198  33 db_eEF1Ba Alpha_KSCN                  VSSPPPADLCH    40  50         7
#> 199  34 db_eEF1Ba Alpha_KSCN                      ALRWYNH    51  57         6
#> 200  34 db_eEF1Ba Alpha_KSCN                      ALRWYNH    51  57         6
#> 201  34 db_eEF1Ba Alpha_KSCN                      ALRWYNH    51  57         6
#> 202  34 db_eEF1Ba Alpha_KSCN                      ALRWYNH    51  57         6
#> 203  34 db_eEF1Ba Alpha_KSCN                      ALRWYNH    51  57         6
#> 204  34 db_eEF1Ba Alpha_KSCN                      ALRWYNH    51  57         6
#> 205  35 db_eEF1Ba Alpha_KSCN                       LRWYNH    52  57         5
#> 206  35 db_eEF1Ba Alpha_KSCN                       LRWYNH    52  57         5
#> 207  35 db_eEF1Ba Alpha_KSCN                       LRWYNH    52  57         5
#> 208  35 db_eEF1Ba Alpha_KSCN                       LRWYNH    52  57         5
#> 209  35 db_eEF1Ba Alpha_KSCN                       LRWYNH    52  57         5
#> 210  35 db_eEF1Ba Alpha_KSCN                       LRWYNH    52  57         5
#> 211  36 db_eEF1Ba Alpha_KSCN             IKSYEKEKASLPGVKK    58  73        14
#> 212  36 db_eEF1Ba Alpha_KSCN             IKSYEKEKASLPGVKK    58  73        14
#> 213  36 db_eEF1Ba Alpha_KSCN             IKSYEKEKASLPGVKK    58  73        14
#> 214  36 db_eEF1Ba Alpha_KSCN             IKSYEKEKASLPGVKK    58  73        14
#> 215  36 db_eEF1Ba Alpha_KSCN             IKSYEKEKASLPGVKK    58  73        14
#> 216  36 db_eEF1Ba Alpha_KSCN             IKSYEKEKASLPGVKK    58  73        14
#> 217  37 db_eEF1Ba Alpha_KSCN        IKSYEKEKASLPGVKKALGKY    58  78        19
#> 218  37 db_eEF1Ba Alpha_KSCN        IKSYEKEKASLPGVKKALGKY    58  78        19
#> 219  37 db_eEF1Ba Alpha_KSCN        IKSYEKEKASLPGVKKALGKY    58  78        19
#> 220  37 db_eEF1Ba Alpha_KSCN        IKSYEKEKASLPGVKKALGKY    58  78        19
#> 221  37 db_eEF1Ba Alpha_KSCN        IKSYEKEKASLPGVKKALGKY    58  78        19
#> 222  37 db_eEF1Ba Alpha_KSCN        IKSYEKEKASLPGVKKALGKY    58  78        19
#> 223  38 db_eEF1Ba Alpha_KSCN              EKASLPGVKKALGKY    64  78        13
#> 224  38 db_eEF1Ba Alpha_KSCN              EKASLPGVKKALGKY    64  78        13
#> 225  38 db_eEF1Ba Alpha_KSCN              EKASLPGVKKALGKY    64  78        13
#> 226  38 db_eEF1Ba Alpha_KSCN              EKASLPGVKKALGKY    64  78        13
#> 227  38 db_eEF1Ba Alpha_KSCN              EKASLPGVKKALGKY    64  78        13
#> 228  38 db_eEF1Ba Alpha_KSCN              EKASLPGVKKALGKY    64  78        13
#> 229  39 db_eEF1Ba Alpha_KSCN          EKASLPGVKKALGKYGPAD    64  82        16
#> 230  39 db_eEF1Ba Alpha_KSCN          EKASLPGVKKALGKYGPAD    64  82        16
#> 231  39 db_eEF1Ba Alpha_KSCN          EKASLPGVKKALGKYGPAD    64  82        16
#> 232  39 db_eEF1Ba Alpha_KSCN          EKASLPGVKKALGKYGPAD    64  82        16
#> 233  39 db_eEF1Ba Alpha_KSCN          EKASLPGVKKALGKYGPAD    64  82        16
#> 234  39 db_eEF1Ba Alpha_KSCN          EKASLPGVKKALGKYGPAD    64  82        16
#> 235  40 db_eEF1Ba Alpha_KSCN        EKASLPGVKKALGKYGPADVE    64  84        18
#> 236  40 db_eEF1Ba Alpha_KSCN        EKASLPGVKKALGKYGPADVE    64  84        18
#> 237  40 db_eEF1Ba Alpha_KSCN        EKASLPGVKKALGKYGPADVE    64  84        18
#> 238  40 db_eEF1Ba Alpha_KSCN        EKASLPGVKKALGKYGPADVE    64  84        18
#> 239  40 db_eEF1Ba Alpha_KSCN        EKASLPGVKKALGKYGPADVE    64  84        18
#> 240  40 db_eEF1Ba Alpha_KSCN        EKASLPGVKKALGKYGPADVE    64  84        18
#> 241  41 db_eEF1Ba Alpha_KSCN            ASLPGVKKALGKYGPAD    66  82        14
#> 242  41 db_eEF1Ba Alpha_KSCN            ASLPGVKKALGKYGPAD    66  82        14
#> 243  41 db_eEF1Ba Alpha_KSCN            ASLPGVKKALGKYGPAD    66  82        14
#> 244  41 db_eEF1Ba Alpha_KSCN            ASLPGVKKALGKYGPAD    66  82        14
#> 245  41 db_eEF1Ba Alpha_KSCN            ASLPGVKKALGKYGPAD    66  82        14
#> 246  41 db_eEF1Ba Alpha_KSCN            ASLPGVKKALGKYGPAD    66  82        14
#> 247  42 db_eEF1Ba Alpha_KSCN                  ALGKYGPADVE    74  84         9
#> 248  42 db_eEF1Ba Alpha_KSCN                  ALGKYGPADVE    74  84         9
#> 249  42 db_eEF1Ba Alpha_KSCN                  ALGKYGPADVE    74  84         9
#> 250  42 db_eEF1Ba Alpha_KSCN                  ALGKYGPADVE    74  84         9
#> 251  42 db_eEF1Ba Alpha_KSCN                  ALGKYGPADVE    74  84         9
#> 252  42 db_eEF1Ba Alpha_KSCN                  ALGKYGPADVE    74  84         9
#> 253  43 db_eEF1Ba Alpha_KSCN         VEDTTGSGATDSKDDDDIDL    83 102        19
#> 254  43 db_eEF1Ba Alpha_KSCN         VEDTTGSGATDSKDDDDIDL    83 102        19
#> 255  43 db_eEF1Ba Alpha_KSCN         VEDTTGSGATDSKDDDDIDL    83 102        19
#> 256  43 db_eEF1Ba Alpha_KSCN         VEDTTGSGATDSKDDDDIDL    83 102        19
#> 257  43 db_eEF1Ba Alpha_KSCN         VEDTTGSGATDSKDDDDIDL    83 102        19
#> 258  43 db_eEF1Ba Alpha_KSCN         VEDTTGSGATDSKDDDDIDL    83 102        19
#> 259  44 db_eEF1Ba Alpha_KSCN           DTTGSGATDSKDDDDIDL    85 102        17
#> 260  44 db_eEF1Ba Alpha_KSCN           DTTGSGATDSKDDDDIDL    85 102        17
#> 261  44 db_eEF1Ba Alpha_KSCN           DTTGSGATDSKDDDDIDL    85 102        17
#> 262  44 db_eEF1Ba Alpha_KSCN           DTTGSGATDSKDDDDIDL    85 102        17
#> 263  44 db_eEF1Ba Alpha_KSCN           DTTGSGATDSKDDDDIDL    85 102        17
#> 264  44 db_eEF1Ba Alpha_KSCN           DTTGSGATDSKDDDDIDL    85 102        17
#> 265  45 db_eEF1Ba Alpha_KSCN            TTGSGATDSKDDDDIDL    86 102        16
#> 266  45 db_eEF1Ba Alpha_KSCN            TTGSGATDSKDDDDIDL    86 102        16
#> 267  45 db_eEF1Ba Alpha_KSCN            TTGSGATDSKDDDDIDL    86 102        16
#> 268  45 db_eEF1Ba Alpha_KSCN            TTGSGATDSKDDDDIDL    86 102        16
#> 269  45 db_eEF1Ba Alpha_KSCN            TTGSGATDSKDDDDIDL    86 102        16
#> 270  45 db_eEF1Ba Alpha_KSCN            TTGSGATDSKDDDDIDL    86 102        16
#> 271  46 db_eEF1Ba Alpha_KSCN                       DDDIDL    97 102         5
#> 272  46 db_eEF1Ba Alpha_KSCN                       DDDIDL    97 102         5
#> 273  46 db_eEF1Ba Alpha_KSCN                       DDDIDL    97 102         5
#> 274  46 db_eEF1Ba Alpha_KSCN                       DDDIDL    97 102         5
#> 275  46 db_eEF1Ba Alpha_KSCN                       DDDIDL    97 102         5
#> 276  46 db_eEF1Ba Alpha_KSCN                       DDDIDL    97 102         5
#> 277  47 db_eEF1Ba Alpha_KSCN                       LFGSDD   102 107         5
#> 278  47 db_eEF1Ba Alpha_KSCN                       LFGSDD   102 107         5
#> 279  47 db_eEF1Ba Alpha_KSCN                       LFGSDD   102 107         5
#> 280  47 db_eEF1Ba Alpha_KSCN                       LFGSDD   102 107         5
#> 281  47 db_eEF1Ba Alpha_KSCN                       LFGSDD   102 107         5
#> 282  47 db_eEF1Ba Alpha_KSCN                       LFGSDD   102 107         5
#> 283  48 db_eEF1Ba Alpha_KSCN                        FGSDD   103 107         4
#> 284  48 db_eEF1Ba Alpha_KSCN                        FGSDD   103 107         4
#> 285  48 db_eEF1Ba Alpha_KSCN                        FGSDD   103 107         4
#> 286  48 db_eEF1Ba Alpha_KSCN                        FGSDD   103 107         4
#> 287  48 db_eEF1Ba Alpha_KSCN                        FGSDD   103 107         4
#> 288  48 db_eEF1Ba Alpha_KSCN                        FGSDD   103 107         4
#> 289  49 db_eEF1Ba Alpha_KSCN            FGSDDEEESEEAKRLRE   103 119        16
#> 290  49 db_eEF1Ba Alpha_KSCN            FGSDDEEESEEAKRLRE   103 119        16
#> 291  49 db_eEF1Ba Alpha_KSCN            FGSDDEEESEEAKRLRE   103 119        16
#> 292  49 db_eEF1Ba Alpha_KSCN            FGSDDEEESEEAKRLRE   103 119        16
#> 293  49 db_eEF1Ba Alpha_KSCN            FGSDDEEESEEAKRLRE   103 119        16
#> 294  49 db_eEF1Ba Alpha_KSCN            FGSDDEEESEEAKRLRE   103 119        16
#> 295  50 db_eEF1Ba Alpha_KSCN           FGSDDEEESEEAKRLREE   103 120        17
#> 296  50 db_eEF1Ba Alpha_KSCN           FGSDDEEESEEAKRLREE   103 120        17
#> 297  50 db_eEF1Ba Alpha_KSCN           FGSDDEEESEEAKRLREE   103 120        17
#> 298  50 db_eEF1Ba Alpha_KSCN           FGSDDEEESEEAKRLREE   103 120        17
#> 299  50 db_eEF1Ba Alpha_KSCN           FGSDDEEESEEAKRLREE   103 120        17
#> 300  50 db_eEF1Ba Alpha_KSCN           FGSDDEEESEEAKRLREE   103 120        17
#> 301  51 db_eEF1Ba Alpha_KSCN         FGSDDEEESEEAKRLREERL   103 122        19
#> 302  51 db_eEF1Ba Alpha_KSCN         FGSDDEEESEEAKRLREERL   103 122        19
#> 303  51 db_eEF1Ba Alpha_KSCN         FGSDDEEESEEAKRLREERL   103 122        19
#> 304  51 db_eEF1Ba Alpha_KSCN         FGSDDEEESEEAKRLREERL   103 122        19
#> 305  51 db_eEF1Ba Alpha_KSCN         FGSDDEEESEEAKRLREERL   103 122        19
#> 306  51 db_eEF1Ba Alpha_KSCN         FGSDDEEESEEAKRLREERL   103 122        19
#> 307  52 db_eEF1Ba Alpha_KSCN           DEEESEEAKRLREERLAQ   107 124        17
#> 308  52 db_eEF1Ba Alpha_KSCN           DEEESEEAKRLREERLAQ   107 124        17
#> 309  52 db_eEF1Ba Alpha_KSCN           DEEESEEAKRLREERLAQ   107 124        17
#> 310  52 db_eEF1Ba Alpha_KSCN           DEEESEEAKRLREERLAQ   107 124        17
#> 311  52 db_eEF1Ba Alpha_KSCN           DEEESEEAKRLREERLAQ   107 124        17
#> 312  52 db_eEF1Ba Alpha_KSCN           DEEESEEAKRLREERLAQ   107 124        17
#> 313  53 db_eEF1Ba Alpha_KSCN            EEESEEAKRLREERLAQ   108 124        16
#> 314  53 db_eEF1Ba Alpha_KSCN            EEESEEAKRLREERLAQ   108 124        16
#> 315  53 db_eEF1Ba Alpha_KSCN            EEESEEAKRLREERLAQ   108 124        16
#> 316  53 db_eEF1Ba Alpha_KSCN            EEESEEAKRLREERLAQ   108 124        16
#> 317  53 db_eEF1Ba Alpha_KSCN            EEESEEAKRLREERLAQ   108 124        16
#> 318  53 db_eEF1Ba Alpha_KSCN            EEESEEAKRLREERLAQ   108 124        16
#> 319  54 db_eEF1Ba Alpha_KSCN                AQYESKKAKKPAL   123 135        11
#> 320  54 db_eEF1Ba Alpha_KSCN                AQYESKKAKKPAL   123 135        11
#> 321  54 db_eEF1Ba Alpha_KSCN                AQYESKKAKKPAL   123 135        11
#> 322  54 db_eEF1Ba Alpha_KSCN                AQYESKKAKKPAL   123 135        11
#> 323  54 db_eEF1Ba Alpha_KSCN                AQYESKKAKKPAL   123 135        11
#> 324  54 db_eEF1Ba Alpha_KSCN                AQYESKKAKKPAL   123 135        11
#> 325  55 db_eEF1Ba Alpha_KSCN                  YESKKAKKPAL   125 135         9
#> 326  55 db_eEF1Ba Alpha_KSCN                  YESKKAKKPAL   125 135         9
#> 327  55 db_eEF1Ba Alpha_KSCN                  YESKKAKKPAL   125 135         9
#> 328  55 db_eEF1Ba Alpha_KSCN                  YESKKAKKPAL   125 135         9
#> 329  55 db_eEF1Ba Alpha_KSCN                  YESKKAKKPAL   125 135         9
#> 330  55 db_eEF1Ba Alpha_KSCN                  YESKKAKKPAL   125 135         9
#> 331  56 db_eEF1Ba Alpha_KSCN                      VAKSSIL   136 142         6
#> 332  56 db_eEF1Ba Alpha_KSCN                      VAKSSIL   136 142         6
#> 333  56 db_eEF1Ba Alpha_KSCN                      VAKSSIL   136 142         6
#> 334  56 db_eEF1Ba Alpha_KSCN                      VAKSSIL   136 142         6
#> 335  56 db_eEF1Ba Alpha_KSCN                      VAKSSIL   136 142         6
#> 336  56 db_eEF1Ba Alpha_KSCN                      VAKSSIL   136 142         6
#> 337  57 db_eEF1Ba Alpha_KSCN                     VAKSSILL   136 143         7
#> 338  57 db_eEF1Ba Alpha_KSCN                     VAKSSILL   136 143         7
#> 339  57 db_eEF1Ba Alpha_KSCN                     VAKSSILL   136 143         7
#> 340  57 db_eEF1Ba Alpha_KSCN                     VAKSSILL   136 143         7
#> 341  57 db_eEF1Ba Alpha_KSCN                     VAKSSILL   136 143         7
#> 342  57 db_eEF1Ba Alpha_KSCN                     VAKSSILL   136 143         7
#> 343  58 db_eEF1Ba Alpha_KSCN                       AKSSIL   137 142         5
#> 344  58 db_eEF1Ba Alpha_KSCN                       AKSSIL   137 142         5
#> 345  58 db_eEF1Ba Alpha_KSCN                       AKSSIL   137 142         5
#> 346  58 db_eEF1Ba Alpha_KSCN                       AKSSIL   137 142         5
#> 347  58 db_eEF1Ba Alpha_KSCN                       AKSSIL   137 142         5
#> 348  58 db_eEF1Ba Alpha_KSCN                       AKSSIL   137 142         5
#> 349  59 db_eEF1Ba Alpha_KSCN                     LDVKPWDD   143 150         6
#> 350  59 db_eEF1Ba Alpha_KSCN                     LDVKPWDD   143 150         6
#> 351  59 db_eEF1Ba Alpha_KSCN                     LDVKPWDD   143 150         6
#> 352  59 db_eEF1Ba Alpha_KSCN                     LDVKPWDD   143 150         6
#> 353  59 db_eEF1Ba Alpha_KSCN                     LDVKPWDD   143 150         6
#> 354  59 db_eEF1Ba Alpha_KSCN                     LDVKPWDD   143 150         6
#> 355  60 db_eEF1Ba Alpha_KSCN                  LDVKPWDDETD   143 153         9
#> 356  60 db_eEF1Ba Alpha_KSCN                  LDVKPWDDETD   143 153         9
#> 357  60 db_eEF1Ba Alpha_KSCN                  LDVKPWDDETD   143 153         9
#> 358  60 db_eEF1Ba Alpha_KSCN                  LDVKPWDDETD   143 153         9
#> 359  60 db_eEF1Ba Alpha_KSCN                  LDVKPWDDETD   143 153         9
#> 360  60 db_eEF1Ba Alpha_KSCN                  LDVKPWDDETD   143 153         9
#> 361  61 db_eEF1Ba Alpha_KSCN                  DVKPWDDETDM   144 154         9
#> 362  61 db_eEF1Ba Alpha_KSCN                  DVKPWDDETDM   144 154         9
#> 363  61 db_eEF1Ba Alpha_KSCN                  DVKPWDDETDM   144 154         9
#> 364  61 db_eEF1Ba Alpha_KSCN                  DVKPWDDETDM   144 154         9
#> 365  61 db_eEF1Ba Alpha_KSCN                  DVKPWDDETDM   144 154         9
#> 366  61 db_eEF1Ba Alpha_KSCN                  DVKPWDDETDM   144 154         9
#> 367  62 db_eEF1Ba Alpha_KSCN                       MAKLEE   154 159         5
#> 368  62 db_eEF1Ba Alpha_KSCN                       MAKLEE   154 159         5
#> 369  62 db_eEF1Ba Alpha_KSCN                       MAKLEE   154 159         5
#> 370  62 db_eEF1Ba Alpha_KSCN                       MAKLEE   154 159         5
#> 371  62 db_eEF1Ba Alpha_KSCN                       MAKLEE   154 159         5
#> 372  62 db_eEF1Ba Alpha_KSCN                       MAKLEE   154 159         5
#> 373  63 db_eEF1Ba Alpha_KSCN                        AKLEE   155 159         4
#> 374  63 db_eEF1Ba Alpha_KSCN                        AKLEE   155 159         4
#> 375  63 db_eEF1Ba Alpha_KSCN                        AKLEE   155 159         4
#> 376  63 db_eEF1Ba Alpha_KSCN                        AKLEE   155 159         4
#> 377  63 db_eEF1Ba Alpha_KSCN                        AKLEE   155 159         4
#> 378  63 db_eEF1Ba Alpha_KSCN                        AKLEE   155 159         4
#> 379  64 db_eEF1Ba Alpha_KSCN                      CVRSIQA   160 166         6
#> 380  64 db_eEF1Ba Alpha_KSCN                      CVRSIQA   160 166         6
#> 381  64 db_eEF1Ba Alpha_KSCN                      CVRSIQA   160 166         6
#> 382  64 db_eEF1Ba Alpha_KSCN                      CVRSIQA   160 166         6
#> 383  64 db_eEF1Ba Alpha_KSCN                      CVRSIQA   160 166         6
#> 384  64 db_eEF1Ba Alpha_KSCN                      CVRSIQA   160 166         6
#> 385  65 db_eEF1Ba Alpha_KSCN                    CVRSIQADG   160 168         8
#> 386  65 db_eEF1Ba Alpha_KSCN                    CVRSIQADG   160 168         8
#> 387  65 db_eEF1Ba Alpha_KSCN                    CVRSIQADG   160 168         8
#> 388  65 db_eEF1Ba Alpha_KSCN                    CVRSIQADG   160 168         8
#> 389  65 db_eEF1Ba Alpha_KSCN                    CVRSIQADG   160 168         8
#> 390  65 db_eEF1Ba Alpha_KSCN                    CVRSIQADG   160 168         8
#> 391  66 db_eEF1Ba Alpha_KSCN                   CVRSIQADGL   160 169         9
#> 392  66 db_eEF1Ba Alpha_KSCN                   CVRSIQADGL   160 169         9
#> 393  66 db_eEF1Ba Alpha_KSCN                   CVRSIQADGL   160 169         9
#> 394  66 db_eEF1Ba Alpha_KSCN                   CVRSIQADGL   160 169         9
#> 395  66 db_eEF1Ba Alpha_KSCN                   CVRSIQADGL   160 169         9
#> 396  66 db_eEF1Ba Alpha_KSCN                   CVRSIQADGL   160 169         9
#> 397  67 db_eEF1Ba Alpha_KSCN            CVRSIQADGLVWGSSKL   160 176        16
#> 398  67 db_eEF1Ba Alpha_KSCN            CVRSIQADGLVWGSSKL   160 176        16
#> 399  67 db_eEF1Ba Alpha_KSCN            CVRSIQADGLVWGSSKL   160 176        16
#> 400  67 db_eEF1Ba Alpha_KSCN            CVRSIQADGLVWGSSKL   160 176        16
#> 401  67 db_eEF1Ba Alpha_KSCN            CVRSIQADGLVWGSSKL   160 176        16
#> 402  67 db_eEF1Ba Alpha_KSCN            CVRSIQADGLVWGSSKL   160 176        16
#> 403  68 db_eEF1Ba Alpha_KSCN                    VRSIQADGL   161 169         8
#> 404  68 db_eEF1Ba Alpha_KSCN                    VRSIQADGL   161 169         8
#> 405  68 db_eEF1Ba Alpha_KSCN                    VRSIQADGL   161 169         8
#> 406  68 db_eEF1Ba Alpha_KSCN                    VRSIQADGL   161 169         8
#> 407  68 db_eEF1Ba Alpha_KSCN                    VRSIQADGL   161 169         8
#> 408  68 db_eEF1Ba Alpha_KSCN                    VRSIQADGL   161 169         8
#> 409  69 db_eEF1Ba Alpha_KSCN             VRSIQADGLVWGSSKL   161 176        15
#> 410  69 db_eEF1Ba Alpha_KSCN             VRSIQADGLVWGSSKL   161 176        15
#> 411  69 db_eEF1Ba Alpha_KSCN             VRSIQADGLVWGSSKL   161 176        15
#> 412  69 db_eEF1Ba Alpha_KSCN             VRSIQADGLVWGSSKL   161 176        15
#> 413  69 db_eEF1Ba Alpha_KSCN             VRSIQADGLVWGSSKL   161 176        15
#> 414  69 db_eEF1Ba Alpha_KSCN             VRSIQADGLVWGSSKL   161 176        15
#> 415  70 db_eEF1Ba Alpha_KSCN                      SIQADGL   163 169         6
#> 416  70 db_eEF1Ba Alpha_KSCN                      SIQADGL   163 169         6
#> 417  70 db_eEF1Ba Alpha_KSCN                      SIQADGL   163 169         6
#> 418  70 db_eEF1Ba Alpha_KSCN                      SIQADGL   163 169         6
#> 419  70 db_eEF1Ba Alpha_KSCN                      SIQADGL   163 169         6
#> 420  70 db_eEF1Ba Alpha_KSCN                      SIQADGL   163 169         6
#> 421  71 db_eEF1Ba Alpha_KSCN               SIQADGLVWGSSKL   163 176        13
#> 422  71 db_eEF1Ba Alpha_KSCN               SIQADGLVWGSSKL   163 176        13
#> 423  71 db_eEF1Ba Alpha_KSCN               SIQADGLVWGSSKL   163 176        13
#> 424  71 db_eEF1Ba Alpha_KSCN               SIQADGLVWGSSKL   163 176        13
#> 425  71 db_eEF1Ba Alpha_KSCN               SIQADGLVWGSSKL   163 176        13
#> 426  71 db_eEF1Ba Alpha_KSCN               SIQADGLVWGSSKL   163 176        13
#> 427  72 db_eEF1Ba Alpha_KSCN SIQADGLVWGSSKLVPVGYGIKKLQIQC   163 190        26
#> 428  72 db_eEF1Ba Alpha_KSCN SIQADGLVWGSSKLVPVGYGIKKLQIQC   163 190        26
#> 429  72 db_eEF1Ba Alpha_KSCN SIQADGLVWGSSKLVPVGYGIKKLQIQC   163 190        26
#> 430  72 db_eEF1Ba Alpha_KSCN SIQADGLVWGSSKLVPVGYGIKKLQIQC   163 190        26
#> 431  72 db_eEF1Ba Alpha_KSCN SIQADGLVWGSSKLVPVGYGIKKLQIQC   163 190        26
#> 432  72 db_eEF1Ba Alpha_KSCN SIQADGLVWGSSKLVPVGYGIKKLQIQC   163 190        26
#> 433  73 db_eEF1Ba Alpha_KSCN         ADGLVWGSSKLVPVGYGIKK   166 185        18
#> 434  73 db_eEF1Ba Alpha_KSCN         ADGLVWGSSKLVPVGYGIKK   166 185        18
#> 435  73 db_eEF1Ba Alpha_KSCN         ADGLVWGSSKLVPVGYGIKK   166 185        18
#> 436  73 db_eEF1Ba Alpha_KSCN         ADGLVWGSSKLVPVGYGIKK   166 185        18
#> 437  73 db_eEF1Ba Alpha_KSCN         ADGLVWGSSKLVPVGYGIKK   166 185        18
#> 438  73 db_eEF1Ba Alpha_KSCN         ADGLVWGSSKLVPVGYGIKK   166 185        18
#> 439  74 db_eEF1Ba Alpha_KSCN                     DGLVWGSS   167 174         7
#> 440  74 db_eEF1Ba Alpha_KSCN                     DGLVWGSS   167 174         7
#> 441  74 db_eEF1Ba Alpha_KSCN                     DGLVWGSS   167 174         7
#> 442  74 db_eEF1Ba Alpha_KSCN                     DGLVWGSS   167 174         7
#> 443  74 db_eEF1Ba Alpha_KSCN                     DGLVWGSS   167 174         7
#> 444  74 db_eEF1Ba Alpha_KSCN                     DGLVWGSS   167 174         7
#> 445  75 db_eEF1Ba Alpha_KSCN                   DGLVWGSSKL   167 176         9
#> 446  75 db_eEF1Ba Alpha_KSCN                   DGLVWGSSKL   167 176         9
#> 447  75 db_eEF1Ba Alpha_KSCN                   DGLVWGSSKL   167 176         9
#> 448  75 db_eEF1Ba Alpha_KSCN                   DGLVWGSSKL   167 176         9
#> 449  75 db_eEF1Ba Alpha_KSCN                   DGLVWGSSKL   167 176         9
#> 450  75 db_eEF1Ba Alpha_KSCN                   DGLVWGSSKL   167 176         9
#> 451  76 db_eEF1Ba Alpha_KSCN              DGLVWGSSKLVPVGY   167 181        13
#> 452  76 db_eEF1Ba Alpha_KSCN              DGLVWGSSKLVPVGY   167 181        13
#> 453  76 db_eEF1Ba Alpha_KSCN              DGLVWGSSKLVPVGY   167 181        13
#> 454  76 db_eEF1Ba Alpha_KSCN              DGLVWGSSKLVPVGY   167 181        13
#> 455  76 db_eEF1Ba Alpha_KSCN              DGLVWGSSKLVPVGY   167 181        13
#> 456  76 db_eEF1Ba Alpha_KSCN              DGLVWGSSKLVPVGY   167 181        13
#> 457  77 db_eEF1Ba Alpha_KSCN             DGLVWGSSKLVPVGYG   167 182        14
#> 458  77 db_eEF1Ba Alpha_KSCN             DGLVWGSSKLVPVGYG   167 182        14
#> 459  77 db_eEF1Ba Alpha_KSCN             DGLVWGSSKLVPVGYG   167 182        14
#> 460  77 db_eEF1Ba Alpha_KSCN             DGLVWGSSKLVPVGYG   167 182        14
#> 461  77 db_eEF1Ba Alpha_KSCN             DGLVWGSSKLVPVGYG   167 182        14
#> 462  77 db_eEF1Ba Alpha_KSCN             DGLVWGSSKLVPVGYG   167 182        14
#> 463  78 db_eEF1Ba Alpha_KSCN                LVWGSSKLVPVGY   169 181        11
#> 464  78 db_eEF1Ba Alpha_KSCN                LVWGSSKLVPVGY   169 181        11
#> 465  78 db_eEF1Ba Alpha_KSCN                LVWGSSKLVPVGY   169 181        11
#> 466  78 db_eEF1Ba Alpha_KSCN                LVWGSSKLVPVGY   169 181        11
#> 467  78 db_eEF1Ba Alpha_KSCN                LVWGSSKLVPVGY   169 181        11
#> 468  78 db_eEF1Ba Alpha_KSCN                LVWGSSKLVPVGY   169 181        11
#> 469  79 db_eEF1Ba Alpha_KSCN             KLVPVGYGIKKLQIQC   175 190        14
#> 470  79 db_eEF1Ba Alpha_KSCN             KLVPVGYGIKKLQIQC   175 190        14
#> 471  79 db_eEF1Ba Alpha_KSCN             KLVPVGYGIKKLQIQC   175 190        14
#> 472  79 db_eEF1Ba Alpha_KSCN             KLVPVGYGIKKLQIQC   175 190        14
#> 473  79 db_eEF1Ba Alpha_KSCN             KLVPVGYGIKKLQIQC   175 190        14
#> 474  79 db_eEF1Ba Alpha_KSCN             KLVPVGYGIKKLQIQC   175 190        14
#> 475  80 db_eEF1Ba Alpha_KSCN               VPVGYGIKKLQIQC   177 190        12
#> 476  80 db_eEF1Ba Alpha_KSCN               VPVGYGIKKLQIQC   177 190        12
#> 477  80 db_eEF1Ba Alpha_KSCN               VPVGYGIKKLQIQC   177 190        12
#> 478  80 db_eEF1Ba Alpha_KSCN               VPVGYGIKKLQIQC   177 190        12
#> 479  80 db_eEF1Ba Alpha_KSCN               VPVGYGIKKLQIQC   177 190        12
#> 480  80 db_eEF1Ba Alpha_KSCN               VPVGYGIKKLQIQC   177 190        12
#> 481  81 db_eEF1Ba Alpha_KSCN                       KLQIQC   185 190         5
#> 482  81 db_eEF1Ba Alpha_KSCN                       KLQIQC   185 190         5
#> 483  81 db_eEF1Ba Alpha_KSCN                       KLQIQC   185 190         5
#> 484  81 db_eEF1Ba Alpha_KSCN                       KLQIQC   185 190         5
#> 485  81 db_eEF1Ba Alpha_KSCN                       KLQIQC   185 190         5
#> 486  81 db_eEF1Ba Alpha_KSCN                       KLQIQC   185 190         5
#> 487  82 db_eEF1Ba Alpha_KSCN                 CVVEDDKVGTDM   190 201        11
#> 488  82 db_eEF1Ba Alpha_KSCN                 CVVEDDKVGTDM   190 201        11
#> 489  82 db_eEF1Ba Alpha_KSCN                 CVVEDDKVGTDM   190 201        11
#> 490  82 db_eEF1Ba Alpha_KSCN                 CVVEDDKVGTDM   190 201        11
#> 491  82 db_eEF1Ba Alpha_KSCN                 CVVEDDKVGTDM   190 201        11
#> 492  82 db_eEF1Ba Alpha_KSCN                 CVVEDDKVGTDM   190 201        11
#> 493  83 db_eEF1Ba Alpha_KSCN                CVVEDDKVGTDML   190 202        12
#> 494  83 db_eEF1Ba Alpha_KSCN                CVVEDDKVGTDML   190 202        12
#> 495  83 db_eEF1Ba Alpha_KSCN                CVVEDDKVGTDML   190 202        12
#> 496  83 db_eEF1Ba Alpha_KSCN                CVVEDDKVGTDML   190 202        12
#> 497  83 db_eEF1Ba Alpha_KSCN                CVVEDDKVGTDML   190 202        12
#> 498  83 db_eEF1Ba Alpha_KSCN                CVVEDDKVGTDML   190 202        12
#> 499  84 db_eEF1Ba Alpha_KSCN                  VVEDDKVGTDM   191 201        10
#> 500  84 db_eEF1Ba Alpha_KSCN                  VVEDDKVGTDM   191 201        10
#> 501  84 db_eEF1Ba Alpha_KSCN                  VVEDDKVGTDM   191 201        10
#> 502  84 db_eEF1Ba Alpha_KSCN                  VVEDDKVGTDM   191 201        10
#> 503  84 db_eEF1Ba Alpha_KSCN                  VVEDDKVGTDM   191 201        10
#> 504  84 db_eEF1Ba Alpha_KSCN                  VVEDDKVGTDM   191 201        10
#> 505  85 db_eEF1Ba Alpha_KSCN                 VVEDDKVGTDML   191 202        11
#> 506  85 db_eEF1Ba Alpha_KSCN                 VVEDDKVGTDML   191 202        11
#> 507  85 db_eEF1Ba Alpha_KSCN                 VVEDDKVGTDML   191 202        11
#> 508  85 db_eEF1Ba Alpha_KSCN                 VVEDDKVGTDML   191 202        11
#> 509  85 db_eEF1Ba Alpha_KSCN                 VVEDDKVGTDML   191 202        11
#> 510  85 db_eEF1Ba Alpha_KSCN                 VVEDDKVGTDML   191 202        11
#> 511  86 db_eEF1Ba Alpha_KSCN                VVEDDKVGTDMLE   191 203        12
#> 512  86 db_eEF1Ba Alpha_KSCN                VVEDDKVGTDMLE   191 203        12
#> 513  86 db_eEF1Ba Alpha_KSCN                VVEDDKVGTDMLE   191 203        12
#> 514  86 db_eEF1Ba Alpha_KSCN                VVEDDKVGTDMLE   191 203        12
#> 515  86 db_eEF1Ba Alpha_KSCN                VVEDDKVGTDMLE   191 203        12
#> 516  86 db_eEF1Ba Alpha_KSCN                VVEDDKVGTDMLE   191 203        12
#> 517  87 db_eEF1Ba Alpha_KSCN                     DDKVGTDM   194 201         7
#> 518  87 db_eEF1Ba Alpha_KSCN                     DDKVGTDM   194 201         7
#> 519  87 db_eEF1Ba Alpha_KSCN                     DDKVGTDM   194 201         7
#> 520  87 db_eEF1Ba Alpha_KSCN                     DDKVGTDM   194 201         7
#> 521  87 db_eEF1Ba Alpha_KSCN                     DDKVGTDM   194 201         7
#> 522  87 db_eEF1Ba Alpha_KSCN                     DDKVGTDM   194 201         7
#> 523  88 db_eEF1Ba Alpha_KSCN                    DDKVGTDML   194 202         8
#> 524  88 db_eEF1Ba Alpha_KSCN                    DDKVGTDML   194 202         8
#> 525  88 db_eEF1Ba Alpha_KSCN                    DDKVGTDML   194 202         8
#> 526  88 db_eEF1Ba Alpha_KSCN                    DDKVGTDML   194 202         8
#> 527  88 db_eEF1Ba Alpha_KSCN                    DDKVGTDML   194 202         8
#> 528  88 db_eEF1Ba Alpha_KSCN                    DDKVGTDML   194 202         8
#> 529  89 db_eEF1Ba Alpha_KSCN                      DKVGTDM   195 201         6
#> 530  89 db_eEF1Ba Alpha_KSCN                      DKVGTDM   195 201         6
#> 531  89 db_eEF1Ba Alpha_KSCN                      DKVGTDM   195 201         6
#> 532  89 db_eEF1Ba Alpha_KSCN                      DKVGTDM   195 201         6
#> 533  89 db_eEF1Ba Alpha_KSCN                      DKVGTDM   195 201         6
#> 534  89 db_eEF1Ba Alpha_KSCN                      DKVGTDM   195 201         6
#> 535  90 db_eEF1Ba Alpha_KSCN                     DKVGTDML   195 202         7
#> 536  90 db_eEF1Ba Alpha_KSCN                     DKVGTDML   195 202         7
#> 537  90 db_eEF1Ba Alpha_KSCN                     DKVGTDML   195 202         7
#> 538  90 db_eEF1Ba Alpha_KSCN                     DKVGTDML   195 202         7
#> 539  90 db_eEF1Ba Alpha_KSCN                     DKVGTDML   195 202         7
#> 540  90 db_eEF1Ba Alpha_KSCN                     DKVGTDML   195 202         7
#> 541  91 db_eEF1Ba Alpha_KSCN                       VGTDML   197 202         5
#> 542  91 db_eEF1Ba Alpha_KSCN                       VGTDML   197 202         5
#> 543  91 db_eEF1Ba Alpha_KSCN                       VGTDML   197 202         5
#> 544  91 db_eEF1Ba Alpha_KSCN                       VGTDML   197 202         5
#> 545  91 db_eEF1Ba Alpha_KSCN                       VGTDML   197 202         5
#> 546  91 db_eEF1Ba Alpha_KSCN                       VGTDML   197 202         5
#> 547  92 db_eEF1Ba Alpha_KSCN                       LEEQIT   202 207         5
#> 548  92 db_eEF1Ba Alpha_KSCN                       LEEQIT   202 207         5
#> 549  92 db_eEF1Ba Alpha_KSCN                       LEEQIT   202 207         5
#> 550  92 db_eEF1Ba Alpha_KSCN                       LEEQIT   202 207         5
#> 551  92 db_eEF1Ba Alpha_KSCN                       LEEQIT   202 207         5
#> 552  92 db_eEF1Ba Alpha_KSCN                       LEEQIT   202 207         5
#> 553  93 db_eEF1Ba Alpha_KSCN                      LEEQITA   202 208         6
#> 554  93 db_eEF1Ba Alpha_KSCN                      LEEQITA   202 208         6
#> 555  93 db_eEF1Ba Alpha_KSCN                      LEEQITA   202 208         6
#> 556  93 db_eEF1Ba Alpha_KSCN                      LEEQITA   202 208         6
#> 557  93 db_eEF1Ba Alpha_KSCN                      LEEQITA   202 208         6
#> 558  93 db_eEF1Ba Alpha_KSCN                      LEEQITA   202 208         6
#> 559  94 db_eEF1Ba Alpha_KSCN                     LEEQITAF   202 209         7
#> 560  94 db_eEF1Ba Alpha_KSCN                     LEEQITAF   202 209         7
#> 561  94 db_eEF1Ba Alpha_KSCN                     LEEQITAF   202 209         7
#> 562  94 db_eEF1Ba Alpha_KSCN                     LEEQITAF   202 209         7
#> 563  94 db_eEF1Ba Alpha_KSCN                     LEEQITAF   202 209         7
#> 564  94 db_eEF1Ba Alpha_KSCN                     LEEQITAF   202 209         7
#> 565  95 db_eEF1Ba Alpha_KSCN                       EEQITA   203 208         5
#> 566  95 db_eEF1Ba Alpha_KSCN                       EEQITA   203 208         5
#> 567  95 db_eEF1Ba Alpha_KSCN                       EEQITA   203 208         5
#> 568  95 db_eEF1Ba Alpha_KSCN                       EEQITA   203 208         5
#> 569  95 db_eEF1Ba Alpha_KSCN                       EEQITA   203 208         5
#> 570  95 db_eEF1Ba Alpha_KSCN                       EEQITA   203 208         5
#> 571  96 db_eEF1Ba Alpha_KSCN                      EEQITAF   203 209         6
#> 572  96 db_eEF1Ba Alpha_KSCN                      EEQITAF   203 209         6
#> 573  96 db_eEF1Ba Alpha_KSCN                      EEQITAF   203 209         6
#> 574  96 db_eEF1Ba Alpha_KSCN                      EEQITAF   203 209         6
#> 575  96 db_eEF1Ba Alpha_KSCN                      EEQITAF   203 209         6
#> 576  96 db_eEF1Ba Alpha_KSCN                      EEQITAF   203 209         6
#> 577  97 db_eEF1Ba Alpha_KSCN                     EEQITAFE   203 210         7
#> 578  97 db_eEF1Ba Alpha_KSCN                     EEQITAFE   203 210         7
#> 579  97 db_eEF1Ba Alpha_KSCN                     EEQITAFE   203 210         7
#> 580  97 db_eEF1Ba Alpha_KSCN                     EEQITAFE   203 210         7
#> 581  97 db_eEF1Ba Alpha_KSCN                     EEQITAFE   203 210         7
#> 582  97 db_eEF1Ba Alpha_KSCN                     EEQITAFE   203 210         7
#> 583  98 db_eEF1Ba Alpha_KSCN                       EQITAF   204 209         5
#> 584  98 db_eEF1Ba Alpha_KSCN                       EQITAF   204 209         5
#> 585  98 db_eEF1Ba Alpha_KSCN                       EQITAF   204 209         5
#> 586  98 db_eEF1Ba Alpha_KSCN                       EQITAF   204 209         5
#> 587  98 db_eEF1Ba Alpha_KSCN                       EQITAF   204 209         5
#> 588  98 db_eEF1Ba Alpha_KSCN                       EQITAF   204 209         5
#> 589  99 db_eEF1Ba Alpha_KSCN                        QITAF   205 209         4
#> 590  99 db_eEF1Ba Alpha_KSCN                        QITAF   205 209         4
#> 591  99 db_eEF1Ba Alpha_KSCN                        QITAF   205 209         4
#> 592  99 db_eEF1Ba Alpha_KSCN                        QITAF   205 209         4
#> 593  99 db_eEF1Ba Alpha_KSCN                        QITAF   205 209         4
#> 594  99 db_eEF1Ba Alpha_KSCN                        QITAF   205 209         4
#> 595 100 db_eEF1Ba Alpha_KSCN                     FEDYVQSM   209 216         7
#> 596 100 db_eEF1Ba Alpha_KSCN                     FEDYVQSM   209 216         7
#> 597 100 db_eEF1Ba Alpha_KSCN                     FEDYVQSM   209 216         7
#> 598 100 db_eEF1Ba Alpha_KSCN                     FEDYVQSM   209 216         7
#> 599 100 db_eEF1Ba Alpha_KSCN                     FEDYVQSM   209 216         7
#> 600 100 db_eEF1Ba Alpha_KSCN                     FEDYVQSM   209 216         7
#> 601 101 db_eEF1Ba Alpha_KSCN                      EDYVQSM   210 216         6
#> 602 101 db_eEF1Ba Alpha_KSCN                      EDYVQSM   210 216         6
#> 603 101 db_eEF1Ba Alpha_KSCN                      EDYVQSM   210 216         6
#> 604 101 db_eEF1Ba Alpha_KSCN                      EDYVQSM   210 216         6
#> 605 101 db_eEF1Ba Alpha_KSCN                      EDYVQSM   210 216         6
#> 606 101 db_eEF1Ba Alpha_KSCN                      EDYVQSM   210 216         6
#> 607 102 db_eEF1Ba Alpha_KSCN                     EDYVQSMD   210 217         7
#> 608 102 db_eEF1Ba Alpha_KSCN                     EDYVQSMD   210 217         7
#> 609 102 db_eEF1Ba Alpha_KSCN                     EDYVQSMD   210 217         7
#> 610 102 db_eEF1Ba Alpha_KSCN                     EDYVQSMD   210 217         7
#> 611 102 db_eEF1Ba Alpha_KSCN                     EDYVQSMD   210 217         7
#> 612 102 db_eEF1Ba Alpha_KSCN                     EDYVQSMD   210 217         7
#> 613 103 db_eEF1Ba Alpha_KSCN                    EDYVQSMDV   210 218         8
#> 614 103 db_eEF1Ba Alpha_KSCN                    EDYVQSMDV   210 218         8
#> 615 103 db_eEF1Ba Alpha_KSCN                    EDYVQSMDV   210 218         8
#> 616 103 db_eEF1Ba Alpha_KSCN                    EDYVQSMDV   210 218         8
#> 617 103 db_eEF1Ba Alpha_KSCN                    EDYVQSMDV   210 218         8
#> 618 103 db_eEF1Ba Alpha_KSCN                    EDYVQSMDV   210 218         8
#> 619 104 db_eEF1Ba Alpha_KSCN                       DYVQSM   211 216         5
#> 620 104 db_eEF1Ba Alpha_KSCN                       DYVQSM   211 216         5
#> 621 104 db_eEF1Ba Alpha_KSCN                       DYVQSM   211 216         5
#> 622 104 db_eEF1Ba Alpha_KSCN                       DYVQSM   211 216         5
#> 623 104 db_eEF1Ba Alpha_KSCN                       DYVQSM   211 216         5
#> 624 104 db_eEF1Ba Alpha_KSCN                       DYVQSM   211 216         5
#> 625 105 db_eEF1Ba Alpha_KSCN                       YVQSMD   212 217         5
#> 626 105 db_eEF1Ba Alpha_KSCN                       YVQSMD   212 217         5
#> 627 105 db_eEF1Ba Alpha_KSCN                       YVQSMD   212 217         5
#> 628 105 db_eEF1Ba Alpha_KSCN                       YVQSMD   212 217         5
#> 629 105 db_eEF1Ba Alpha_KSCN                       YVQSMD   212 217         5
#> 630 105 db_eEF1Ba Alpha_KSCN                       YVQSMD   212 217         5
#> 631 106 db_eEF1Ba Alpha_KSCN                        DVAAF   217 221         4
#> 632 106 db_eEF1Ba Alpha_KSCN                        DVAAF   217 221         4
#> 633 106 db_eEF1Ba Alpha_KSCN                        DVAAF   217 221         4
#> 634 106 db_eEF1Ba Alpha_KSCN                        DVAAF   217 221         4
#> 635 106 db_eEF1Ba Alpha_KSCN                        DVAAF   217 221         4
#> 636 106 db_eEF1Ba Alpha_KSCN                        DVAAF   217 221         4
#>     Exposure frac_deut_uptake err_frac_deut_uptake deut_uptake err_deut_uptake
#> 1      0.167      0.324042534         0.0118412325  1.76043790    0.0631420572
#> 2      1.000      0.510235680         0.0111972607  2.77197632    0.0576624781
#> 3      5.000      0.628887588         0.0092988257  3.41658094    0.0445147663
#> 4     25.000      0.845956363         0.0077415269  4.59585853    0.0271390599
#> 5    150.000      0.969827228         0.0072640522  5.26881638    0.0141636760
#> 6   1440.000      1.000000000         0.0098867942  5.43273712    0.0379803697
#> 7      0.167      0.740605640         0.0078015112  3.20604067    0.0273353286
#> 8      1.000      0.954487625         0.0108346716  4.13192390    0.0393257544
#> 9      5.000      1.016037325         0.0074489776  4.39836913    0.0173058413
#> 10    25.000      0.997351647         0.0076586748  4.31747987    0.0196428160
#> 11   150.000      0.995939721         0.0078418844  4.31136772    0.0210018248
#> 12  1440.000      1.000000000         0.0087485243  4.32894444    0.0267794600
#> 13     0.167      0.754414870         0.0111453765  3.38312302    0.0457458889
#> 14     1.000      0.961392012         0.0126331876  4.31129817    0.0505093267
#> 15     5.000      1.009953685         0.0069382688  4.52906974    0.0155425839
#> 16    25.000      1.008370674         0.0172503195  4.52197084    0.0725258530
#> 17   150.000      1.000648246         0.0064314485  4.48734013    0.0108917854
#> 18  1440.000      1.000000000         0.0084164757  4.48443311    0.0266884179
#> 19     0.167      0.691290596         0.0129509882  1.91201900    0.0356730878
#> 20     1.000      0.948083459         0.0076117390  2.62227433    0.0205761344
#> 21     5.000      1.008997475         0.0056339862  2.79075450    0.0148437867
#> 22    25.000      0.979545877         0.0094473488  2.70929525    0.0257213802
#> 23   150.000      0.995315878         0.0124789587  2.75291300    0.0341967007
#> 24  1440.000      1.000000000         0.0024030675  2.76586867    0.0046998341
#> 25     0.167      0.696042168         0.0122528407  2.17292300    0.0381991897
#> 26     1.000      0.946339857         0.0127457159  2.95430900    0.0396973676
#> 27     5.000      1.003480601         0.0054147606  3.13269250    0.0166574825
#> 28    25.000      0.993917450         0.0039493847  3.10283800    0.0119956995
#> 29   150.000      0.993895988         0.0042759422  3.10277100    0.0130412724
#> 30  1440.000      1.000000000         0.0012983510  3.12182667    0.0028660641
#> 31     0.167      0.312330516         0.0067446642  1.09460133    0.0197482234
#> 32     1.000      0.699214514         0.0171776028  2.45048467    0.0527112845
#> 33     5.000      0.943153832         0.0170814478  3.30540050    0.0452217419
#> 34    25.000      1.005097359         0.0177660138  3.52248933    0.0461438574
#> 35   150.000      1.015130958         0.0132737923  3.55765333    0.0195336599
#> 36  1440.000      1.000000000         0.0167829385  3.50462500    0.0415905400
#> 37     0.167      0.236352601         0.0080126740  0.47833433    0.0143613999
#> 38     1.000      0.570048176         0.0207703281  1.15367300    0.0379085356
#> 39     5.000      0.888247947         0.0268469879  1.79765100    0.0463799013
#> 40    25.000      0.981487001         0.0190053028  1.98634975    0.0223921519
#> 41   150.000      1.022539097         0.0193811411  2.06943167    0.0218397550
#> 42  1440.000      1.000000000         0.0222654561  2.02381667    0.0318630809
#> 43     0.167      0.279674741         0.0103969164  0.81786767    0.0282945996
#> 44     1.000      0.590379365         0.0139300125  1.72647767    0.0332809993
#> 45     5.000      0.916549148         0.0250497872  2.68031325    0.0635313124
#> 46    25.000      0.996655671         0.0140289576  2.91457300    0.0105108816
#> 47   150.000      1.005218248         0.0162035324  2.93961300    0.0254079279
#> 48  1440.000      1.000000000         0.0192420970  2.92435300    0.0397893823
#> 49     0.167      0.268590325         0.0260355473  0.75744567    0.0722557569
#> 50     1.000      0.505193710         0.0147080300  1.42468567    0.0334545261
#> 51     5.000      0.867351985         0.0334161939  2.44600025    0.0843110110
#> 52    25.000      1.010807739         0.0231461009  2.85055667    0.0430564908
#> 53   150.000      1.032786800         0.0226742994  2.91253933    0.0397005081
#> 54  1440.000      1.000000000         0.0243391899  2.82007800    0.0485346879
#> 55     0.167      0.296982778         0.0049373232  1.05609306    0.0120629263
#> 56     1.000      0.576990364         0.0129033701  2.05182106    0.0386152725
#> 57     5.000      0.865018853         0.0182068840  3.07607200    0.0530205344
#> 58    25.000      0.989908007         0.0129195442  3.52018721    0.0173932579
#> 59   150.000      1.011432980         0.0157662677  3.59673163    0.0354356559
#> 60  1440.000      1.000000000         0.0170834306  3.55607509    0.0429567102
#> 61     0.167      0.527410469         0.0089959972  1.63155800    0.0270140787
#> 62     1.000      0.778510994         0.0102064926  2.40834400    0.0299916339
#> 63     5.000      0.950842259         0.0131768556  2.94145525    0.0389395753
#> 64    25.000      0.968051747         0.0078760804  2.99469325    0.0210478256
#> 65   150.000      0.989924765         0.0041970509  3.06235800    0.0033251479
#> 66  1440.000      1.000000000         0.0057959709  3.09352600    0.0126784151
#> 67     0.167      0.621963704         0.0050999506  2.14405269    0.0157142438
#> 68     1.000      0.820797990         0.0116121955  2.82948045    0.0386544491
#> 69     5.000      0.965679820         0.0092889124  3.32892161    0.0295894989
#> 70    25.000      0.989766065         0.0084228257  3.41195247    0.0261855294
#> 71   150.000      0.997252408         0.0056233932  3.43775963    0.0146976093
#> 72  1440.000      1.000000000         0.0051997047  3.44723121    0.0126745951
#> 73     0.167      0.681755805         0.0081417696  6.62293124    0.0784320281
#> 74     1.000      0.887670032         0.0061706896  8.62328937    0.0584535658
#> 75     5.000      0.997435211         0.0036837159  9.68960553    0.0325208419
#> 76    25.000      0.987043551         0.0107270400  9.58865553    0.1031549430
#> 77   150.000      1.000595490         0.0015441435  9.72030613    0.0007769653
#> 78  1440.000      1.000000000         0.0021795195  9.71452123    0.0149715640
#> 79     0.167      0.729171139         0.0074244542  6.41494824    0.0595475288
#> 80     1.000      0.929615704         0.0129495639  8.17837722    0.1086642570
#> 81     5.000      1.002225730         0.0063978251  8.81717041    0.0425089486
#> 82    25.000      1.000171828         0.0084751809  8.79910102    0.0648374865
#> 83   150.000      0.998572101         0.0057961024  8.78502728    0.0353415028
#> 84  1440.000      1.000000000         0.0059172672  8.79758935    0.0368103435
#> 85     0.167      0.728821175         0.0047554137  5.41217471    0.0323621645
#> 86     1.000      0.944237185         0.0155131325  7.01183883    0.1137350972
#> 87     5.000      0.998009653         0.0034943263  7.41114939    0.0172865676
#> 88    25.000      0.990955538         0.0036478586  7.35876603    0.0190937117
#> 89   150.000      0.993493732         0.0034635953  7.37761448    0.0170415900
#> 90  1440.000      1.000000000         0.0036928234  7.42592956    0.0193907393
#> 91     0.167      0.738278461         0.0157769826  1.71402567    0.0317579575
#> 92     1.000      0.960670965         0.0189384619  2.23034367    0.0370032409
#> 93     5.000      1.009572602         0.0140961054  2.34387625    0.0211692474
#> 94    25.000      0.991614699         0.0111285092  2.30218425    0.0081619408
#> 95   150.000      0.998438755         0.0158966317  2.31802733    0.0274386214
#> 96  1440.000      1.000000000         0.0150584127  2.32165200    0.0247207317
#> 97     0.167      0.733001328         0.0037775734  4.95076026    0.0189755523
#> 98     1.000      0.939860744         0.0097412517  6.34790831    0.0620524846
#> 99     5.000      1.011865715         0.0037504809  6.83423670    0.0093448127
#> 100   25.000      1.004232762         0.0045776460  6.78268301    0.0202461393
#> 101  150.000      1.001026902         0.0042439847  6.76103032    0.0167066931
#> 102 1440.000      1.000000000         0.0048720619  6.75409453    0.0232683149
#> 103    0.167      0.744380126         0.0053295184  4.42350230    0.0268973529
#> 104    1.000      0.926754531         0.0085358283  5.50726793    0.0462560250
#> 105    5.000      1.007944181         0.0061244670  5.98973998    0.0284953064
#> 106   25.000      0.992149247         0.0072735718  5.89587809    0.0370351533
#> 107  150.000      1.003032051         0.0039285025  5.96054950    0.0061141636
#> 108 1440.000      1.000000000         0.0053456075  5.94253144    0.0224622655
#> 109    0.167      0.755318594         0.0053234569  1.79081733    0.0058624451
#> 110    1.000      0.950135593         0.0074663360  2.25271733    0.0107551063
#> 111    5.000      1.001637112         0.0097253665  2.37482450    0.0176627890
#> 112   25.000      0.988074787         0.0076499056  2.34266900    0.0107316119
#> 113  150.000      0.997161467         0.0086696684  2.36421300    0.0143097317
#> 114 1440.000      1.000000000         0.0088269159  2.37094300    0.0147984116
#> 115    0.167      0.819903123         0.0111713885  3.81612551    0.0455268511
#> 116    1.000      0.961523537         0.0107790670  4.47527810    0.0406126146
#> 117    5.000      1.014468890         0.0090346732  4.72170492    0.0283278153
#> 118   25.000      0.984916778         0.0066466272  4.58415870    0.0068324165
#> 119  150.000      1.020228274         0.0123213096  4.74851117    0.0480831104
#> 120 1440.000      1.000000000         0.0093080279  4.65436147    0.0306339351
#> 121    0.167      0.756251607         0.0067687535  4.00637156    0.0283956466
#> 122    1.000      0.937142313         0.0056082620  4.96467085    0.0120980580
#> 123    5.000      0.998880781         0.0076868894  5.29174090    0.0286661479
#> 124   25.000      0.995264082         0.0074869155  5.27258081    0.0272513263
#> 125  150.000      0.998949144         0.0072796830  5.29210306    0.0255066649
#> 126 1440.000      1.000000000         0.0077298454  5.29767015    0.0289561439
#> 127    0.167      0.672325003         0.0042282226  2.42141167    0.0038884973
#> 128    1.000      0.871495860         0.0129761743  3.13873533    0.0426598292
#> 129    5.000      0.961573667         0.0065718400  3.46315500    0.0108069134
#> 130   25.000      0.980379116         0.0135896727  3.53088375    0.0439837067
#> 131  150.000      1.018569601         0.0068050324  3.66842867    0.0101551440
#> 132 1440.000      1.000000000         0.0085990838  3.60154933    0.0218991143
#> 133    0.167      0.144253493         0.0126303968  0.38390567    0.0334572170
#> 134    1.000      0.485165920         0.0265676320  1.29118500    0.0698610301
#> 135    5.000      0.870928221         0.0207733029  2.31782450    0.0517109752
#> 136   25.000      0.981793542         0.0084324810  2.61287333    0.0042105385
#> 137  150.000      0.987831007         0.0093336167  2.62894100    0.0111859426
#> 138 1440.000      1.000000000         0.0119307674  2.66132667    0.0224518208
#> 139    0.167      0.719862653         0.0271514046  3.05189803    0.0828925711
#> 140    1.000      0.896866258         0.0314454589  3.80231473    0.0887185677
#> 141    5.000      1.022811110         0.0410527482  4.33626498    0.1319610238
#> 142   25.000      1.039254350         0.0294435125  4.40597702    0.0478161928
#> 143  150.000      0.976087424         0.0401686301  4.13817730    0.1314257758
#> 144 1440.000      1.000000000         0.0370105083  4.23955600    0.1109507976
#> 145    0.167      0.603832466         0.0062615780  3.07068247    0.0309251153
#> 146    1.000      0.813210398         0.0105994319  4.13543666    0.0529242615
#> 147    5.000      0.986392571         0.0094008945  5.01612376    0.0461722027
#> 148   25.000      0.985873375         0.0042826596  5.01348348    0.0179130475
#> 149  150.000      0.998846173         0.0028796439  5.07945434    0.0075461978
#> 150 1440.000      1.000000000         0.0034941142  5.08532192    0.0125643652
#> 151    0.167      0.601157022         0.0071728467  3.79863067    0.0415243452
#> 152    1.000      0.832477325         0.0148900346  5.26031267    0.0906626727
#> 153    5.000      0.975747784         0.0185939807  6.16561950    0.1137327701
#> 154   25.000      0.980715422         0.0194150882  6.19700933    0.1190479066
#> 155  150.000      0.999212728         0.0099454828  6.31389133    0.0551147782
#> 156 1440.000      1.000000000         0.0067632602  6.31886600    0.0302190107
#> 157    0.167      0.566942570         0.0155001583  3.76802467    0.1008917923
#> 158    1.000      0.813029443         0.0175967912  5.40357200    0.1130770419
#> 159    5.000      0.996686788         0.0152439623  6.62419900    0.0944726856
#> 160   25.000      0.992743343         0.0141887485  6.59799000    0.0869699674
#> 161  150.000      0.998133575         0.0166580545  6.63381467    0.1044696677
#> 162 1440.000      1.000000000         0.0078138762  6.64621933    0.0367219892
#> 163    0.167      0.655383470         0.0089797555  2.94037507    0.0390449777
#> 164    1.000      0.834237192         0.0127318193  3.74280152    0.0557055276
#> 165    5.000      0.985247205         0.0081191226  4.42030728    0.0332278482
#> 166   25.000      0.992888596         0.0055867234  4.45459035    0.0200494916
#> 167  150.000      0.997430152         0.0047156095  4.47496602    0.0148075281
#> 168 1440.000      1.000000000         0.0047754422  4.48649563    0.0151497633
#> 169    0.167      0.655235839         0.0081960388  3.77539104    0.0225693964
#> 170    1.000      0.850703378         0.0122022136  4.90165177    0.0451948458
#> 171    5.000      0.991358128         0.0145817512  5.71208773    0.0558571214
#> 172   25.000      0.996429123         0.0131035307  5.74130619    0.0414841909
#> 173  150.000      0.996148858         0.0118140712  5.73969135    0.0256217830
#> 174 1440.000      1.000000000         0.0155387618  5.76188117    0.0633090370
#> 175    0.167      0.585126599         0.0194750335  3.64725156    0.1139232371
#> 176    1.000      0.791298195         0.0139699133  4.93237459    0.0660898661
#> 177    5.000      0.975378081         0.0164024269  6.07979406    0.0746240882
#> 178   25.000      0.976340245         0.0182058195  6.08579149    0.0893535497
#> 179  150.000      0.994376726         0.0130231989  6.19821773    0.0388995486
#> 180 1440.000      1.000000000         0.0162566998  6.23326911    0.0716528163
#> 181    0.167      0.742000361         0.0118761706  2.95111485    0.0060087065
#> 182    1.000      0.832730511         0.0170042415  3.31197059    0.0425348730
#> 183    5.000      0.983525403         0.0183078666  3.91171834    0.0380195755
#> 184   25.000      0.992198538         0.0200298908  3.94621350    0.0492085649
#> 185  150.000      1.001717208         0.0170007633  3.98407155    0.0239050423
#> 186 1440.000      1.000000000         0.0224514598  3.97724180    0.0631410181
#> 187    0.167      0.740820848         0.0145692153  2.24056123    0.0206663928
#> 188    1.000      0.873210313         0.0164377555  2.64096397    0.0191676399
#> 189    5.000      0.984799160         0.0185738314  2.97845669    0.0218938425
#> 190   25.000      0.994019809         0.0173270468  3.00634391    0.0044221314
#> 191  150.000      1.000247765         0.0180938516  3.02517993    0.0152881156
#> 192 1440.000      1.000000000         0.0245636398  3.02443058    0.0525316864
#> 193    0.167      0.687268499         0.0073559334  3.04683219    0.0090917304
#> 194    1.000      0.868292930         0.0095999152  3.84935852    0.0156758361
#> 195    5.000      0.977876337         0.0127022721  4.33516901    0.0344306233
#> 196   25.000      0.970588310         0.0112977777  4.30285938    0.0235046646
#> 197  150.000      0.997546209         0.0123271910  4.42237045    0.0303360074
#> 198 1440.000      1.000000000         0.0145363721  4.43324871    0.0455683320
#> 199    0.167      0.251197506         0.0089997776  0.86919478    0.0305727024
#> 200    1.000      0.538061229         0.0140071706  1.86180197    0.0467780116
#> 201    5.000      0.857533722         0.0253273267  2.96724218    0.0852736577
#> 202   25.000      0.986908503         0.0128216288  3.41490540    0.0377739509
#> 203  150.000      0.992882817         0.0111714236  3.43557775    0.0307610684
#> 204 1440.000      1.000000000         0.0096361716  3.46020466    0.0235771504
#> 205    0.167      0.241655948         0.0089963674  0.57403813    0.0202967170
#> 206    1.000      0.506017616         0.0121575951  1.20201223    0.0252565417
#> 207    5.000      0.822428035         0.0279985504  1.95362478    0.0624924025
#> 208   25.000      0.941985968         0.0223857100  2.23762694    0.0463461497
#> 209  150.000      0.985014920         0.0116973208  2.33983944    0.0053720594
#> 210 1440.000      1.000000000         0.0164773118  2.37543553    0.0276767194
#> 211    0.167      0.947624595         0.0027306351  8.63713822    0.0181411936
#> 212    1.000      0.987043459         0.0031398311  8.99642204    0.0224500635
#> 213    5.000      1.015047598         0.0044269544  9.25166618    0.0359857159
#> 214   25.000      1.003096366         0.0086283407  9.14273649    0.0765468971
#> 215  150.000      1.006804014         0.0069009429  9.17652991    0.0602372573
#> 216 1440.000      1.000000000         0.0027899169  9.11451462    0.0179808332
#> 217    0.167      0.970455694         0.0083084909 12.08405368    0.0811433966
#> 218    1.000      0.970746005         0.0086600073 12.08766861    0.0866407400
#> 219    5.000      1.017666462         0.0124581984 12.67191921    0.1397688762
#> 220   25.000      0.978863753         0.0082037698 12.18875030    0.0790218646
#> 221  150.000      0.993930064         0.0086185331 12.37635507    0.0848309449
#> 222 1440.000      1.000000000         0.0075110638 12.45193753    0.0661337863
#> 223    0.167      1.005319351         0.0143397359  8.96201224    0.1163241750
#> 224    1.000      1.005419151         0.0100698373  8.96290192    0.0724423082
#> 225    5.000      1.020827395         0.0078519465  9.10026013    0.0447467178
#> 226   25.000      1.005065091         0.0078038359  8.95974561    0.0450687616
#> 227  150.000      1.004567608         0.0064866444  8.95531075    0.0231966822
#> 228 1440.000      1.000000000         0.0083648420  8.91459239    0.0527283566
#> 229    0.167      1.006963836         0.0138582109 10.91907833    0.0119546832
#> 230    1.000      0.991750252         0.0155400830 10.75410883    0.0814224300
#> 231    5.000      1.024345203         0.0150083577 11.10755432    0.0571439577
#> 232   25.000      0.991230683         0.0148310488 10.74847486    0.0641900417
#> 233  150.000      1.013264779         0.0155870954 10.98740301    0.0764661708
#> 234 1440.000      1.000000000         0.0194012475 10.84356552    0.1487602040
#> 235    0.167      0.991377953         0.0036704996 12.27389899    0.0185522588
#> 236    1.000      0.998173008         0.0125906037 12.35802616    0.1501797154
#> 237    5.000      0.999234728         0.0052931891 12.37117094    0.0504609589
#> 238   25.000      0.990270249         0.0068522408 12.26018490    0.0740267151
#> 239  150.000      0.988548950         0.0050252130 12.23887410    0.0464722195
#> 240 1440.000      1.000000000         0.0047797976 12.38064550    0.0418444436
#> 241    0.167      1.006957103         0.0104996899  9.75272068    0.1005159807
#> 242    1.000      1.000380341         0.0020417528  9.68902251    0.0124954976
#> 243    5.000      1.013280585         0.0022875714  9.81396574    0.0158072940
#> 244   25.000      0.998433526         0.0037842407  9.67016695    0.0333067748
#> 245  150.000      0.999342941         0.0062924511  9.67897494    0.0589898781
#> 246 1440.000      1.000000000         0.0022371299  9.68533878    0.0153211376
#> 247    0.167      1.000393465         0.0072732304  5.77633439    0.0354449869
#> 248    1.000      0.994931430         0.0079265165  5.74479626    0.0399115120
#> 249    5.000      1.014989855         0.0059554683  5.86061486    0.0256952542
#> 250   25.000      0.996616507         0.0043648821  5.75452600    0.0114758728
#> 251  150.000      0.987452348         0.0063620727  5.70161157    0.0292434097
#> 252 1440.000      1.000000000         0.0055144915  5.77406250    0.0225150002
#> 253    0.167      1.001558901         0.0099268405  8.86556830    0.0364737761
#> 254    1.000      0.958859724         0.0174955458  8.48760503    0.1346333000
#> 255    5.000      1.011482409         0.0093176427  8.95340890    0.0168662763
#> 256   25.000      0.988823851         0.0129415008  8.75284057    0.0830274583
#> 257  150.000      0.994227481         0.0101149460  8.80067226    0.0414601870
#> 258 1440.000      1.000000000         0.0127522453  8.85176927    0.0798181660
#> 259    0.167      1.005158769         0.0113784167  7.94007417    0.0504343292
#> 260    1.000      0.956293129         0.0100532639  7.55406867    0.0360077954
#> 261    5.000      1.009240052         0.0119967714  7.97231353    0.0583139006
#> 262   25.000      0.978882126         0.0157865933  7.73250646    0.1014959959
#> 263  150.000      1.000421644         0.0107456437  7.90265408    0.0414983243
#> 264 1440.000      1.000000000         0.0132511560  7.89932338    0.0740165200
#> 265    0.167      1.005396438         0.0099247534  7.44720467    0.0253197921
#> 266    1.000      0.961773935         0.0091872432  7.12408267    0.0164956202
#> 267    5.000      1.012017985         0.0108356781  7.49625200    0.0401963204
#> 268   25.000      0.977284722         0.0134354568  7.23897467    0.0735080582
#> 269  150.000      0.992944463         0.0108193763  7.35497000    0.0421495415
#> 270 1440.000      1.000000000         0.0131062435  7.40723200    0.0686466238
#> 271    0.167      0.971063885         0.0151858941  2.07741833    0.0190436591
#> 272    1.000      0.990575986         0.0128266220  2.11916100    0.0056630755
#> 273    5.000      1.007289693         0.0142400131  2.15491700    0.0135138141
#> 274   25.000      0.959111345         0.0124858443  2.05184800    0.0061369391
#> 275  150.000      0.983973895         0.0136915969  2.10503700    0.0121089343
#> 276 1440.000      1.000000000         0.0179179380  2.13932200    0.0271049861
#> 277    0.167      0.996817301         0.0137032621  2.09112367    0.0115656840
#> 278    1.000      1.006974607         0.0224778661  2.11243167    0.0389449834
#> 279    5.000      1.011879547         0.0138427322  2.12272125    0.0113834475
#> 280   25.000      0.996909302         0.0210645313  2.09131667    0.0354957418
#> 281  150.000      0.988230529         0.0146127220  2.07311033    0.0160927255
#> 282 1440.000      1.000000000         0.0177983229  2.09780033    0.0264014777
#> 283    0.167      1.015077390         0.0215401930  1.69054000    0.0090639620
#> 284    1.000      0.951476186         0.0266148475  1.58461667    0.0301031113
#> 285    5.000      1.015924469         0.0240016584  1.69195075    0.0197754847
#> 286   25.000      0.953138269         0.0236849801  1.58738475    0.0222201976
#> 287  150.000      0.984525515         0.0324868895  1.63965800    0.0423553601
#> 288 1440.000      1.000000000         0.0290362659  1.66542967    0.0341941697
#> 289    0.167      0.952820146         0.0051404913  9.03015385    0.0428137326
#> 290    1.000      0.973051988         0.0138243866  9.22189690    0.1288488724
#> 291    5.000      1.000203551         0.0044533245  9.47922017    0.0344353391
#> 292   25.000      0.977449963         0.0050473954  9.26357779    0.0414671737
#> 293  150.000      0.990581574         0.0054397133  9.38802989    0.0455377162
#> 294 1440.000      1.000000000         0.0036407098  9.47729106    0.0243980593
#> 295    0.167      0.961073319         0.0061499039  9.75205584    0.0582141492
#> 296    1.000      0.980089082         0.0068526622  9.94500967    0.0656470175
#> 297    5.000      1.018021025         0.0075761398 10.32990688    0.0730950474
#> 298   25.000      0.985987798         0.0097499946 10.00486423    0.0962083009
#> 299  150.000      0.999532317         0.0027896339 10.14230109    0.0159599077
#> 300 1440.000      1.000000000         0.0032597945 10.14704669    0.0233891740
#> 301    0.167      0.959033632         0.0044902479 11.08608148    0.0470390169
#> 302    1.000      0.977131880         0.0057672803 11.29529068    0.0628068992
#> 303    5.000      1.012051593         0.0031389509 11.69894992    0.0279351569
#> 304   25.000      0.986272112         0.0066972872 11.40094845    0.0740561447
#> 305  150.000      1.001853763         0.0022585592 11.58106669    0.0124959372
#> 306 1440.000      1.000000000         0.0027992839 11.55963786    0.0228810619
#> 307    0.167      0.974733800         0.0139618987 12.07870975    0.0964482599
#> 308    1.000      0.994903330         0.0124268466 12.32864660    0.0471096690
#> 309    5.000      1.019272276         0.0123054058 12.63062180    0.0263112570
#> 310   25.000      0.998925063         0.0127189162 12.37848313    0.0563291002
#> 311  150.000      1.011867588         0.0135453014 12.53886436    0.0770759362
#> 312 1440.000      1.000000000         0.0168173441 12.39180354    0.1473590901
#> 313    0.167      0.966980281         0.0047612882 10.91057639    0.0457697051
#> 314    1.000      0.981194100         0.0068293467 11.07095294    0.0715755033
#> 315    5.000      1.015173807         0.0040852603 11.45435081    0.0353929105
#> 316   25.000      0.985364658         0.0076746047 11.11800994    0.0817121251
#> 317  150.000      1.000673827         0.0031104555 11.29074548    0.0196058891
#> 318 1440.000      1.000000000         0.0036459913 11.28314259    0.0290891286
#> 319    0.167      1.004143552         0.0032941291  6.90805438    0.0170017714
#> 320    1.000      0.977284737         0.0068386570  6.72327786    0.0447297059
#> 321    5.000      1.011685865         0.0045603231  6.95994209    0.0275021096
#> 322   25.000      0.984148137         0.0071068479  6.77049495    0.0466343141
#> 323  150.000      0.995122308         0.0046392669  6.84599229    0.0282513613
#> 324 1440.000      1.000000000         0.0030674575  6.87954861    0.0149218787
#> 325    0.167      1.003639598         0.0076920795  5.22558198    0.0173705032
#> 326    1.000      0.993760019         0.0100566787  5.17414265    0.0382750114
#> 327    5.000      1.010269079         0.0089896474  5.26009925    0.0295172244
#> 328   25.000      0.985180613         0.0116774199  5.12947284    0.0494150871
#> 329  150.000      0.987928835         0.0068363200  5.14378182    0.0022681101
#> 330 1440.000      1.000000000         0.0097662586  5.20663193    0.0359558947
#> 331    0.167      0.294294061         0.0062846944  1.02369648    0.0200013501
#> 332    1.000      0.481686280         0.0092401634  1.67553687    0.0287143473
#> 333    5.000      0.619800429         0.0075645056  2.15596439    0.0186289245
#> 334   25.000      0.811963778         0.0119864821  2.82440107    0.0338494241
#> 335  150.000      0.982362182         0.0093325928  3.41712878    0.0136505307
#> 336 1440.000      1.000000000         0.0121897513  3.47848161    0.0299826185
#> 337    0.167      0.243638447         0.0049191714  1.03507929    0.0206033245
#> 338    1.000      0.404537112         0.0112818308  1.71864495    0.0475761016
#> 339    5.000      0.529911173         0.0088058749  2.25128705    0.0366277771
#> 340   25.000      0.750141605         0.0147204549  3.18691919    0.0616025519
#> 341  150.000      0.989048674         0.0059620251  4.20189758    0.0209651154
#> 342 1440.000      1.000000000         0.0047838807  4.24842345    0.0143712034
#> 343    0.167      0.309352618         0.0116993113  1.04318467    0.0374178688
#> 344    1.000      0.514360950         0.0121243682  1.73450433    0.0352044108
#> 345    5.000      0.636591478         0.0087872447  2.14668450    0.0146953510
#> 346   25.000      0.829122795         0.0147045893  2.79592975    0.0365463074
#> 347  150.000      0.987794349         0.0128932567  3.33099467    0.0172096590
#> 348 1440.000      1.000000000         0.0169515001  3.37215400    0.0404203935
#> 349    0.167      0.212997601         0.0026257487  0.67085871    0.0039847687
#> 350    1.000      0.302771955         0.0115602043  0.95361263    0.0349225078
#> 351    5.000      0.340177833         0.0069606694  1.07142644    0.0186193786
#> 352   25.000      0.552646878         0.0112707975  1.74062040    0.0301099897
#> 353  150.000      0.913280004         0.0102152956  2.87647297    0.0083477997
#> 354 1440.000      1.000000000         0.0152766753  3.14960686    0.0340228113
#> 355    0.167      0.326170747         0.0039846030  1.46977360    0.0144822626
#> 356    1.000      0.462229528         0.0085442888  2.08287457    0.0354422084
#> 357    5.000      0.558017780         0.0059042703  2.51451059    0.0194455354
#> 358   25.000      0.661730356         0.0147539523  2.98185479    0.0628997256
#> 359  150.000      0.937257039         0.0087866351  4.22341875    0.0252484248
#> 360 1440.000      1.000000000         0.0102126202  4.50614780    0.0325407543
#> 361    0.167      0.425787778         0.0057563864  1.84379332    0.0240444773
#> 362    1.000      0.591644453         0.0060164143  2.56200424    0.0243990930
#> 363    5.000      0.701692549         0.0045759519  3.03854667    0.0165915224
#> 364   25.000      0.776610277         0.0184189336  3.36296370    0.0788533018
#> 365  150.000      0.980258879         0.0052771492  4.24482540    0.0171215562
#> 366 1440.000      1.000000000         0.0050422280  4.33031058    0.0154392617
#> 367    0.167      0.043650162         0.0063590076  0.13988492    0.0203337600
#> 368    1.000      0.110904267         0.0048951005  0.35541297    0.0153070144
#> 369    5.000      0.202772982         0.0053878302  0.64982305    0.0160850490
#> 370   25.000      0.545404259         0.0155597399  1.74784755    0.0469191513
#> 371  150.000      0.950018956         0.0143741039  3.04450923    0.0354566619
#> 372 1440.000      1.000000000         0.0136598193  3.20468261    0.0309538718
#> 373    0.167      0.014990611         0.0031026000  0.03753267    0.0077667058
#> 374    1.000      0.054207064         0.0094528807  0.13572067    0.0236615361
#> 375    5.000      0.122914774         0.0077357448  0.30774725    0.0193301833
#> 376   25.000      0.415278613         0.0201564458  1.03975175    0.0502993625
#> 377  150.000      0.946965446         0.0063209776  2.37096000    0.0127608380
#> 378 1440.000      1.000000000         0.0055835401  2.50374500    0.0098851836
#> 379    0.167      0.274101411         0.0095830305  1.13272371    0.0390509657
#> 380    1.000      0.442861306         0.0082311877  1.83012375    0.0323100108
#> 381    5.000      0.539867575         0.0103636359  2.23100203    0.0408182004
#> 382   25.000      0.816881117         0.0123793454  3.37576012    0.0472468467
#> 383  150.000      0.999926568         0.0140574846  4.13219520    0.0528971948
#> 384 1440.000      1.000000000         0.0082183118  4.13249865    0.0240148754
#> 385    0.167      0.441038612         0.0178831293  2.39562244    0.0951108031
#> 386    1.000      0.566324158         0.0059114069  3.07614532    0.0197154731
#> 387    5.000      0.646386750         0.0098774377  3.51102729    0.0451859987
#> 388   25.000      0.844337857         0.0133983544  4.58625314    0.0621990622
#> 389  150.000      1.009684165         0.0089659707  5.48437706    0.0181689878
#> 390 1440.000      1.000000000         0.0116515155  5.43177485    0.0447516629
#> 391    0.167      0.428791865         0.0150804389  2.59368067    0.0882494607
#> 392    1.000      0.524968629         0.0123473823  3.17543567    0.0691331946
#> 393    5.000      0.609458025         0.0061321778  3.68649600    0.0173004881
#> 394   25.000      0.832470032         0.0116074277  5.03545333    0.0540469228
#> 395  150.000      0.982490166         0.0091939980  5.94289667    0.0171784021
#> 396 1440.000      1.000000000         0.0125868157  6.04881033    0.0538357593
#> 397    0.167      0.377501084         0.0118243577  3.83389468    0.1186335693
#> 398    1.000      0.509045484         0.0072743196  5.16985739    0.0694738183
#> 399    5.000      0.615579242         0.0125351376  6.25181246    0.1236274754
#> 400   25.000      0.803264859         0.0267848822  8.15794444    0.2691218368
#> 401  150.000      0.968524382         0.0092709697  9.83631738    0.0811166633
#> 402 1440.000      1.000000000         0.0068732787 10.15598323    0.0493595203
#> 403    0.167      0.517766293         0.0083531132  2.73710250    0.0415543318
#> 404    1.000      0.629971675         0.0066581196  3.33026130    0.0301417462
#> 405    5.000      0.689988476         0.0143090361  3.64753212    0.0729765414
#> 406   25.000      0.884911777         0.0085049424  4.67796817    0.0370087996
#> 407  150.000      1.001473963         0.0073955917  5.29415864    0.0263381103
#> 408 1440.000      1.000000000         0.0077180164  5.28636672    0.0288501442
#> 409    0.167      0.418871621         0.0077933321  3.91271373    0.0612860358
#> 410    1.000      0.542297729         0.0146249186  5.06564699    0.1267899517
#> 411    5.000      0.672715581         0.0125474981  6.28389070    0.0987732100
#> 412   25.000      0.841027699         0.0234986700  7.85610782    0.2048381815
#> 413  150.000      0.982280101         0.0118644307  9.17555795    0.0615941095
#> 414 1440.000      1.000000000         0.0142004849  9.34108096    0.0937962151
#> 415    0.167      0.644856700         0.0224065099  2.33439200    0.0803761543
#> 416    1.000      0.798228922         0.0065498480  2.88960200    0.0194968820
#> 417    5.000      0.866563828         0.0075110751  3.13697550    0.0229071911
#> 418   25.000      0.923187094         0.0067622763  3.34195267    0.0188606225
#> 419  150.000      0.998295312         0.0059561501  3.61384567    0.0134212431
#> 420 1440.000      1.000000000         0.0066036928  3.62001667    0.0169037255
#> 421    0.167      0.481968964         0.0126512660  3.98827228    0.0979062208
#> 422    1.000      0.641586621         0.0191062314  5.30910148    0.1502055086
#> 423    5.000      0.735659978         0.0156405390  6.08755444    0.1164020411
#> 424   25.000      0.874877129         0.0119931559  7.23957033    0.0729486525
#> 425  150.000      0.963248017         0.0093382741  7.97083559    0.0219713978
#> 426 1440.000      1.000000000         0.0131443155  8.27495666    0.0769110439
#> 427    0.167      0.356103829         0.0018012966  6.30088435    0.0292431311
#> 428    1.000      0.494707655         0.0058885435  8.75333392    0.1026928117
#> 429    5.000      0.620479744         0.0077392916 10.97873931    0.1351458871
#> 430   25.000      0.856061868         0.0106333718 15.14711832    0.1856624737
#> 431  150.000      0.989211271         0.0058465609 17.50305757    0.0972720238
#> 432 1440.000      1.000000000         0.0028449669 17.69395283    0.0355948437
#> 433    0.167      0.444277219         0.0026205994  5.38755156    0.0088692487
#> 434    1.000      0.587068081         0.0070752258  7.11911262    0.0757317202
#> 435    5.000      0.708403227         0.0086151708  8.59048978    0.0924492107
#> 436   25.000      0.909461115         0.0084752624 11.02862905    0.0816123573
#> 437  150.000      0.996243288         0.0110974664 12.08099774    0.1158777024
#> 438 1440.000      1.000000000         0.0080103645 12.12655371    0.0686870204
#> 439    0.167      0.383759621         0.0071572711  1.56527900    0.0274788182
#> 440    1.000      0.496855530         0.0099343587  2.02657467    0.0384583202
#> 441    5.000      0.627028680         0.0128949196  2.55752500    0.0500695479
#> 442   25.000      0.808602970         0.0135435491  3.29813033    0.0511888500
#> 443  150.000      0.972723028         0.0093785656  3.96754333    0.0289679376
#> 444 1440.000      1.000000000         0.0089052473  4.07880067    0.0256840477
#> 445    0.167      0.798396358         0.0074316429  4.29527918    0.0299311916
#> 446    1.000      0.968288666         0.0100423510  5.20927996    0.0434212241
#> 447    5.000      0.991825761         0.0090789448  5.33590678    0.0360745104
#> 448   25.000      0.985444492         0.0071042184  5.30157630    0.0197568470
#> 449  150.000      0.980864912         0.0101689757  5.27693870    0.0439597013
#> 450 1440.000      1.000000000         0.0087274652  5.37988324    0.0332006034
#> 451    0.167      0.394555165         0.0123687274  3.33235400    0.0999044665
#> 452    1.000      0.518236805         0.0058287948  4.37695067    0.0285615843
#> 453    5.000      0.648532483         0.0083763541  5.47740850    0.0498708609
#> 454   25.000      0.856199920         0.0110765907  7.23133667    0.0660559547
#> 455  150.000      0.993611774         0.0097428668  8.39189667    0.0293433728
#> 456 1440.000      1.000000000         0.0129554255  8.44585067    0.0773713335
#> 457    0.167      0.434759173         0.0059365488  4.05701667    0.0475308570
#> 458    1.000      0.546207520         0.0076282497  5.09701267    0.0615556519
#> 459    5.000      0.675662327         0.0080345738  6.30503850    0.0605447841
#> 460   25.000      0.852607566         0.0129890396  7.95622800    0.1075987161
#> 461  150.000      0.980416021         0.0091078664  9.14889067    0.0557293148
#> 462 1440.000      1.000000000         0.0099192239  9.33164133    0.0654516704
#> 463    0.167      0.431137743         0.0059454561  3.06810667    0.0408776545
#> 464    1.000      0.597708136         0.0032931291  4.25347200    0.0178952509
#> 465    5.000      0.737204170         0.0078189219  5.24616800    0.0524186698
#> 466   25.000      0.907783105         0.0135882263  6.46005933    0.0939274536
#> 467  150.000      0.977613000         0.0065718872  6.95699000    0.0396825404
#> 468 1440.000      1.000000000         0.0050309058  7.11630267    0.0253154471
#> 469    0.167      0.291257349         0.0020293492  2.94549250    0.0166989152
#> 470    1.000      0.383090917         0.0052937614  3.87420755    0.0511845349
#> 471    5.000      0.529714451         0.0046785638  5.35701484    0.0420458465
#> 472   25.000      0.829493702         0.0157874800  8.38868952    0.1560018683
#> 473  150.000      0.993732152         0.0103284311 10.04963687    0.0961938831
#> 474 1440.000      1.000000000         0.0057281081 10.11302377    0.0409616302
#> 475    0.167      0.295977048         0.0047208042  2.67020289    0.0410156278
#> 476    1.000      0.410755834         0.0032427784  3.70569752    0.0245447783
#> 477    5.000      0.564306868         0.0069761459  5.09098202    0.0590142358
#> 478   25.000      0.846247136         0.0151009640  7.63454991    0.1322290123
#> 479  150.000      0.986448291         0.0057072544  8.89939640    0.0344893279
#> 480 1440.000      1.000000000         0.0060752954  9.02165525    0.0387559717
#> 481    0.167      0.040069949         0.0017100235  0.14164996    0.0060048894
#> 482    1.000      0.085438372         0.0017879649  0.30203038    0.0061440736
#> 483    5.000      0.238610453         0.0169107118  0.84350398    0.0596368086
#> 484   25.000      0.758220951         0.0200384183  2.68036198    0.0696034149
#> 485  150.000      0.995102924         0.0081365370  3.51775567    0.0229973809
#> 486 1440.000      1.000000000         0.0069451175  3.53506716    0.0173605017
#> 487    0.167      0.426338095         0.0097875645  2.66096464    0.0601592870
#> 488    1.000      0.528309576         0.0078745192  3.29741376    0.0473555984
#> 489    5.000      0.729644820         0.0083610275  4.55403607    0.0489209711
#> 490   25.000      0.855868674         0.0137266022  5.34185498    0.0829816168
#> 491  150.000      0.980664674         0.0048859141  6.12076202    0.0182712277
#> 492 1440.000      1.000000000         0.0056412464  6.24144234    0.0248968863
#> 493    0.167      0.357207391         0.0043322652  2.38731646    0.0269185983
#> 494    1.000      0.473008541         0.0060761197  3.16124780    0.0380743939
#> 495    5.000      0.658332008         0.0084116719  4.39981613    0.0526705633
#> 496   25.000      0.839817139         0.0047891144  5.61273180    0.0198979215
#> 497  150.000      0.987057051         0.0081254080  6.59677713    0.0456150798
#> 498 1440.000      1.000000000         0.0063168446  6.68327846    0.0298520906
#> 499    0.167      0.468671928         0.0013632076  2.28125166    0.0061806072
#> 500    1.000      0.590394827         0.0049502379  2.87373555    0.0239024890
#> 501    5.000      0.834008192         0.0083713023  4.05951895    0.0405200419
#> 502   25.000      0.923619049         0.0191093409  4.49569809    0.0928925919
#> 503  150.000      1.007126099         0.0042091242  4.90216706    0.0198201148
#> 504 1440.000      1.000000000         0.0014966438  4.86748091    0.0051511915
#> 505    0.167      0.373326146         0.0022900546  2.01371707    0.0071310881
#> 506    1.000      0.509800166         0.0057519685  2.74985641    0.0278012435
#> 507    5.000      0.733729630         0.0068515749  3.95772944    0.0311909788
#> 508   25.000      0.906707796         0.0134004466  4.89077174    0.0680042292
#> 509  150.000      0.998100631         0.0058938239  5.38374367    0.0168380118
#> 510 1440.000      1.000000000         0.0070834775  5.39398884    0.0270172765
#> 511    0.167      0.361882812         0.0049208824  2.40583581    0.0234377635
#> 512    1.000      0.488666824         0.0067575555  3.24870954    0.0326864044
#> 513    5.000      0.690989159         0.0086362598  4.59377016    0.0373798273
#> 514   25.000      0.903295674         0.0202659663  6.00520667    0.1220930018
#> 515  150.000      0.984058293         0.0114375160  6.54212524    0.0439304674
#> 516 1440.000      1.000000000         0.0134162688  6.64810742    0.0630688308
#> 517    0.167      0.573476097         0.0088851666  2.30871064    0.0274247798
#> 518    1.000      0.716206390         0.0089148499  2.88331689    0.0215754231
#> 519    5.000      0.936279424         0.0104300960  3.76929097    0.0189049761
#> 520   25.000      0.992337200         0.0127750988  3.99496939    0.0326491016
#> 521  150.000      1.005810085         0.0116229260  4.04920878    0.0238159020
#> 522 1440.000      1.000000000         0.0140671780  4.02581844    0.0400448039
#> 523    0.167      0.462708169         0.0096936001  2.11858432    0.0437314280
#> 524    1.000      0.598386946         0.0033912574  2.73981159    0.0120405408
#> 525    5.000      0.804303793         0.0030819268  3.68263523    0.0050453938
#> 526   25.000      0.946771787         0.0050276997  4.33494803    0.0170084259
#> 527  150.000      0.988776633         0.0058809430  4.52727402    0.0215078766
#> 528 1440.000      1.000000000         0.0050607534  4.57866202    0.0163847101
#> 529    0.167      0.651767255         0.0056766112  2.27065868    0.0197548254
#> 530    1.000      0.779031504         0.0053398148  2.71402810    0.0185702453
#> 531    5.000      0.964475281         0.0042956367  3.36008621    0.0149026589
#> 532   25.000      0.978328754         0.0072610201  3.40834962    0.0252581877
#> 533  150.000      1.009935640         0.0038992764  3.51846324    0.0135087101
#> 534 1440.000      1.000000000         0.0005759292  3.48384897    0.0014187745
#> 535    0.167      0.520961384         0.0019039484  2.12574259    0.0073009663
#> 536    1.000      0.648736621         0.0016092979  2.64711956    0.0056731895
#> 537    5.000      0.805967821         0.0053703451  3.28868929    0.0215247138
#> 538   25.000      0.942684557         0.0039658476  3.84655135    0.0154524323
#> 539  150.000      0.987216198         0.0078016545  4.02825927    0.0314337913
#> 540 1440.000      1.000000000         0.0017666804  4.08042258    0.0050973932
#> 541    0.167      0.688927524         0.0061614552  2.07786833    0.0155873411
#> 542    1.000      0.726682680         0.0065271223  2.19174133    0.0165421715
#> 543    5.000      0.811078804         0.0077212602  2.44628775    0.0200106462
#> 544   25.000      0.919009194         0.0209351754  2.77181567    0.0616828731
#> 545  150.000      1.003506415         0.0059873626  3.02666700    0.0104345153
#> 546 1440.000      1.000000000         0.0068866519  3.01609133    0.0146871532
#> 547    0.167      0.035299849         0.0023546626  0.11605667    0.0077196619
#> 548    1.000      0.102645638         0.0011654274  0.33747200    0.0034386771
#> 549    5.000      0.283892194         0.0125340330  0.93336325    0.0409426134
#> 550   25.000      0.734840871         0.0167531468  2.41596450    0.0537344089
#> 551  150.000      0.979568325         0.0078168935  3.22056433    0.0200076746
#> 552 1440.000      1.000000000         0.0070830151  3.28773833    0.0164664665
#> 553    0.167      0.016100108         0.0014159261  0.06530560    0.0056713764
#> 554    1.000      0.083851713         0.0024618218  0.34012110    0.0088001185
#> 555    5.000      0.234326615         0.0103785859  0.95048059    0.0399787016
#> 556   25.000      0.758185537         0.0139988733  3.07536826    0.0374613779
#> 557  150.000      0.985194576         0.0139196308  3.99616714    0.0106452976
#> 558 1440.000      1.000000000         0.0196228000  4.05622122    0.0562817525
#> 559    0.167      0.020527882         0.0019768970  0.09497517    0.0091394194
#> 560    1.000      0.075555464         0.0037382647  0.34956811    0.0172455834
#> 561    5.000      0.242904956         0.0065234885  1.12383437    0.0298844876
#> 562   25.000      0.730373428         0.0218838628  3.37917668    0.1004481753
#> 563  150.000      0.990493535         0.0052997343  4.58265940    0.0174423726
#> 564 1440.000      1.000000000         0.0053182703  4.62664241    0.0173988819
#> 565    0.167      0.011227974         0.0053034164  0.03602900    0.0170170006
#> 566    1.000      0.067249733         0.0025744029  0.21579500    0.0081924971
#> 567    5.000      0.196811620         0.0094040546  0.63154100    0.0300161559
#> 568   25.000      0.720732833         0.0104608271  2.31273100    0.0315831750
#> 569  150.000      0.995115815         0.0074383821  3.19318767    0.0179801761
#> 570 1440.000      1.000000000         0.0069524346  3.20886033    0.0157751220
#> 571    0.167      0.008092403         0.0033316280  0.03134356    0.0129026715
#> 572    1.000      0.059478779         0.0036157516  0.23037368    0.0139338691
#> 573    5.000      0.180308375         0.0094954999  0.69837184    0.0365304707
#> 574   25.000      0.704758757         0.0199498779  2.72967725    0.0754545015
#> 575  150.000      0.994001488         0.0076667308  3.84997451    0.0181716597
#> 576 1440.000      1.000000000         0.0086269887  3.87320800    0.0236273519
#> 577    0.167      0.025101351         0.0020220554  0.11779562    0.0094161082
#> 578    1.000      0.127812647         0.0031194245  0.59979920    0.0133610315
#> 579    5.000      0.287310232         0.0176081249  1.34828948    0.0815301159
#> 580   25.000      0.757829318         0.0157577159  3.55634148    0.0648881169
#> 581  150.000      0.979971487         0.0119799382  4.59881027    0.0325166993
#> 582 1440.000      1.000000000         0.0141032508  4.69280008    0.0467989687
#> 583    0.167      0.021079547         0.0052214243  0.06867333    0.0170096330
#> 584    1.000      0.065665315         0.0115990112  0.21392567    0.0377838949
#> 585    5.000      0.188386272         0.0147111948  0.61372825    0.0479031867
#> 586   25.000      0.711086612         0.0146656400  2.31659100    0.0474451459
#> 587  150.000      1.006840979         0.0056138504  3.28010500    0.0164603156
#> 588 1440.000      1.000000000         0.0034368283  3.25781833    0.0079171652
#> 589    0.167      0.008104809         0.0043484803  0.01935067    0.0103820239
#> 590    1.000      0.065974503         0.0020918984  0.15751767    0.0049660177
#> 591    5.000      0.201255476         0.0113898039  0.48050825    0.0271451509
#> 592   25.000      0.767226594         0.0193136652  1.83179467    0.0456942173
#> 593  150.000      0.972737925         0.0037410271  2.32246400    0.0042500558
#> 594 1440.000      1.000000000         0.0047837073  2.38755367    0.0080761196
#> 595    0.167      0.154297084         0.0039680748  0.63996678    0.0164294097
#> 596    1.000      0.301275532         0.0050452762  1.24957859    0.0208398087
#> 597    5.000      0.455002904         0.0066475849  1.88718241    0.0274225316
#> 598   25.000      0.793117021         0.0122391817  3.28955372    0.0505174561
#> 599  150.000      0.984875197         0.0084109756  4.08489514    0.0343302836
#> 600 1440.000      1.000000000         0.0021463656  4.14762719    0.0062948940
#> 601    0.167      0.075308965         0.0037285175  0.27204712    0.0133769602
#> 602    1.000      0.247103035         0.0020297036  0.89263833    0.0052128037
#> 603    5.000      0.400373861         0.0102277538  1.44631593    0.0359899141
#> 604   25.000      0.774061703         0.0098905733  2.79623093    0.0318693888
#> 605  150.000      0.983180962         0.0078944496  3.55165616    0.0198085700
#> 606 1440.000      1.000000000         0.0081690661  3.61241348    0.0208667525
#> 607    0.167      0.110464157         0.0065178986  0.48199400    0.0284102550
#> 608    1.000      0.250520166         0.0136318969  1.09310767    0.0594078900
#> 609    5.000      0.410061691         0.0033331855  1.78924350    0.0137226443
#> 610   25.000      0.778496975         0.0234841516  3.39685633    0.1020605584
#> 611  150.000      0.970101579         0.0072968437  4.23289467    0.0297285313
#> 612 1440.000      1.000000000         0.0038081206  4.36335200    0.0117494069
#> 613    0.167      0.233618712         0.0043458371  1.16656367    0.0215709895
#> 614    1.000      0.354698627         0.0176019667  1.77117033    0.0878209161
#> 615    5.000      0.509008465         0.0065672037  2.54170900    0.0323841222
#> 616   25.000      0.838889655         0.0100170060  4.18895467    0.0492905311
#> 617  150.000      0.977845383         0.0035254155  4.88282333    0.0145446374
#> 618 1440.000      1.000000000         0.0028723678  4.99345133    0.0101420528
#> 619    0.167      0.105865726         0.0061905372  0.33430600    0.0195188953
#> 620    1.000      0.290682601         0.0035780112  0.91792633    0.0109038105
#> 621    5.000      0.414587030         0.0129088543  1.30919550    0.0405445935
#> 622   25.000      0.748523010         0.0156801950  2.36370867    0.0489247373
#> 623  150.000      0.983622722         0.0101821665  3.10611367    0.0305523499
#> 624 1440.000      1.000000000         0.0045622096  3.15783033    0.0101870638
#> 625    0.167      0.142431705         0.0355389760  0.41848600    0.1043624400
#> 626    1.000      0.327179238         0.0055484724  0.96130233    0.0142670513
#> 627    5.000      0.492305878         0.0277059414  1.44646950    0.0805344230
#> 628   25.000      0.879679387         0.0176734027  2.58463175    0.0473991407
#> 629  150.000      1.014317730         0.0108868192  2.98021967    0.0206208462
#> 630 1440.000      1.000000000         0.0116038406  2.93815200    0.0241079908
#> 631    0.167      0.418343754         0.0030850836  0.82964567    0.0057047897
#> 632    1.000      0.609032823         0.0131657231  1.20781400    0.0259106780
#> 633    5.000      0.735349446         0.0097560759  1.45832100    0.0189536067
#> 634   25.000      0.925221136         0.0130647795  1.83486833    0.0254440563
#> 635  150.000      1.003809563         0.0067672300  1.99072233    0.0123274983
#> 636 1440.000      1.000000000         0.0037687447  1.98316733    0.0052849524
#>     hr_deut_uptake       hr_diff
#> 1      0.638755583 -3.147130e-01
#> 2      0.905258040 -3.950224e-01
#> 3      0.980189861 -3.513023e-01
#> 4      0.983172400 -1.372160e-01
#> 5      0.985446263 -1.561904e-02
#> 6      0.996731235  3.268765e-03
#> 7      0.673466708  6.713893e-02
#> 8      0.936251651  1.823597e-02
#> 9      0.998433209  1.760412e-02
#> 10     0.999963044 -2.611397e-03
#> 11     0.999963044 -4.023323e-03
#> 12     0.999963044  3.695625e-05
#> 13     0.664486535  8.992834e-02
#> 14     0.933790548  2.760146e-02
#> 15     0.998012164  1.194152e-02
#> 16     0.999647863  8.722811e-03
#> 17     0.999647863  1.000383e-03
#> 18     0.999647863  3.521373e-04
#> 19     0.691289700  8.967652e-07
#> 20     0.948336915 -2.534553e-04
#> 21     0.995246826  1.375065e-02
#> 22     0.996119892 -1.657401e-02
#> 23     0.996119892 -8.040142e-04
#> 24     0.996119892  3.880108e-03
#> 25     0.631925890  6.411628e-02
#> 26     0.923771783  2.256807e-02
#> 27     0.995855623  7.624978e-03
#> 28     0.997892112 -3.974662e-03
#> 29     0.997892112 -3.996124e-03
#> 30     0.997892112  2.107888e-03
#> 31     0.490832709 -1.785022e-01
#> 32     0.724037788 -2.482327e-02
#> 33     0.922287687  2.086615e-02
#> 34     0.972142343  3.295502e-02
#> 35     1.004483456  1.064750e-02
#> 36     1.004629535 -4.629535e-03
#> 37     0.232661264  3.691337e-03
#> 38     0.578611446 -8.563270e-03
#> 39     0.880639088  7.608860e-03
#> 40     0.987549369 -6.062368e-03
#> 41     1.009594292  1.294480e-02
#> 42     1.009594738 -9.594738e-03
#> 43     0.257511507  2.216323e-02
#> 44     0.582196566  8.182799e-03
#> 45     0.891512707  2.503644e-02
#> 46     0.989751213  6.904457e-03
#> 47     1.008430185 -3.211937e-03
#> 48     1.008430470 -8.430470e-03
#> 49     0.300248958 -3.165863e-02
#> 50     0.558302590 -5.310888e-02
#> 51     0.912550770 -4.519879e-02
#> 52     0.986606789  2.420095e-02
#> 53     1.010871453  2.191535e-02
#> 54     1.010954040 -1.095404e-02
#> 55     0.338617681 -4.163490e-02
#> 56     0.592572453 -1.558209e-02
#> 57     0.919200476 -5.418162e-02
#> 58     0.983536524  6.371484e-03
#> 59     1.009221630  2.211350e-03
#> 60     1.009389187 -9.389187e-03
#> 61     0.394425623  1.329848e-01
#> 62     0.679933318  9.857768e-02
#> 63     0.953091221 -2.248962e-03
#> 64     0.995839819 -2.778807e-02
#> 65     1.006537589 -1.661282e-02
#> 66     1.007762254 -7.762254e-03
#> 67     0.444838475  1.771252e-01
#> 68     0.734539847  8.625814e-02
#> 69     0.968041889 -2.362069e-03
#> 70     0.995753874 -5.987809e-03
#> 71     1.005108303 -7.855895e-03
#> 72     1.006658887 -6.658887e-03
#> 73     0.599933344  8.182246e-02
#> 74     0.854172171  3.349786e-02
#> 75     0.980744906  1.669030e-02
#> 76     0.990271127 -3.227576e-03
#> 77     1.002269317 -1.673827e-03
#> 78     1.004814735 -4.814735e-03
#> 79     0.646428351  8.274279e-02
#> 80     0.883412943  4.620276e-02
#> 81     0.983655778  1.856995e-02
#> 82     0.989522297  1.064953e-02
#> 83     0.999356129 -7.840282e-04
#> 84     1.004270281 -4.270281e-03
#> 85     0.706640882  2.218029e-02
#> 86     0.916072078  2.816511e-02
#> 87     0.980860268  1.714939e-02
#> 88     0.985954598  5.000940e-03
#> 89     0.997939773 -4.446040e-03
#> 90     1.002541741 -2.541741e-03
#> 91     0.738278160  3.014976e-07
#> 92     0.960859274 -1.883094e-04
#> 93     0.999321934  1.025067e-02
#> 94     1.000038689 -8.423989e-03
#> 95     1.000038689 -1.599933e-03
#> 96     1.000038689 -3.868881e-05
#> 97     0.722500400  1.050093e-02
#> 98     0.926100629  1.376012e-02
#> 99     0.982995230  2.887049e-02
#> 100    0.987544171  1.668859e-02
#> 101    0.998596664  2.430237e-03
#> 102    1.002772804 -2.772804e-03
#> 103    0.720338052  2.404207e-02
#> 104    0.922645128  4.109403e-03
#> 105    0.981468914  2.647527e-02
#> 106    0.986722617  5.426630e-03
#> 107    0.999113058  3.918993e-03
#> 108    1.003046221 -3.046221e-03
#> 109    0.746195797  9.122797e-03
#> 110    0.956616260 -6.480667e-03
#> 111    0.998013899  3.623213e-03
#> 112    0.998785768 -1.071098e-02
#> 113    0.998785768 -1.624301e-03
#> 114    0.998785768  1.214232e-03
#> 115    0.722526581  9.737654e-02
#> 116    0.924355369  3.716817e-02
#> 117    0.982311854  3.215704e-02
#> 118    0.987084426 -2.167648e-03
#> 119    0.998559791  2.166848e-02
#> 120    1.002662479 -2.662479e-03
#> 121    0.717565331  3.868628e-02
#> 122    0.918426935  1.871538e-02
#> 123    0.979628849  1.925193e-02
#> 124    0.985807689  9.456393e-03
#> 125    0.999765547 -8.164037e-04
#> 126    1.003380393 -3.380393e-03
#> 127    0.701704704 -2.937970e-02
#> 128    0.897422569 -2.592671e-02
#> 129    0.970839133 -9.265466e-03
#> 130    0.982547491 -2.168375e-03
#> 131    1.002951669  1.561793e-02
#> 132    1.005051246 -5.051246e-03
#> 133    0.144253493 -2.775558e-17
#> 134    0.485165920 -5.551115e-17
#> 135    0.870928221  0.000000e+00
#> 136    0.981793542 -1.110223e-16
#> 137    0.987831007 -1.110223e-16
#> 138    1.000000000  0.000000e+00
#> 139    0.637506558  8.235609e-02
#> 140    0.802564548  9.430171e-02
#> 141    0.977230545  4.558057e-02
#> 142    0.991991729  4.726262e-02
#> 143    0.999551691 -2.346427e-02
#> 144    1.000017458 -1.745810e-05
#> 145    0.649691115 -4.585865e-02
#> 146    0.811486049  1.724349e-03
#> 147    0.978523185  7.869386e-03
#> 148    0.992244460 -6.371085e-03
#> 149    0.999652538 -8.063653e-04
#> 150    1.000032995 -3.299530e-05
#> 151    0.659884652 -5.872763e-02
#> 152    0.823931686  8.545639e-03
#> 153    0.978363218 -2.615433e-03
#> 154    0.990392910 -9.677488e-03
#> 155    0.999573497 -3.607694e-04
#> 156    1.000249379 -2.493788e-04
#> 157    0.635832969 -6.889040e-02
#> 158    0.807508521  5.520921e-03
#> 159    0.976424633  2.026216e-02
#> 160    0.990144401  2.598942e-03
#> 161    0.999406720 -1.273144e-03
#> 162    1.000229963 -2.299626e-04
#> 163    0.690620499 -3.523703e-02
#> 164    0.837883873 -3.646681e-03
#> 165    0.981896996  3.350209e-03
#> 166    0.993075090 -1.864939e-04
#> 167    0.999766337 -2.336185e-03
#> 168    1.000010317 -1.031749e-05
#> 169    0.694365555 -3.912972e-02
#> 170    0.845098095  5.605284e-03
#> 171    0.980573440  1.078469e-02
#> 172    0.991004752  5.424370e-03
#> 173    0.999748345 -3.599486e-03
#> 174    1.000252875 -2.528750e-04
#> 175    0.666152144 -8.102555e-02
#> 176    0.826533026 -3.523483e-02
#> 177    0.978755725 -3.377644e-03
#> 178    0.990695421 -1.435518e-02
#> 179    0.999589006 -5.212280e-03
#> 180    1.000231376 -2.313758e-04
#> 181    0.740796972  1.203388e-03
#> 182    0.868883813 -3.615330e-02
#> 183    0.985190867 -1.665465e-03
#> 184    0.994030806 -1.832268e-03
#> 185    0.999843899  1.873309e-03
#> 186    0.999981160  1.883969e-05
#> 187    0.740820412  4.357383e-07
#> 188    0.873211425 -1.111964e-06
#> 189    0.984791950  7.210446e-06
#> 190    0.994034873 -1.506345e-05
#> 191    1.000081940  1.658250e-04
#> 192    1.000157293 -1.572929e-04
#> 193    0.733935343 -4.666684e-02
#> 194    0.872129933 -3.837003e-03
#> 195    0.981978873 -4.102536e-03
#> 196    0.991540296 -2.095199e-02
#> 197    1.000177731 -2.631522e-03
#> 198    1.000423746 -4.237458e-04
#> 199    0.243309149  7.888357e-03
#> 200    0.510670736  2.739049e-02
#> 201    0.827482844  3.005088e-02
#> 202    0.947541500  3.936700e-02
#> 203    0.984898286  7.984531e-03
#> 204    1.000002311 -2.311115e-06
#> 205    0.241655948  2.775558e-17
#> 206    0.506017616  0.000000e+00
#> 207    0.822428035  0.000000e+00
#> 208    0.941985968  0.000000e+00
#> 209    0.985014920 -1.110223e-16
#> 210    1.000000000 -2.220446e-16
#> 211    0.973941002 -2.631641e-02
#> 212    0.988612311 -1.568851e-03
#> 213    0.999706528  1.534107e-02
#> 214    1.002512095  5.842704e-04
#> 215    1.002513037  4.290978e-03
#> 216    1.002513037 -2.513037e-03
#> 217    0.978619427 -8.163734e-03
#> 218    0.990362769 -1.961676e-02
#> 219    0.998414415  1.925205e-02
#> 220    1.001876175 -2.301242e-02
#> 221    1.001884777 -7.954713e-03
#> 222    1.001884777 -1.884777e-03
#> 223    0.993329097  1.199025e-02
#> 224    1.000000000  5.419151e-03
#> 225    1.000000000  2.082739e-02
#> 226    1.000000000  5.065091e-03
#> 227    1.000000000  4.567608e-03
#> 228    1.000000000  0.000000e+00
#> 229    0.993329097  1.363474e-02
#> 230    1.000000000 -8.249748e-03
#> 231    1.000000000  2.434520e-02
#> 232    1.000000000 -8.769317e-03
#> 233    1.000000000  1.326478e-02
#> 234    1.000000000  0.000000e+00
#> 235    0.993329097 -1.951144e-03
#> 236    1.000000000 -1.826992e-03
#> 237    1.000000000 -7.652721e-04
#> 238    1.000000000 -9.729751e-03
#> 239    1.000000000 -1.145105e-02
#> 240    1.000000000  0.000000e+00
#> 241    0.993329097  1.362801e-02
#> 242    1.000000000  3.803408e-04
#> 243    1.000000000  1.328058e-02
#> 244    1.000000000 -1.566474e-03
#> 245    1.000000000 -6.570591e-04
#> 246    1.000000000  0.000000e+00
#> 247    0.993329097  7.064368e-03
#> 248    1.000000000 -5.068570e-03
#> 249    1.000000000  1.498986e-02
#> 250    1.000000000 -3.383493e-03
#> 251    1.000000000 -1.254765e-02
#> 252    1.000000000  0.000000e+00
#> 253    0.989639963  1.191894e-02
#> 254    1.000000000 -4.114028e-02
#> 255    1.000000000  1.148241e-02
#> 256    1.000000000 -1.117615e-02
#> 257    1.000000000 -5.772519e-03
#> 258    1.000000000  0.000000e+00
#> 259    0.989120644  1.603813e-02
#> 260    1.000000000 -4.370687e-02
#> 261    1.000000000  9.240052e-03
#> 262    1.000000000 -2.111787e-02
#> 263    1.000000000  4.216441e-04
#> 264    1.000000000  0.000000e+00
#> 265    0.988803085  1.659335e-02
#> 266    1.000000000 -3.822607e-02
#> 267    1.000000000  1.201798e-02
#> 268    1.000000000 -2.271528e-02
#> 269    1.000000000 -7.055537e-03
#> 270    1.000000000  0.000000e+00
#> 271    0.971063885  6.849450e-10
#> 272    0.999999999 -9.424013e-03
#> 273    1.000000000  7.289693e-03
#> 274    1.000000000 -4.088866e-02
#> 275    1.000000000 -1.602611e-02
#> 276    1.000000000  0.000000e+00
#> 277    0.991480896  5.336405e-03
#> 278    1.000000000  6.974607e-03
#> 279    1.000000000  1.187955e-02
#> 280    1.000000000 -3.090698e-03
#> 281    1.000000000 -1.176947e-02
#> 282    1.000000000  0.000000e+00
#> 283    0.993329097  2.174829e-02
#> 284    1.000000000 -4.852381e-02
#> 285    1.000000000  1.592447e-02
#> 286    1.000000000 -4.686173e-02
#> 287    1.000000000 -1.547449e-02
#> 288    1.000000000  0.000000e+00
#> 289    0.962416583 -9.596437e-03
#> 290    0.980060372 -7.008384e-03
#> 291    0.993224457  6.979094e-03
#> 292    0.994055723 -1.660576e-02
#> 293    0.994055724 -3.474150e-03
#> 294    0.994055724  5.944276e-03
#> 295    0.963377803 -2.304483e-03
#> 296    0.980639485 -5.504030e-04
#> 297    0.993430809  2.459022e-02
#> 298    0.994385960 -8.398161e-03
#> 299    0.994385961  5.146356e-03
#> 300    0.994385961  5.614039e-03
#> 301    0.964915452 -5.881821e-03
#> 302    0.981722634 -4.590753e-03
#> 303    0.993747645  1.830395e-02
#> 304    0.994947358 -8.675246e-03
#> 305    0.994947365  6.906398e-03
#> 306    0.994947365  5.052635e-03
#> 307    0.962005865  1.272794e-02
#> 308    0.980639485  1.426385e-02
#> 309    0.993430809  2.584147e-02
#> 310    0.994385960  4.539103e-03
#> 311    0.994385961  1.748163e-02
#> 312    0.994385961  5.614039e-03
#> 313    0.960315838  6.664443e-03
#> 314    0.980060372  1.133728e-03
#> 315    0.993224457  2.194935e-02
#> 316    0.994055723 -8.691065e-03
#> 317    0.994055724  6.618104e-03
#> 318    0.994055724  5.944276e-03
#> 319    0.993329097  1.081446e-02
#> 320    1.000000000 -2.271526e-02
#> 321    1.000000000  1.168587e-02
#> 322    1.000000000 -1.585186e-02
#> 323    1.000000000 -4.877692e-03
#> 324    1.000000000  0.000000e+00
#> 325    0.993329097  1.031050e-02
#> 326    1.000000000 -6.239981e-03
#> 327    1.000000000  1.026908e-02
#> 328    1.000000000 -1.481939e-02
#> 329    1.000000000 -1.207117e-02
#> 330    1.000000000  0.000000e+00
#> 331    0.307345868 -1.305181e-02
#> 332    0.509661809 -2.797553e-02
#> 333    0.634144556 -1.434413e-02
#> 334    0.826795575 -1.483180e-02
#> 335    0.987132935 -4.770753e-03
#> 336    1.000000000 -5.728751e-14
#> 337    0.299612587 -5.597414e-02
#> 338    0.496835274 -9.229816e-02
#> 339    0.621953792 -9.204262e-02
#> 340    0.816443999 -6.630239e-02
#> 341    0.987194536  1.854138e-03
#> 342    1.000000000 -6.439294e-14
#> 343    0.309352618  0.000000e+00
#> 344    0.514360950  1.110223e-16
#> 345    0.636591478  0.000000e+00
#> 346    0.829122795  0.000000e+00
#> 347    0.987794349  0.000000e+00
#> 348    1.000000000  0.000000e+00
#> 349    0.216534429 -3.536828e-03
#> 350    0.308579943 -5.807988e-03
#> 351    0.383444379 -4.326655e-02
#> 352    0.585591194 -3.294432e-02
#> 353    0.934198379 -2.091837e-02
#> 354    0.999457045  5.429555e-04
#> 355    0.250387007  7.578374e-02
#> 356    0.354412108  1.078174e-01
#> 357    0.463407498  9.461028e-02
#> 358    0.612928071  4.880229e-02
#> 359    0.934652776  2.604263e-03
#> 360    0.999702260  2.977402e-04
#> 361    0.224658488  2.011293e-01
#> 362    0.320517543  2.711269e-01
#> 363    0.422960741  2.787318e-01
#> 364    0.584487048  1.921232e-01
#> 365    0.931198793  4.906009e-02
#> 366    0.997955982  2.044018e-03
#> 367    0.020448825  2.320134e-02
#> 368    0.061414477  4.948979e-02
#> 369    0.139865009  6.290797e-02
#> 370    0.437090645  1.083136e-01
#> 371    0.956650354 -6.631398e-03
#> 372    0.995410214  4.589786e-03
#> 373    0.016362659 -1.372049e-03
#> 374    0.051736271  2.470794e-03
#> 375    0.126180605 -3.265832e-03
#> 376    0.413089303  2.189309e-03
#> 377    0.949712384 -2.746939e-03
#> 378    0.997984812  2.015188e-03
#> 379    0.274070282  3.112914e-05
#> 380    0.443765764 -9.044583e-04
#> 381    0.538592691  1.274885e-03
#> 382    0.817421607 -5.404899e-04
#> 383    0.999610042  3.165258e-04
#> 384    1.000168373 -1.683734e-04
#> 385    0.352990823  8.804779e-02
#> 386    0.507519615  5.880454e-02
#> 387    0.595362553  5.102420e-02
#> 388    0.830225690  1.411217e-02
#> 389    0.999338170  1.034600e-02
#> 390    1.000220456 -2.204561e-04
#> 391    0.381328212  4.746365e-02
#> 392    0.532511666 -7.543037e-03
#> 393    0.620629033 -1.117101e-02
#> 394    0.836027503 -3.557471e-03
#> 395    0.999211868 -1.672170e-02
#> 396    1.000238685 -2.386850e-04
#> 397    0.432818549 -5.531747e-02
#> 398    0.580664836 -7.161935e-02
#> 399    0.677106921 -6.152768e-02
#> 400    0.828111092 -2.484623e-02
#> 401    0.994022299 -2.549792e-02
#> 402    0.998919144  1.080856e-03
#> 403    0.393561172  1.242051e-01
#> 404    0.543591358  8.638032e-02
#> 405    0.631768300  5.822018e-02
#> 406    0.838686668  4.622511e-02
#> 407    0.999152479  2.321484e-03
#> 408    1.000246497 -2.464974e-04
#> 409    0.443100962 -2.422934e-02
#> 410    0.591260629 -4.896290e-02
#> 411    0.689046718 -1.633114e-02
#> 412    0.830597192  1.043051e-02
#> 413    0.993292982 -1.101288e-02
#> 414    0.998841067  1.158933e-03
#> 415    0.428763453  2.160932e-01
#> 416    0.576358962  2.218700e-01
#> 417    0.664178956  2.023849e-01
#> 418    0.846969900  7.621719e-02
#> 419    0.998965581 -6.702689e-04
#> 420    1.000268819 -2.688186e-04
#> 421    0.468204456  1.376451e-02
#> 422    0.617827518  2.375910e-02
#> 423    0.718665772  1.699421e-02
#> 424    0.837829364  3.704777e-02
#> 425    0.991201189 -2.795317e-02
#> 426    0.998651452  1.348548e-03
#> 427    0.305437503  5.066633e-02
#> 428    0.463276078  3.143158e-02
#> 429    0.592005266  2.847448e-02
#> 430    0.797911352  5.815052e-02
#> 431    0.993888336 -4.677065e-03
#> 432    0.999300756  6.992439e-04
#> 433    0.434178194  1.009903e-02
#> 434    0.599180629 -1.211255e-02
#> 435    0.745439067 -3.703584e-02
#> 436    0.852972752  5.648836e-02
#> 437    0.985111998  1.113129e-02
#> 438    0.998979752  1.020248e-03
#> 439    0.484169954 -1.004103e-01
#> 440    0.635223458 -1.383679e-01
#> 441    0.772022802 -1.449941e-01
#> 442    0.860533154 -5.193018e-02
#> 443    0.988465997 -1.574297e-02
#> 444    1.000151030 -1.510296e-04
#> 445    0.549640873  2.487555e-01
#> 446    0.709999806  2.582889e-01
#> 447    0.818231185  1.735946e-01
#> 448    0.874700313  1.107442e-01
#> 449    0.981090629 -2.257173e-04
#> 450    0.998044683  1.955317e-03
#> 451    0.518904309 -1.243491e-01
#> 452    0.689901810 -1.716650e-01
#> 453    0.823748689 -1.752162e-01
#> 454    0.885014759 -2.881484e-02
#> 455    0.979807131  1.380464e-02
#> 456    0.998603351  1.396649e-03
#> 457    0.504362223 -6.960305e-02
#> 458    0.675462617 -1.292551e-01
#> 459    0.817623285 -1.419610e-01
#> 460    0.884315257 -3.170769e-02
#> 461    0.980287790  1.282309e-04
#> 462    0.998696461  1.303539e-03
#> 463    0.496173953 -6.503621e-02
#> 464    0.663442696 -6.573456e-02
#> 465    0.804642131 -6.743796e-02
#> 466    0.877169183  3.061392e-02
#> 467    0.972119227  5.493773e-03
#> 468    0.998303449  1.696551e-03
#> 469    0.219791044  7.146630e-02
#> 470    0.388423014 -5.332097e-03
#> 471    0.523407161  6.307290e-03
#> 472    0.771075049  5.841865e-02
#> 473    0.992677109  1.055043e-03
#> 474    0.998615912  1.384088e-03
#> 475    0.146401614  1.495754e-01
#> 476    0.282515675  1.282402e-01
#> 477    0.398766705  1.655402e-01
#> 478    0.732898732  1.133484e-01
#> 479    0.996496490 -1.004820e-02
#> 480    1.000000007 -7.158158e-09
#> 481    0.009442783  3.062717e-02
#> 482    0.055228581  3.020979e-02
#> 483    0.247279521 -8.669067e-03
#> 484    0.758360092 -1.391414e-04
#> 485    0.999800927 -4.698003e-03
#> 486    1.000000000  0.000000e+00
#> 487    0.556107958 -1.297699e-01
#> 488    0.634226183 -1.059166e-01
#> 489    0.790730958 -6.108614e-02
#> 490    0.912285185 -5.641651e-02
#> 491    1.002046243 -2.138157e-02
#> 492    1.003199495 -3.199495e-03
#> 493    0.566268181 -2.090608e-01
#> 494    0.641168782 -1.681602e-01
#> 495    0.792125499 -1.337935e-01
#> 496    0.912839869 -7.302273e-02
#> 497    1.001999004 -1.494195e-02
#> 498    1.003113236 -3.113236e-03
#> 499    0.609696634 -1.410247e-01
#> 500    0.694959650 -1.045648e-01
#> 501    0.852426531 -1.841834e-02
#> 502    0.939150646 -1.553160e-02
#> 503    1.002443864  4.682235e-03
#> 504    1.003490359 -3.490359e-03
#> 505    0.616159962 -2.428338e-01
#> 506    0.697086371 -1.872862e-01
#> 507    0.848498415 -1.147688e-01
#> 508    0.937267414 -3.055962e-02
#> 509    1.002350248 -4.249617e-03
#> 510    1.003372672 -3.372672e-03
#> 511    0.571599761 -2.097169e-01
#> 512    0.646146875 -1.574801e-01
#> 513    0.796070110 -1.050810e-01
#> 514    0.913704337 -1.040866e-02
#> 515    1.001169311 -1.711102e-02
#> 516    1.002317526 -2.317526e-03
#> 517    0.662909866 -8.943377e-02
#> 518    0.732129511 -1.592312e-02
#> 519    0.859424332  7.685509e-02
#> 520    0.943288819  4.904838e-02
#> 521    1.002271187  3.538897e-03
#> 522    1.002896090 -2.896090e-03
#> 523    0.665674457 -2.029663e-01
#> 524    0.731090267 -1.327033e-01
#> 525    0.853714240 -4.941045e-02
#> 526    0.940529038  6.242749e-03
#> 527    1.002164173 -1.338754e-02
#> 528    1.002805205 -2.805205e-03
#> 529    0.676044358 -2.427710e-02
#> 530    0.735602477  4.342903e-02
#> 531    0.847289944  1.171853e-01
#> 532    0.930385452  4.794330e-02
#> 533    1.001562674  8.372966e-03
#> 534    1.002894908 -2.894908e-03
#> 535    0.677561559 -1.566002e-01
#> 536    0.734183439 -8.544682e-02
#> 537    0.842420435 -3.645261e-02
#> 538    0.928721112  1.396344e-02
#> 539    1.001549930 -1.433373e-02
#> 540    1.002792810 -2.792810e-03
#> 541    0.688820815  1.067084e-04
#> 542    0.726859964 -1.772835e-04
#> 543    0.810932801  1.460026e-04
#> 544    0.919171134 -1.619395e-04
#> 545    1.001341069  2.165346e-03
#> 546    1.002078122 -2.078122e-03
#> 547    0.092310751 -5.701090e-02
#> 548    0.179601388 -7.695575e-02
#> 549    0.331359512 -4.746732e-02
#> 550    0.757782219 -2.294135e-02
#> 551    0.996493234 -1.692491e-02
#> 552    0.996898278  3.101722e-03
#> 553    0.073771641 -5.767153e-02
#> 554    0.160902395 -7.705068e-02
#> 555    0.317485108 -8.315849e-02
#> 556    0.754965450  3.220087e-03
#> 557    0.996955999 -1.176142e-02
#> 558    0.997341382  2.658618e-03
#> 559    0.060766042 -4.023816e-02
#> 560    0.146707875 -7.115241e-02
#> 561    0.307236009 -6.433105e-02
#> 562    0.752989648 -2.261622e-02
#> 563    0.997299169 -6.805635e-03
#> 564    0.997673709  2.326291e-03
#> 565    0.011540488 -3.125141e-04
#> 566    0.063493950  3.755782e-03
#> 567    0.252008029 -5.519641e-02
#> 568    0.742781757 -2.204892e-02
#> 569    0.996246817 -1.131002e-03
#> 570    0.996551925  3.448075e-03
#> 571    0.010865291 -2.772889e-03
#> 572    0.060976758 -1.497979e-03
#> 573    0.249953719 -6.964534e-02
#> 574    0.743218468 -3.845971e-02
#> 575    0.996744816 -2.743328e-03
#> 576    0.997044507  2.955493e-03
#> 577    0.014692870  1.040848e-02
#> 578    0.076346345  5.146630e-02
#> 579    0.268535055  1.877518e-02
#> 580    0.746419216  1.141010e-02
#> 581    0.996092280 -1.612079e-02
#> 582    0.996408068  3.591932e-03
#> 583    0.009639575  1.143997e-02
#> 584    0.055891774  9.773541e-03
#> 585    0.244468500 -5.608223e-02
#> 586    0.744325950 -3.323934e-02
#> 587    0.997989415  8.851564e-03
#> 588    0.998275962  1.724038e-03
#> 589    0.009110454 -1.005645e-03
#> 590    0.053328982  1.264552e-02
#> 591    0.239681762 -3.842629e-02
#> 592    0.745916162  2.131043e-02
#> 593    0.999730932 -2.699301e-02
#> 594    1.000000000  0.000000e+00
#> 595    0.081795647  7.250144e-02
#> 596    0.247660244  5.361529e-02
#> 597    0.390755814  6.424709e-02
#> 598    0.749393527  4.372349e-02
#> 599    0.992525883 -7.650687e-03
#> 600    0.993383213  6.616787e-03
#> 601    0.102151870 -2.684291e-02
#> 602    0.283373718 -3.627068e-02
#> 603    0.413725209 -1.335135e-02
#> 604    0.751617701  2.244400e-02
#> 605    0.991433614 -8.252652e-03
#> 606    0.992437958  7.562042e-03
#> 607    0.137688373 -2.722422e-02
#> 608    0.323346897 -7.282673e-02
#> 609    0.447520324 -3.745863e-02
#> 610    0.779522944 -1.025969e-03
#> 611    0.992954399 -2.285282e-02
#> 612    0.993623068  6.376932e-03
#> 613    0.166611691  6.700702e-02
#> 614    0.353081409  1.617219e-03
#> 615    0.479706723  2.930174e-02
#> 616    0.800886622  3.800303e-02
#> 617    0.994058981 -1.621360e-02
#> 618    0.994544820  5.455180e-03
#> 619    0.106554022 -6.882965e-04
#> 620    0.289574293  1.108308e-03
#> 621    0.415774812 -1.187782e-03
#> 622    0.747855165  6.678454e-04
#> 623    0.991368023 -7.745302e-03
#> 624    0.992518786  7.481214e-03
#> 625    0.154060691 -1.162899e-02
#> 626    0.340762896 -1.358366e-02
#> 627    0.462844902  2.946098e-02
#> 628    0.786452866  9.322652e-02
#> 629    0.993432490  2.088524e-02
#> 630    0.994085461  5.914539e-03
#> 631    0.418343751  2.582250e-09
#> 632    0.609032868 -4.476220e-08
#> 633    0.735347911  1.535124e-06
#> 634    0.925227093 -5.956737e-06
#> 635    1.001886263  1.923299e-03
#> 636    1.001918837 -1.918837e-03
```
