#' @export
get_peptide_list <- function(dat){
  arrange(unique(select(dat, Sequence, Start, End)), Start, End)
}
