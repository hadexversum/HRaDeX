#' @export
get_peptide_list <- function(dat){

  arrange(unique(select(dat, Start, End)), Start, End)
}


#' @importFrom dplyr ungroup
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
