#' @export

plot_k_distance <- function(two_state_dataset,
                            interactive = F){

  protein_length <- max(two_state_dataset[["position"]])

  if(interactive){
    sel_points <- geom_point_interactive(aes(x = position, y = k_diff,
                                             tooltip = glue("Position: {position}
                                                            K diff  = {formatC(k_diff, 2)}")))
  } else {
    sel_points <- geom_point(aes(x = position, y = k_diff))
  }

  plt <- ggplot(two_state_dataset) +
    sel_points +
    labs(title = "Distance between estimated k",
         x = "Position",
         y = "K difference") +
    coord_cartesian(x = c(0, protein_length+1)) +
    theme_bw(base_size = 18)

  girafe(ggobj = plt,
         width_svg = 10,
         height_svg = 4)
}

#' @export

plot_uc_real_dist <- function(uc_distance_dataset,
                              squared = F,
                              fractional = T,
                              interactive = F){

  y_axis_label <- ""

  protein_length <- max(uc_distance_dataset[["End"]])

  if(fractional){

    y_axis_label <- "Frac uptake diff [%]"

    if(squared) {
      uc_distance_dataset <- mutate(uc_distance_dataset,
                                    frac_uptake_dist = frac_uptake_dist^2)

      y_axis_label <- "Frac uptake diff ^2 [%]"
    }

    if(interactive){
      sel_segment <- geom_segment_interactive(aes(x = Start, xend = End, y = frac_uptake_dist, yend = frac_uptake_dist,
                                                  tooltip = glue("Sequence: {Sequence}
                                                                Position: {Start}-{End}
                                                               Diff = {formatC(frac_uptake_dist, 2)}")))
    } else {
      sel_segment <- geom_segment(aes(x = Start, xend = End, y = frac_uptake_dist, yend = frac_uptake_dist))
    }

  } else {

    y_axis_label <- "Uptake diff [Da]"

    if(squared) {
      uc_distance_dataset <- mutate(uc_distance_dataset,
                                    uptake_dist = uptake_dist^2)
      y_axis_label <- "Uptake diff ^2 [Da]"
    }

    if(interactive){
      sel_segment <- geom_segment_interactive(aes(x = Start, xend = End, y = uptake_dist, yend = uptake_dist,
                                                  tooltip = glue("Sequence: {Sequence}
                                                                Position: {Start}-{End}
                                                               Diff = {formatC(uptake_dist, 2)}")))
    } else {
      sel_segment <- geom_segment(aes(x = Start, xend = End, y = uptake_dist, yend = uptake_dist))
    }


  }

  plt <- ggplot(uc_distance_dataset) +
    sel_segment +
    labs(title = "Distances between uptake points",
         x = "Position",
         y = y_axis_label) +
    coord_cartesian(x = c(0, protein_length+1)) +
    theme_bw(base_size = 18)

  girafe(ggobj = plt,
         width_svg = 10,
         height_svg = 4)

}

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
    labs(title = paste0("Classification for states: ", state_1, "(down) and ", state_2, " (up)"),
         x = "Position",
         y = "") +
    theme_bw(base_size = 18) +
    # scale_y_continuous(breaks = c(0.5, 1.5), labels = c(state_1, state_2)) +
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
    labs(title = "Distance between populations",
         x = "Position",
         y = "Distance") +
    coord_cartesian(x = c(0, protein_length+1)) +
    theme_bw(base_size = 18)

  girafe(ggobj = plt,
         width_svg = 10,
         height_svg = 4)
}


#' @importFrom ggplot2 geom_segment
#' @importFrom ggiraph geom_segment_interactive
#'
#' @export plot_uc_distance

plot_uc_distance <- function(uc_distance_dataset,
                             squared = F,
                             fractional = T,
                             interactive = F){

  protein_length <- max(uc_distance_dataset[["End"]])

  y_axis_label <- ""
  plot_title <- ""

  if (fractional){

    y_axis_label <- "Abs frac diff DU [%]"
    plot_title <- "Fractional uptake difference"

    if(squared){
      uc_distance_dataset <- mutate(uc_distance_dataset,
                                    frac_uptake_diff = frac_uptake_diff^2)
      y_axis_label <- "Abs frac diff DU ^2 [%]"
    }

    if(interactive){
      sel_segment <- geom_segment_interactive(aes(x = Start, xend = End, y = frac_uptake_diff, yend = frac_uptake_diff,
                                                  tooltip = glue("Sequence: {Sequence}
                                                     Position: {Start}-{End}
                                                     Difference = {formatC(frac_uptake_diff, 2)}")))
    } else {
      sel_segment <- geom_segment(aes(x = Start, xend = End, y = frac_uptake_diff, yend = frac_uptake_diff))
    }

  } else {

    y_axis_label <- "Abs diff DU [Da]"
    plot_title <- "Uptake difference"

    if(squared){
      uc_distance_dataset <- mutate(uc_distance_dataset,
                                    uptake_diff = uptake_diff^2)
      y_axis_label <- "Abs diff DU ^2 [%]"
    }


    if(interactive){
      sel_segment <- geom_segment_interactive(aes(x = Start, xend = End, y = uptake_diff, yend = uptake_diff,
                                                  tooltip = glue("Sequence: {Sequence}
                                                     Position: {Start}-{End}
                                                     Difference = {formatC(uptake_diff, 2)}")))
    } else {
      sel_segment <- geom_segment(aes(x = Start, xend = End, y = uptake_diff, yend = uptake_diff))
    }


  }

  plt <- ggplot(uc_distance_dataset) +
    sel_segment +
    labs(title = plot_title,
         y = y_axis_label,
         x = "Position") +
    theme_bw(base_size = 18) +

    coord_cartesian(x = c(0, protein_length+1))

  girafe(ggobj = plt,
         width_svg = 10,
         height_svg = 4)

}

#' @importFrom ggplot2 theme_gray scale_shape_manual
#'
#' @description This function is intended for visualisation of fit results of two biological states in comparative mode, in compaHRaDeX.
#' @export plot_uc

plot_uc <- function(fit_dat_1,
                    fit_dat_2,
                    fit_values_1,
                    fit_values_2,
                    fractional = F,
                    interactive = F){

  v_sequence = paste(unique(na.omit(c(fit_dat_1[["Sequence"]][1], fit_dat_2[["Sequence"]][1]))), collapse = "/")
  v_start = unique(na.omit(c(fit_dat_1[["Start"]][1], fit_dat_2[["Start"]][1])))
  v_end = unique(na.omit(c(fit_dat_1[["End"]][1], fit_dat_2[["End"]][1])))

  fit_params_1 <- fit_values_1 %>%
    filter( # sequence %in% v_sequence,
           start == v_start,
           end == v_end)

  fit_params_2 <- fit_values_2 %>%
    filter( # sequence %in% v_sequence,
           start == v_start,
           end == v_end)

  v_state_1 <- "absent"
  v_state_2 <- "absent"

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

    plt <- ggplot()

    if(nrow(fit_dat_1) > 1) {

      v_state_1 <- unique(fit_dat_1[["State"]])

      plt <- plt +
        sel_points_1 +
        geom_linerange(data = fit_dat_1, aes(x = Exposure,
                                             ymin = frac_deut_uptake - err_frac_deut_uptake,
                                             ymax = frac_deut_uptake + err_frac_deut_uptake)) +
        stat_function(fun = function(x){fit_params_1[["n_1"]]*(1-exp(-fit_params_1[["k_1"]]*x)) +
            fit_params_1[["n_2"]]*(1-exp(-fit_params_1[["k_2"]]*x)) + fit_params_1[["n_3"]]*(1-exp(-fit_params_1[["k_3"]]*x))}, linetype = "dashed") +
        stat_function(fun = function(x){fit_params_1[["n_1"]]*(1-exp(-fit_params_1[["k_1"]]*x))}, color = "red", linetype = "dashed") +
        stat_function(fun = function(x){fit_params_1[["n_2"]]*(1-exp(-fit_params_1[["k_2"]]*x))}, color = "green", linetype = "dashed") +
        stat_function(fun = function(x){fit_params_1[["n_3"]]*(1-exp(-fit_params_1[["k_3"]]*x))}, color = "blue", linetype = "dashed") +
        scale_shape_manual(name = "State",
                           labels = c(v_state_1),
                           values = c(1))


    }

    if(nrow(fit_dat_2) > 1){

      v_state_2 <- unique(fit_dat_2[["State"]])

      plt <- plt +
        sel_points_2+
        geom_linerange(data = fit_dat_2, aes(x = Exposure,
                                             ymin = frac_deut_uptake - err_frac_deut_uptake,
                                             ymax = frac_deut_uptake + err_frac_deut_uptake)) +
        stat_function(fun = function(x){fit_params_2[["n_1"]]*(1-exp(-fit_params_2[["k_1"]]*x)) + fit_params_2[["n_2"]]*(1-exp(-fit_params_2[["k_2"]]*x)) + fit_params_2[["n_3"]]*(1-exp(-fit_params_2[["k_3"]]*x))}, linetype = "solid") +
        stat_function(fun = function(x){fit_params_2[["n_1"]]*(1-exp(-fit_params_2[["k_1"]]*x))}, color = "red", linetype = "solid") +
        stat_function(fun = function(x){fit_params_2[["n_2"]]*(1-exp(-fit_params_2[["k_2"]]*x))}, color = "green", linetype = "solid") +
        stat_function(fun = function(x){fit_params_2[["n_3"]]*(1-exp(-fit_params_2[["k_3"]]*x))}, color = "blue", linetype = "solid") +
        scale_shape_manual(name = "State",
                           labels = c(v_state_2),
                           values = c(2))


    }

    if(nrow(fit_dat_1) > 1 & nrow(fit_dat_2) > 1 ){

      plt <- plt +
        scale_shape_manual(name = "State",
                           labels = c(v_state_1, v_state_2),
                           values = c(1, 2))
    }

    plt <- plt +
      scale_x_log10() +
      ylim(c(0, 1.25)) +
      theme_gray(base_size = 15) +
      theme(legend.position = "bottom") +
      labs(x = "Exposure [min]",
           y = "Fractional DU [%]",
           title = paste0("Uptake curve for peptide ", v_sequence, " (", v_start, "-", v_end, ")"))

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

