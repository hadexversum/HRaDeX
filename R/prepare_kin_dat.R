#' @importFrom HaDeX create_control_dataset create_kinetic_dataset create_state_uptake_dataset
#' @importFrom dplyr %>% select filter mutate
#'
#' @export

prepare_kin_dat <- function(dat,
                            state = dat[["State"]][1],
                            time_0 = min(dat[["Exposure"]]),
                            time_100 = max(dat[["Exposure"]]),
                            FD = FALSE){

  kin_dat <- dat %>%
    create_control_dataset(control_exposure = time_100) %>%
    create_state_uptake_dataset(.,
                                state = state,
                                time_0 = time_0,
                                time_100 = 99999) %>%
    filter(Exposure != 99999) %>%
    select(-Modification, -Med_Sequence, -contains("theo")) %>%
    mutate(frac_deut_uptake = frac_deut_uptake/100,
           err_frac_deut_uptake = err_frac_deut_uptake/100)

  if(FD){

    kin_dat <- filter(kin_dat, Exposure < time_100)

  }

  kin_dat

}

