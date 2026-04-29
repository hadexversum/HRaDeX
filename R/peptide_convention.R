#' check if supplied data uses convention
#'
#' @param dat a dataset to check
#'
#' @export

check_convention_usage <- function(dat){

  first <- if("Sequence" %in% colnames(dat)) {
    substr(dat[["Sequence"]][1], 1, 1)
  } else if ("sequence" %in% colnames(dat)) {
    substr(dat[["sequence"]][1], 1, 1)
    } else message("Peptide sequence not found")

    return(first == tolower(first))

}

#' Rewrites the sequence based on the exchanging bonds
#'
#' @param sequence peptide sequence
#' @param thereshold cut-off value of hamuro retention
#'
#' @importFrom dplyr coalesce
#'
#' @description
#' In this convention, the residue in upper case indicates a presence
#' of peptide bond proceeding it that is able to undergo the exchange.
#' The first residue is by default in lower case as it is not proceeded
#' by exchangable hydrogen from peptide bond. Second residue, based on the
#' calculated value of hamuro retention between pair of first and second
#' residue, is either in lower or upper case, depending on the threshold.
#' The rest of residues are in upper case, with exception of proline, that
#' due to its structure, is blocking the hydrogen from proceeding bond from exchange.
#' Function from prepHaDeX.
#'
#' @return peptide sequence with lower and upper case
#'
#' @examples
#' get_sequence_bonds("ALGKYGPADVE")
#'
#' @export

get_sequence_bonds <- function(sequence,
                               threshold = 0.3){

  data(hrates)

  residues <- strsplit(sequence, "")[[1]]

  res <- lapply(1:length(residues), function(i){


    if(i == 1) {
      tolower(residues[i])
    } else if(i == 2) {
      if(coalesce(HRaDeX::rate_n[residues[1], residues[2]], 0) < threshold) tolower(residues[i])
      else residues[i]
    } else if(residues[i] == "P"){
      tolower(residues[i])
    } else if(i == length(residues)){
      if(coalesce(HRaDeX::rate_c[residues[i], residues[i-1]], 0) < threshold) tolower(residues[i])
      else residues[i]
    } else {
      if(coalesce(HRaDeX::rate_m[residues[i-1], residues[i]], 0) < threshold) tolower(residues[i])
      else residues[i]
    }
  }) %>%
    unlist() %>%
    paste(., collapse = "")

  return(res)
}

#' Create peptide sequence list
#'
#' @param dat daa with peptide sequences
#'
#' @importFrom dplyr select rowwise
#'
#' @description
#' This is a wrapper function for
#' get_sequence_bonds - there are the details.
#' Function from prepHaDeX.
#'
#' @return a peptide list with column containg
#' sequence in convention.
#'
#' @examples
#' head(create_sequence_list(alpha_dat))
#'
#' @export

create_sequence_list <- function(dat,
                                 threshold = 0.3){

  peptide_list <- dat %>%
    select(Sequence, Start, End) %>%
    unique(.) %>%
    rowwise() %>%
    mutate(seq_bond = get_sequence_bonds(sequence = Sequence,
                                         threshold = threshold),
           n_bonds = stringr::str_count(seq_bond, "[A-Z]"))

  return(peptide_list)
}

#' Replace sequence with sequences within convention
#'
#' @param dat data with sequences to be replaced
#'
#' @importFrom dplyr rename
#'
#' @description The original peptide sequences are
#' replaced with the peptide convention - described in
#' the get_sequence_bonds function. Moreover the
#' maximal uptake value is calculated based on the
#' number of exchangeable bonds according to the convention.
#' Function from prepHaDeX.
#'
#' @examples
#' replace_sequences(alpha_dat)
#'
#' @export

replace_sequences <- function(dat,
                              threshold = 0.3){

  new_peptide_list <- create_sequence_list(dat,
                                           threshold = threshold)

  fin <- merge(dat, new_peptide_list, by = c("Sequence", "Start", "End")) %>%
    select(-Sequence, -MaxUptake) %>%
    rename(Sequence = seq_bond,
           MaxUptake = n_bonds) %>%
    select(Sequence, everything()) %>%
    arrange(Start, End)

  return(fin)
}
