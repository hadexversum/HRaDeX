#' @export
get_peptide_list <- function(kin_dat){

  unique(select(kin_dat, Sequence, Start, End))
}
