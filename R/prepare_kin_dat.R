#' Creates uptake data from mass measurements
#'
#' @importFrom HaDeX create_control_dataset create_kinetic_dataset create_state_uptake_dataset calculate_exp_masses_per_replicate
#' @importFrom dplyr %>% select filter mutate
#'
#' @param dat experimental data read by HaDeX::read_hdx
#' @param state biological state
#' @param time_0 minimal exchange control time point
#' @param time_100 maximal exchange control time point
#' @param replicate idicator, if the replicate values should be provided, or aggregated
#' @param FD idicator, if the time_100 value shoul be used as fully deuterated control,
#' only for normalization purposes, or left as time point of measurement
#'
#' @description Function calculates deuterium uptake for each time point
#' in the original data with respect to the parameters.
#'
#' @return a data.frame object.
#'
#' @seealso HaDeX::read_hdx
#'
#' @examples
#' dat <- HaDeX::read_hdx(...)
#' kin_dat <- prepare_kin_dat(dat, state = state_1)
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
      filter(State == state) %>%
      filter(Exposure >= time_0, Exposure <= time_100) %>%
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
      filter(State == state) %>%
      filter(Exposure >= time_0, Exposure <= time_100) %>%
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


#' Calculcate uptake
#'
#' @param rep_peptide_dat data from experimental file, but aggregated within
#' technical replicates
#' @param state biological state
#' @param time_0 minimal exchange control time point
#' @param time_100 maximal exchange control time point
#'
#' @description Function calculates deuterim uptake for one biological state,
#' for replicates, without additional aggregation of the data.
#'
#' @return a data.frame object.
#'
#' @seealso HaDeX::read_hdx
#'
#' @examples
#' dat <- HaDeX::read_hdx(...)
#' TODO
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

#' Creates deuterium uptake replicate dataset
#'
#' @param rep_dat data
#' @param state biological state
#' @param time_0 minimal exchange control time point
#' @param time_100 maximal exchange control time point
#'
#' @description Wrapper for calculate_replicate_state_uptake, interating
#' throught all the peptides in provided data.
#'
#' @return a data.frame object.
#'
#' @seealso calculate_replicate_state_uptake
#'
#' @examples
#' TODO
#'
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
                                     time_100 = time_100) %>%
      mutate(frac_deut_uptake = frac_deut_uptake,
             err_frac_deut_uptake = err_frac_deut_uptake)

  }) %>% bind_rows() %>%
    select(-File)

}
