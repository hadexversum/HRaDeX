#' @importFrom HaDeX create_control_dataset create_kinetic_dataset create_state_uptake_dataset calculate_exp_masses_per_replicate
#' @importFrom dplyr %>% select filter mutate
#'
#' @export

prepare_kin_dat <- function(dat,
                            state = dat[["State"]][1],
                            time_0 = min(dat[["Exposure"]]),
                            time_100 = max(dat[["Exposure"]]),
                            replicate = F,
                            FD = FALSE){

  if(replicate){

    kin_dat <- dat %>%
      calculate_exp_masses_per_replicate() %>%
      create_control_dataset(control_exposure = time_100) %>%
      create_replicate_state_uptake_dataset(rep_dat = .,
                                            state = state,
                                            time_0 = time_0,
                                            time_100 = 99999) %>%
      filter(Exposure != 99999) %>%
      select(-Modification)


  } else {

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


  }

  if(FD){

    kin_dat <- filter(kin_dat, Exposure < time_100)

  }

  kin_dat

}


#'
#'
#' @export
calculate_replicate_state_uptake <- function(rep_peptide_dat,
                                             state = dat[["State"]][1],
                                             time_0 = min(dat[["Exposure"]]),
                                             time_100 = max(dat[["Exposure"]])){

  m_0 <- rep_peptide_dat %>%
    filter(Exposure == time_0) %>%
    select(avg_exp_mass) %>% .[[1]] %>% mean()

  m_100 <- rep_peptide_dat %>%
    filter(Exposure == time_100) %>%
    select(avg_exp_mass) %>% .[[1]] %>% mean()

  rep_peptide_dat %>%
    filter(Exposure > time_0, Exposure <= time_100) %>%
    mutate(frac_deut_uptake = (avg_exp_mass - m_0)/(m_100 - m_0),
           deut_uptake = avg_exp_mass - m_0)
}

#' @export
create_replicate_state_uptake_dataset <- function(rep_dat,
                                                  state = dat[["State"]][1],
                                                  time_0 = min(dat[["Exposure"]]),
                                                  time_100 = max(dat[["Exposure"]])){

  peptide_list <- rep_dat %>%
    filter(State == state) %>%
    select(Sequence, Start, End) %>%
    unique(.)

  lapply(1:nrow(peptide_list), function(i){

    tmp_dat <- rep_dat %>%
      filter(Sequence == peptide_list[[i, "Sequence"]],
             State == state,
             Start == peptide_list[[i, "Start"]],
             End == peptide_list[[i, "End"]])

    calculate_replicate_state_uptake(tmp_dat,
                                     state = state,
                                     time_0 = time_0,
                                     time_100 = time_100)

  }) %>% bind_rows() %>%
    select(-File)

}
