# Rewrites the sequence based on the exchanging bonds

In this convention, the residue in upper case indicates a presence of
peptide bond proceeding it that is able to undergo the exchange. The
first residue is by default in lower case as it is not proceeded by
exchangable hydrogen from peptide bond. Second residue, based on the
calculated value of hamuro retention between pair of first and second
residue, is either in lower or upper case, depending on the threshold.
The rest of residues are in upper case, with exception of proline, that
due to its structure, is blocking the hydrogen from proceeding bond from
exchange. Function from prepHaDeX.

## Usage

``` r
get_sequence_bonds(sequence, threshold = 0.3)
```

## Arguments

- sequence:

  peptide sequence

- thereshold:

  cut-off value of hamuro retention

## Value

peptide sequence with lower and upper case

## Examples

``` r
get_sequence_bonds("ALGKYGPADVE")
#> [1] "aLGKYGpADVE"
```
