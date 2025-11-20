# Prepares differential data

Function prepares the results in a format that can be used for 3D
presentation. It transforms the peptide data into resiudal data, with
regard to the original values above the threshold.

## Usage

``` r
prepare_diff_data(params, value, threshold)
```

## Arguments

- params:

  values to be presented.

- value:

  which value should be presented.

- threshold:

  threshold for the values.

## Value

a data.frame object.

## See also

plot_3d_structure_blank
