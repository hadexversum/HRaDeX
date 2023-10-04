#' @importFrom ggplot2 scale_y_continuous
#'
#' @export plot_two_states

plot_two_states <- function(hires_params_1,
                            hires_params_2,
                            type = c("aggregated", "classes", "coverage")){

  state_1 <- hires_params_1[["State"]][1]
  state_2 <- hires_params_2[["State"]][1]

  protein_length <- max(hires_params_1[["position"]], hires_params_2[["position"]])

  ggplot() +
    geom_rect(data = hires_params_1, aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1), fill = hires_params_1[["color"]]) +
    geom_rect(data = subset(hires_params_1, is.na(n_1)),
              aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1), fill = "#B8B8B8") +
    geom_rect(data = hires_params_2, aes(xmin = position, xmax = position + 1, ymin = 1, ymax = 2), fill = hires_params_2[["color"]]) +
    geom_rect(data = subset(hires_params_2, is.na(n_1)),
              aes(xmin = position, xmax = position + 1, ymin = 1, ymax = 2), fill = "#B8B8B8") +
    geom_hline(yintercept = 1, linetype = "dashed") +
    labs(title = paste0("Assigned class on sequence for states: ", state_1, " and ", state_2),
         x = "Position",
         y = "") +
    theme_bw() +
    scale_y_continuous(breaks = c(0.5, 1.5), labels = c(state_1, state_2)) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank()) +
    coord_cartesian(x = c(0, protein_length+1))

}



#'
#'
#' @export create_two_state_dataset

create_two_state_dataset <- function(hires_params_1,
                                     hires_params_2){

  merge(hires_params_1, hires_params_2, by = c("Protein", "position")) %>%
    select(Protein, position, color.x, color.y) %>%
    mutate(dist = calculate_color_distance(color.x, color.y)) %>%
    arrange(position)

}

#'
#'
#' @export plot_color_distance

plot_color_distance <- function(two_state_dataset){

  protein_length <- max(two_state_dataset[["position"]])

  two_state_dataset %>%
    filter(!is.na(color.x)) %>%
    filter(!is.na(color.y)) %>%
  ggplot() +
    geom_point(aes(x = position, y = dist)) +
    labs(title = "Distance between assigned colors",
         x = "Position",
         y = "Distance") +
    coord_cartesian(x = c(0, protein_length+1))

}


#'
#' @importFrom ggplot2 geom_segment
#'
#'
#' @export plot_uc_distance

plot_uc_distance <- function(kin_dat_1,
                             kin_dat_2,
                             fractional = T){


  peptide_list <- merge(kin_dat_1, kin_dat_2, by = c("Protein", "Sequence", "Start", "End")) %>%
    select(Sequence, Start, End) %>%
    unique(.) %>%
    arrange(Start, End)

  protein_length <- max(peptide_list[["End"]])

  res <- lapply(1:nrow(peptide_list), function(i){

    fit_dat_1 <- filter(kin_dat_1,
                        Sequence == peptide_list[["Sequence"]][i],
                        Start == peptide_list[["Start"]][i],
                        End == peptide_list[["End"]][i])
    fit_dat_2 <- filter(kin_dat_2,
                        Sequence == peptide_list[["Sequence"]][i],
                        Start == peptide_list[["Start"]][i],
                        End == peptide_list[["End"]][i])

    get_uc_distance(fit_dat_1, fit_dat_2)

  }) %>% bind_rows()

  if (fractional){
    ggplot(res) +
      geom_segment(aes(x = Start, xend = End, y = frac_uptake_diff, yend = frac_uptake_diff)) +
      labs(title = "Fractional uptake difference",
           y = "diff value",
           x = "Position") +
      coord_cartesian(x = c(0, protein_length+1))

  } else {

    ggplot(res) +
      geom_segment(aes(x = Start, xend = End, y = uptake_diff, yend = uptake_diff)) +
      labs(title = "Uptake difference",
           y = "diff value",
           x = "Position") +
      coord_cartesian(x = c(0, protein_length+1))
  }

}



#'
#'
#' @export get_uc_distance
#'
get_uc_distance <- function(fit_dat_1,
                            fit_dat_2){

  merge(fit_dat_1, fit_dat_2, by = c("ID", "Protein", "MaxUptake", "Sequence", "Start", "End", "Exposure")) %>%
    mutate(tmp_frac_uptake_diff = ((frac_deut_uptake.x - frac_deut_uptake.y)/(err_frac_deut_uptake.x + err_frac_deut_uptake.y))^2,
           tmp_uptake_diff = ((deut_uptake.x - deut_uptake.y)/(err_deut_uptake.x + err_deut_uptake.y))^2) %>%
    arrange(Exposure) %>%
    group_by(ID, Protein, MaxUptake, Sequence, Start, End) %>%
    summarize(frac_uptake_diff = sum(tmp_frac_uptake_diff),
              uptake_diff = sum(tmp_uptake_diff))

}


#'
#'
#' @export plot_uc

plot_uc <- function(fit_dat_1,
                    fit_dat_2,
                    fit_values_1,
                    fit_values_2,
                    fractional = F){

  v_sequence = fit_dat_1[["Sequence"]][1]
  v_start = fit_dat_1[["Start"]][1]
  v_end = fit_dat_1[["End"]][1]

  fit_params_1 <- fit_values_1 %>%
    filter(sequence == v_sequence,
           start == v_start,
           end == v_end)

  fit_params_2 <- fit_values_2 %>%
    filter(sequence == v_sequence,
           start == v_start,
           end == v_end)

  if (fractional) {

    ggplot() +
      geom_point(data = fit_dat_1, aes(x = Exposure, y = frac_deut_uptake, shape = State)) +
      # geom_line(data = fit_dat_1, aes(x = Exposure, y = frac_deut_uptake, linetype = State)) +
      geom_point(data = fit_dat_2, aes(x = Exposure, y = frac_deut_uptake, shape = State)) +
      # geom_line(data = fit_dat_2, aes(x = Exposure, y = frac_deut_uptake, linetype = State)) +
      scale_x_log10() +
      ylim(c(0, 1.25)) +
      theme(legend.position = "bottom") +
      stat_function(fun=function(x){fit_params_1[["n_1"]]*(1-exp(-fit_params_1[["k_1"]]*x)) + fit_params_1[["n_2"]]*(1-exp(-fit_params_1[["k_2"]]*x)) + fit_params_1[["n_3"]]*(1-exp(-fit_params_1[["k_3"]]*x))}, linetype = "dashed") +
      stat_function(fun = function(x){fit_params_1[["n_1"]]*(1-exp(-fit_params_1[["k_1"]]*x))}, color = "red", linetype = "dashed") +
      stat_function(fun = function(x){fit_params_1[["n_2"]]*(1-exp(-fit_params_1[["k_2"]]*x))}, color = "green", linetype = "dashed") +
      stat_function(fun = function(x){fit_params_1[["n_3"]]*(1-exp(-fit_params_1[["k_3"]]*x))}, color = "blue", linetype = "dashed") +
      stat_function(fun=function(x){fit_params_2[["n_1"]]*(1-exp(-fit_params_2[["k_1"]]*x)) + fit_params_2[["n_2"]]*(1-exp(-fit_params_2[["k_2"]]*x)) + fit_params_2[["n_3"]]*(1-exp(-fit_params_2[["k_3"]]*x))}, linetype = "solid") +
      stat_function(fun = function(x){fit_params_2[["n_1"]]*(1-exp(-fit_params_2[["k_1"]]*x))}, color = "red", linetype = "solid") +
      stat_function(fun = function(x){fit_params_2[["n_2"]]*(1-exp(-fit_params_2[["k_2"]]*x))}, color = "green", linetype = "solid") +
      stat_function(fun = function(x){fit_params_2[["n_3"]]*(1-exp(-fit_params_2[["k_3"]]*x))}, color = "blue", linetype = "solid") +
      labs(x = "Exposure [min]",
           y = "Fractional DU [%]",
           title = paste0("Deuterium uptake curve for peptide ", v_sequence, " (", v_start, "-", v_end, ")"))

  } else {

    ggplot() +
      geom_point(data = fit_dat_1, aes(x = Exposure, y = deut_uptake, shape = State)) +
      geom_point(data = fit_dat_2, aes(x = Exposure, y = deut_uptake, shape = State)) +
      scale_x_log10() +
      theme(legend.position = "bottom") +
      stat_function(fun=function(x){fit_params_1[["n_1"]]*(1-exp(-fit_params_1[["k_1"]]*x)) + fit_params_1[["n_2"]]*(1-exp(-fit_params_1[["k_2"]]*x)) + fit_params_1[["n_3"]]*(1-exp(-fit_params_1[["k_3"]]*x))}, linetype = "dashed") +
      stat_function(fun = function(x){fit_params_1[["n_1"]]*(1-exp(-fit_params_1[["k_1"]]*x))}, color = "red", linetype = "dashed") +
      stat_function(fun = function(x){fit_params_1[["n_2"]]*(1-exp(-fit_params_1[["k_2"]]*x))}, color = "green", linetype = "dashed") +
      stat_function(fun = function(x){fit_params_1[["n_3"]]*(1-exp(-fit_params_1[["k_3"]]*x))}, color = "blue", linetype = "dashed") +
      stat_function(fun=function(x){fit_params_2[["n_1"]]*(1-exp(-fit_params_2[["k_1"]]*x)) + fit_params_2[["n_2"]]*(1-exp(-fit_params_2[["k_2"]]*x)) + fit_params_2[["n_3"]]*(1-exp(-fit_params_2[["k_3"]]*x))}, linetype = "solid") +
      stat_function(fun = function(x){fit_params_2[["n_1"]]*(1-exp(-fit_params_2[["k_1"]]*x))}, color = "red", linetype = "solid") +
      stat_function(fun = function(x){fit_params_2[["n_2"]]*(1-exp(-fit_params_2[["k_2"]]*x))}, color = "green", linetype = "solid") +
      stat_function(fun = function(x){fit_params_2[["n_3"]]*(1-exp(-fit_params_2[["k_3"]]*x))}, color = "blue", linetype = "solid") +
      labs(x = "Exposure [min]",
           y = "DU [Da]",
           title = paste0("Deuterium uptake curve for peptide ", v_sequence, " (", v_start, "-", v_end, ")"))

  }


}
