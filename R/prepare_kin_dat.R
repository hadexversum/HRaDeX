#' @importFrom HaDeX create_control_dataset create_kinetic_dataset
#' @importFrom dplyr %>% select filter mutate
#'
#' @export

prepare_kin_dat <- function(dat,
                            state = dat[["State"]][1],
                            time_0 = min(dat[["Exposure"]]),
                            time_100 = max(dat[["Exposure"]])){

  peptide_list <- dat %>%
    select(Sequence, State, Start, End) %>%
    unique(.) %>%
    filter(State == state)

  kin_dat <- dat %>%
    create_control_dataset(control_exposure = time_100) %>%
    create_kinetic_dataset(peptide_list,
                           time_0 = time_0,
                           time_100 = 99999) %>%
    # filter(Exposure > 0.01) %>%
    select(-time_chosen, -Modification, -starts_with("err"), -Med_Sequence, -starts_with("theo")) %>%
    mutate(frac_deut_uptake = frac_deut_uptake/100)

  kin_dat

}
