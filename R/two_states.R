#' Creates dataset with merged hires parameters for two states.
#'
#' @param hires_params_1 data.frame with hires parameters for the first state
#' @param hires_params_2 data.frame with hires parameters for the second state
#'
#' @description This function merges the hires parameters for two biological
#' states, provided the same position values. It also calculates the color
#' distance and estimed k diffrence for each position.
#' This function is part of comparative feature.
#'
#' @return data.frame for plotting functions
#'
#' @seealso calculate_color_distance calculate_hires
#'
#' @examples
#' dat <- HaDeX::read_hdx(...)
#' fit_k_params <- get_example_fit_k_params()
#' control <- get_example_control()
#' kin_dat <- prepare_kin_dat(dat)
#' fit_values <- create_fit_dataset(kin_dat, control, fit_k_params)
#' hires_params <- calculate_hires(fit_values)
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

#' Creates dataset with uc distances
#'
#' @param kin_dat_1 kinetic data for the first state
#' @param kin_dat_2 kinetic data for the second state
#'
#' @description This function iterates through common list of peptides in
#' two states, based on their position in the sequence. For each pair of peptide
#' data, the uc distance is calculated. The method of uc distance calucation is
#' described in the vigniette TODO.
#'
#' @return data.frame for plotting functions
#'
#' @seealso get_uc_distance plot_uc_distance
#'
#' @examples
#' dat <- HaDeX::read_hdx(...)
#' kin_dat_1 <- prepare_kin_dat(dat, state = state_1)
#' kin_dat_2 <- prepare_kin_dat(dat, state = state_2)
#' uc_dist_dataset <- create_uc_distance_dataset(kin_dat_1, kin_dat_2)
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

#' Calculates the uc distance for uptake curve
#'
#' @param fit_dat_1 data.frame with uc data for peptide in first state
#' @param fit_dat_2 data.frame with uc data for peptide in second state
#'
#' @description Calculates the uc distance between uptake curves for one peptide in two
#' biological states. The possible methods of caluclation is described in the
#' vignette TODO.
#' This function supports comparison of two different peptides provided that the
#' values `Start`, `End`, `MaxUptake` and `Exposure` are the same.
#'
#' @return a one-row data.frame
#'
#' @seealso create_uc_distance_dataset
#'
#' @examples
#' dat <- HaDeX::read_hdx(...)
#' kin_dat_1 <- prepare_kin_dat(dat, state = state_1)
#' kin_dat_2 <- prepare_kin_dat(dat, state = state_2)
#' fit_dat_1 <- kin_dat_1[ID == 1, ]
#' fit_dat_2 <- kin_dat_2[ID == 1, ]
#' get_uc_distance(fit_dat_1, fit_dat_2)
#'
#' @export get_uc_distance

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


