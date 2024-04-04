#' Omit first amino of peptides
#'
#' @param dat dataset to be modified
#' @param omit numer of residues to me omitted
#'
#' @description In some approach, ommitting the first amino residue in the peptide is a
#' way to correct back-exchange. This function modifies provided dataset and omits desired
#' number of residues (omit parameter) effectively changing the Start position of each
#' peptide.
#'
#' @return data.frame in the same format as provided.
#'
#' @export

omit_amino <- function(dat,
                       omit = 1){

  dat[, "Start"] <- dat[, "Start"] + remove

  return(dat)

}
