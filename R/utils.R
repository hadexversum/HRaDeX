#' Provides a peptide list
#'
#' @param dat data.frame
#'
#' @description Created peptite list based on the provided data.frame.
#'
#' @return a data.frame with position values, Start and End.
#'
#' @examples
#' dat <- HaDeX::read_hdx(...)
#' get_peptide_list(dat)
#'
#' @export
get_peptide_list <- function(dat){

  arrange(unique(select(dat, Start, End)), Start, End)

}


#' Provides a peptide list
#'
#' @importFrom dplyr ungroup
#'
#' @param dat_1 data.frame
#' @param dat_2 data.frame
#'
#' @description Created peptite list from two binded data.frames.
#' The peptides are selected based on their position values. If there
#' are two peptides with the same position but different sequence, both sequences
#' are shown in the final data.frame.
#'
#' @return a data.frame with sequence and position values.
#' @examples
#' dat_1 <- HaDeX::read_hdx(...)
#' dat_2 <- HaDeX::read_hdx(...)
#' get_peptide_list_v2(dat_1, dat_2)
#'
#' @export
get_peptide_list_v2 <- function(dat_1, dat_2){

  rbind(dat_1, dat_2) %>%
    select(Sequence, Start, End) %>%
    arrange(Start, End) %>%
    unique() %>%
    group_by(Start, End) %>%
    mutate(Sequence = paste(Sequence, collapse = "/")) %>%
    ungroup(.) %>%
    unique(.)

}
