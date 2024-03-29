#'
#'
#' @export create_two_state_dataset

create_two_state_dataset <- function(hires_params_1,
                                     hires_params_2){

  merge(hires_params_1, hires_params_2, by = c("position")) %>%
    select(position, color.x, color.y, k_est.x, k_est.y) %>%
    mutate(dist = calculate_color_distance(color.x, color.y),
           k_diff = k_est.x - k_est.y) %>%
    arrange(position) %>%
    select(position, color.x, color.y, dist, k_diff)

}

#'
#'
#' @export

create_uc_distance_dataset <- function(kin_dat_1,
                                       kin_dat_2){

  peptide_list <- merge(kin_dat_1, kin_dat_2, by = c("Start", "End")) %>%
    select(Start, End) %>%
    unique(.) %>%
    arrange(Start, End)

  protein_length <- max(peptide_list[["End"]])

  lapply(1:nrow(peptide_list), function(i){

    fit_dat_1 <- filter(kin_dat_1,
                        Start == peptide_list[["Start"]][i],
                        End == peptide_list[["End"]][i])%>%
      mutate(frac_deut_uptake = 100*frac_deut_uptake,
             err_frac_deut_uptake = 100*err_frac_deut_uptake)

    fit_dat_2 <- filter(kin_dat_2,
                        Start == peptide_list[["Start"]][i],
                        End == peptide_list[["End"]][i]) %>%
      mutate(frac_deut_uptake = 100*frac_deut_uptake,
             err_frac_deut_uptake = 100*err_frac_deut_uptake)

    get_uc_distance(fit_dat_1, fit_dat_2)

  }) %>% bind_rows()

}

#'
#'
#' @export get_uc_distance
#'
get_uc_distance <- function(fit_dat_1,
                            fit_dat_2){

    res <- merge(fit_dat_1, fit_dat_2, by = c("MaxUptake", "Start", "End", "Exposure")) %>%
      mutate(tmp_frac_uptake_diff = ((frac_deut_uptake.x - frac_deut_uptake.y)/(err_frac_deut_uptake.x + err_frac_deut_uptake.y))^2,
             tmp_uptake_diff = ((deut_uptake.x - deut_uptake.y)/(err_deut_uptake.x + err_deut_uptake.y))^2) %>%
      # mutate(tmp_frac_uptake_dist = abs(frac_deut_uptake.y - frac_deut_uptake.x) - (err_frac_deut_uptake.x + err_frac_deut_uptake.y),
      #        tmp_uptake_dist = abs(deut_uptake.y - deut_uptake.x) - (err_deut_uptake.y + err_deut_uptake.x)) %>%
      # mutate(tmp_uptake_dist = ifelse(tmp_uptake_dist < 0, 0, tmp_uptake_dist),
      #        tmp_frac_uptake_dist = ifelse(tmp_frac_uptake_dist <0, 0, tmp_frac_uptake_dist)) %>%
      mutate(tmp_frac_uptake_dist = ifelse((err_frac_deut_uptake.x + err_frac_deut_uptake.y) > abs(frac_deut_uptake.y - frac_deut_uptake.x), 0, abs(frac_deut_uptake.y - frac_deut_uptake.x)),
             tmp_uptake_dist = ifelse((err_deut_uptake.y + err_deut_uptake.x) > abs(deut_uptake.y - deut_uptake.x), 0, abs(deut_uptake.y - deut_uptake.x))) %>%
      arrange(Exposure) %>%
      group_by(MaxUptake, Start, End) %>%
      summarize(frac_uptake_diff = sum(tmp_frac_uptake_diff, na.rm = T),
                uptake_diff = sum(tmp_uptake_diff, na.rm = T),
                frac_uptake_dist = mean(tmp_frac_uptake_dist, na.rm = T),
                uptake_dist = mean(tmp_uptake_dist, na.rm = T),
                Sequence = paste(unique(Sequence.x), unique(Sequence.y), sep = "/"))

  return(res)

}


