#' @importFrom ggplot2 scale_y_continuous
#'
#' @export plot_two_states

plot_two_states <- function(hires_params_1,
                            hires_params_2,
                            type = c("aggregated", "classes", "coverage"),
                            interactive = F){

  state_1 <- hires_params_1[["State"]][1]
  state_2 <- hires_params_2[["State"]][1]

  protein_length <- max(hires_params_1[["position"]], hires_params_2[["position"]])

  if(interactive){
    sel_rect_1 <- geom_rect_interactive(data = hires_params_1,
                            aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1,
                                tooltip = glue("Position: {position}
                                               State: {State}
                                               class name: {class_name}
                                               n_1 = {formatC(n_1, 2)}
                                               n_2 = {formatC(n_2, 2)}
                                               n_3 = {formatC(n_3, 2)}")),
                            fill = hires_params_1[["color"]])
    sel_rect_na_1 <- geom_rect_interactive(data = subset(hires_params_1, is.na(n_1)),
                               aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1,
                                   tooltip = glue("Position: {position}
                                                   no data available")),
                               fill = "#B8B8B8")
    sel_rect_2 <- geom_rect_interactive(data = hires_params_2,
                            aes(xmin = position, xmax = position + 1, ymin = 1, ymax = 2,
                                tooltip = glue("Position: {position}
                                               State: {State}
                                               class name: {class_name}
                                               n_1 = {formatC(n_1, 2)}
                                               n_2 = {formatC(n_2, 2)}
                                               n_3 = {formatC(n_3, 2)}")),
                            fill = hires_params_2[["color"]])
    sel_rect_na_2 <- geom_rect_interactive(data = subset(hires_params_2, is.na(n_1)),
                               aes(xmin = position, xmax = position + 1, ymin = 1, ymax = 2,
                                   tooltip = glue("Position: {position}
                                                   no data available")),
                               fill = "#B8B8B8")

  } else {
    sel_rect_1 <- geom_rect(data = hires_params_1, aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1), fill = hires_params_1[["color"]])
    sel_rect_na_1 <- geom_rect(data = subset(hires_params_1, is.na(n_1)),
                aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1), fill = "#B8B8B8")
    sel_rect_2 <- geom_rect(data = hires_params_2, aes(xmin = position, xmax = position + 1, ymin = 1, ymax = 2), fill = hires_params_2[["color"]])
    sel_rect_na_2 <- geom_rect(data = subset(hires_params_2, is.na(n_1)),
                aes(xmin = position, xmax = position + 1, ymin = 1, ymax = 2), fill = "#B8B8B8")
  }

  plt <- ggplot() +
    sel_rect_1 +
    sel_rect_na_1 +
    sel_rect_2 +
    sel_rect_na_2 +
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

  girafe(ggobj = plt,
         width_svg = 10,
         height_svg = 4)

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

plot_color_distance <- function(two_state_dataset,
                                interactive = T){

  protein_length <- max(two_state_dataset[["position"]])

  if(interactive){
    sel_points <- geom_point_interactive(aes(x = position, y = dist,
                                             tooltip = glue("Position: {position}
                                                            Distance = {formatC(dist, 2)}")))
  } else {
    sel_points <- geom_point(aes(x = position, y = dist))
  }

  plt <- two_state_dataset %>%
    filter(!is.na(color.x)) %>%
    filter(!is.na(color.y)) %>%
  ggplot() +
    sel_points +
    labs(title = "Distance between assigned colors",
         x = "Position",
         y = "Distance") +
    coord_cartesian(x = c(0, protein_length+1))

  girafe(ggobj = plt,
         width_svg = 10,
         height_svg = 4)
}

#'
#'
#' @export

create_uc_distance_dataset <- function(kin_dat_1,
                                       kin_dat_2, scaled = T){

  peptide_list <- merge(kin_dat_1, kin_dat_2, by = c("Protein", "Sequence", "Start", "End")) %>%
    select(Sequence, Start, End) %>%
    unique(.) %>%
    arrange(Start, End)

  protein_length <- max(peptide_list[["End"]])

lapply(1:nrow(peptide_list), function(i){

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


}


#' @importFrom ggplot2 geom_segment
#' @importFrom ggiraph geom_segment_interactive
#'
#' @export plot_uc_distance

plot_uc_distance <- function(uc_distance_dataset,
                             fractional = T,
                             interactive = F){

  protein_length <- max(uc_distance_dataset[["End"]])

  if (fractional){

    if(interactive){
      sel_segment <- geom_segment_interactive(aes(x = Start, xend = End, y = frac_uptake_diff, yend = frac_uptake_diff,
                                      tooltip = glue("Sequence: {Sequence}
                                                     Position: {Start}-{End}
                                                     Difference = {formatC(frac_uptake_diff, 2)}")))
    } else {
      sel_segment <- geom_segment(aes(x = Start, xend = End, y = frac_uptake_diff, yend = frac_uptake_diff))
    }

    plt <- ggplot(uc_distance_dataset) +
      sel_segment +
      labs(title = "Fractional uptake difference",
           y = "diff value",
           x = "Position") +
      theme_bw(base_size = 18) +
      coord_cartesian(x = c(0, protein_length+1))

  } else {

    if(interactive){
      sel_segment <- geom_segment_interactive(aes(x = Start, xend = End, y = uptake_diff, yend = uptake_diff,
                                                  tooltip = glue("Sequence: {Sequence}
                                                     Position: {Start}-{End}
                                                     Difference = {formatC(uptake_diff, 2)}")))
    } else {
      sel_segment <- geom_segment(aes(x = Start, xend = End, y = uptake_diff, yend = uptake_diff))
    }

    plt <- ggplot(uc_distance_dataset) +
      sel_segment +
      labs(title = "Uptake difference",
           y = "diff value",
           x = "Position") +
      theme_bw(base_size = 18) +
      coord_cartesian(x = c(0, protein_length+1))
  }

  girafe(ggobj = plt,
         width_svg = 10,
         height_svg = 4)

}



#'
#'
#' @export get_uc_distance
#'
get_uc_distance <- function(fit_dat_1,
                            fit_dat_2){



    res <- merge(fit_dat_1, fit_dat_2, by = c("Protein", "MaxUptake", "Sequence", "Start", "End", "Exposure")) %>%
      mutate(tmp_frac_uptake_diff = ((frac_deut_uptake.x - frac_deut_uptake.y)/(err_frac_deut_uptake.x + err_frac_deut_uptake.y)),
             tmp_uptake_diff = ((deut_uptake.x - deut_uptake.y)/(err_deut_uptake.x + err_deut_uptake.y))) %>%
      arrange(Exposure) %>%
      group_by(Protein, MaxUptake, Sequence, Start, End) %>%
      summarize(frac_uptake_diff = sum(tmp_frac_uptake_diff, na.rm = T),
                uptake_diff = sum(tmp_uptake_diff, na.rm = T))



  return(res)

}


#' @importFrom ggplot2 theme_gray scale_shape_manual
#'
#' @export plot_uc

plot_uc <- function(fit_dat_1,
                    fit_dat_2,
                    fit_values_1,
                    fit_values_2,
                    fractional = F,
                    interactive = F){

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

  v_state_1 <- unique(fit_dat_1[["State"]])
  v_state_2 <- unique(fit_dat_2[["State"]])

  if (fractional) {

    if(interactive){
      sel_points_1 <- geom_point_interactive(data = fit_dat_1,
                                             aes(x = Exposure, y = frac_deut_uptake, shape = "1",
                                                 tooltip = glue("Sequence: {Sequence}
                                                                State: {State}
                                                                Exposure: {Exposure} min
                                                                FDU = {formatC(frac_deut_uptake, 2)} %
                                                                Err FDU = {formatC(err_frac_deut_uptake, 2)} %
                                                                ")),
                                             size = 3)
      sel_points_2 <- geom_point_interactive(data = fit_dat_2,
                                             aes(x = Exposure, y = frac_deut_uptake, shape = "2",
                                                 tooltip = glue("Sequence: {Sequence}
                                                                State: {State}
                                                                Exposure: {Exposure} min
                                                                FDU = {formatC(frac_deut_uptake, 2)} %
                                                                Err FDU = {formatC(err_frac_deut_uptake, 2)} %
                                                                ")),
                                             size = 3)
    } else {
      sel_points_1 <- geom_point(data = fit_dat_1, aes(x = Exposure, y = frac_deut_uptake, shape = "1"),  size = 3)
      sel_points_2 <- geom_point(data = fit_dat_2, aes(x = Exposure, y = frac_deut_uptake, shape = "2"), size = 3)
    }

    plt <- ggplot() +
      sel_points_1 +
      geom_linerange(data = fit_dat_1, aes(x = Exposure, ymin = frac_deut_uptake - err_frac_deut_uptake, ymax = frac_deut_uptake + err_frac_deut_uptake)) +
      sel_points_2+
      geom_linerange(data = fit_dat_2, aes(x = Exposure, ymin = frac_deut_uptake - err_frac_deut_uptake, ymax = frac_deut_uptake + err_frac_deut_uptake)) +
      scale_x_log10() +
      ylim(c(0, 1.25)) +
      theme_gray(base_size = 15) +
      scale_shape_manual(name = "State",
                         labels = c(v_state_1, v_state_2),
                         values = c(1, 2)) +
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

    if(interactive){
      sel_points_1 <- geom_point_interactive(data = fit_dat_1, aes(x = Exposure, y = deut_uptake, shape = "1",
                                                                   tooltip = glue("Sequence: {Sequence}
                                                                                  State: {State}
                                                                                  Exposure: {Exposure} min
                                                                                  FDU = {formatC(deut_uptake, 2)} Da
                                                                                  Err FDU = {formatC(err_deut_uptake, 2)} Da
                                                                                  ")))
      sel_points_2 <- geom_point_interactive(data = fit_dat_2, aes(x = Exposure, y = deut_uptake, shape = "2",
                                                                   tooltip = glue("Sequence: {Sequence}
                                                                                  State: {State}
                                                                                  Exposure: {Exposure} min
                                                                                  FDU = {formatC(deut_uptake, 2)} Da
                                                                                  Err FDU = {formatC(err_deut_uptake, 2)} Da
                                                                                  ")))

    } else {
      sel_points_1 <- geom_point(data = fit_dat_1, aes(x = Exposure, y = deut_uptake, shape = "1"))
      sel_points_2 <- geom_point(data = fit_dat_2, aes(x = Exposure, y = deut_uptake, shape = "2"))
    }

    plt <- ggplot() +
      sel_points_1 +
      geom_linerange(data = fit_dat_1, aes(x = Exposure, ymin = deut_uptake - err_deut_uptake, ymax = deut_uptake + err_deut_uptake)) +
      sel_points_2 +
      geom_linerange(data = fit_dat_2, aes(x = Exposure, ymin = deut_uptake - err_deut_uptake, ymax = deut_uptake + err_deut_uptake)) +
      scale_x_log10() +
      theme_gray(base_size = 15) +
      scale_shape_manual(name = "State",
                         labels = c(v_state_1, v_state_2),
                         values = c(1, 2)) +
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

  girafe(ggobj = plt,
         width_svg = 10,
         height_svg = 4)

}
