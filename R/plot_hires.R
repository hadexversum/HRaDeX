#' Plots high resolution classification plot
#'
#' @importFrom ggplot2 coord_cartesian
#' @importFrom ggiraph geom_rect_interactive girafe girafe_options opts_tooltip
#' @importFrom glue glue
#'
#' @param hires_params data.frame with hires results, calculate using
#' calculate_hires.
#' @param interactive ...
#'
#' @description Plot the result of color classification analysis in
#' high resolution in a linear form.
#'
#' @return a girafe object.
#'
#' @seealso calculate_hires
#'
#' @examples
#' kin_dat <- prepare_kin_dat(alpha_dat)
#' fit_k_params <- get_example_fit_k_params()
#' control <- get_example_control()
#' fit_values <- create_fit_dataset(kin_dat, control, fit_k_params)
#' hires_params <- calculate_hires(fit_values)
#' plot_hires(hires_params)
#'
#' @export

plot_hires <- function(hires_params,
                       interactive = FALSE){


  if(interactive){

    # TODO: scale by n
    hires_params_sc <- mutate(hires_params,
                           n = n_1 + n_2 + n_3,
                           n_1 = formatC(n_1, 2),
                           n_2 = formatC(n_2, 2),
                           n_3 = formatC(n_3, 2))

    selected_rect <-  geom_rect_interactive(data = hires_params_sc,
                                            aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1,
                              tooltip = glue("Position: {position},
                                              Residue: {aa},
                                             n_1 = {n_1},
                                             n_2 = {n_2},
                                             n_3 = {n_3}")),
                          fill = hires_params_sc[["color"]])

    selected_rect_na <- geom_rect_interactive(data = subset(hires_params_sc, is.na(color)),
                                            aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1,
                                                tooltip = glue("Position: {position},
                                                                Residue: {aa},
                                                               No available data")),
                                            fill = "#B8B8B8")


  } else {

    selected_rect <- geom_rect(data = hires_params, aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1),
                               fill = hires_params[["color"]])

    selected_rect_na <- geom_rect(data = subset(hires_params, is.na(n_1)),
                                  aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1),
                                  fill = "#B8B8B8")

  }

    hires_plot <- ggplot() +
      selected_rect +
        selected_rect_na +
      labs(title = "Assigned class on sequence",
           x = "Position",
           y = "") +
      theme_bw(base_size = 18) +
      theme(axis.ticks.y = element_blank(),
            axis.text.y = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank()) +
      coord_cartesian(x = c(0, max(hires_params[["position"]])+1))

  girafe(ggobj = hires_plot,
         width_svg = 10,
         height_svg = 4)

}



#'
#'
#'
#'
#'
#'
#'
#' @export

create_monotony <- function(hires_params,
                            fractional = TRUE){

  lapply(c(2:nrow(hires_params)), function(i){

    color_1 = hires_params[i-1, "color"]
    color_2 = hires_params[i, "color"]

    dist = calculate_color_distance(color_1, color_2)[[1]]

    if(is.na(color_1)) dist = NA
    if(is.na(color_2)) dist = NA

    data.frame(position = i,
               dist = dist)
    }) %>% bind_rows()

}

#'
#'
#'
#' @export
plot_monotony <- function(mono_dat){

  ggplot(mono_dat, aes(x = position, y = dist)) +
    geom_point() +
    geom_line()

}

#'
#'
#'
#'
#' @export
plot_hires_components <- function(hires_params,
                                  fractional = FALSE,
                                  interactive = FALSE){

  protein_length = max(hires_params[["position"]])

  edgy_classes <- hires_params %>%
    filter(!is.na(class_name))

  no_coverage <- hires_params %>%
    filter(is.na(class_name), is.na(n_1))

  color_grey = rep("#B8B8B8", nrow(no_coverage))

  hires_components <- hires_params %>%
      filter(is.na(class_name), !is.na(n_1)) %>%
      mutate(n = n_1 + n_2 + n_3,
             n_1_alpha = case_when(
               n_1/n > 1 ~ 1,
               T ~ n_1/n),
             n_2_alpha = case_when(
               n_2/n > 1 ~ 1,
               T ~ n_2/n),
             n_3_alpha = case_when(
               n_3/n > 1 ~ 1,
               T ~ n_3/n))

    color_red = rep("#FF0000", nrow(hires_components))
    color_green = rep("#00FF00", nrow(hires_components))
    color_blue = rep("#0000FF", nrow(hires_components))


  if (interactive){

    rect_red <- geom_rect_interactive(data = hires_components,
                                      aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1,
                                          tooltip = glue("Position: {position},
                                                          n_1 = {round(n_1_alpha, 2)}")),
                                      alpha = hires_components[["n_1_alpha"]],
                                      fill = color_red)
    rect_green <- geom_rect_interactive(data = hires_components,
                                        aes(xmin = position, xmax = position + 1, ymin = 1, ymax = 2,
                                            tooltip = glue("Position: {position},
                                                          n_2 = {round(n_2_alpha, 2)}")),
                            alpha = hires_components[["n_2_alpha"]],
                            fill = color_green)
    rect_blue <- geom_rect_interactive(data = hires_components,
                                       aes(xmin = position, xmax = position + 1, ymin = 2, ymax = 3,
                                           tooltip = glue("Position: {position},
                                                          n_3 = {round(n_3_alpha, 2)}")),
                                       alpha = hires_components[["n_3_alpha"]],
                                       fill = color_blue)
    rect_edge <- geom_rect_interactive(data = edgy_classes,
                                       aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 3,
                                           tooltip = glue("Position: {position},
                                                          class: {class_name}")),
                                       fill = edgy_classes[["color"]])
    rect_na <- geom_rect_interactive(data = no_coverage,
                                     aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 3,
                                         tooltip = glue("Position: {position},
                                                         no available data")),
                                     fill = color_grey)

  } else {

    rect_red <- geom_rect(data = hires_components,
                          aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1),
                          alpha = hires_components[["n_1_alpha"]],
                          fill = color_red)
    rect_green <- geom_rect(data = hires_components,
                            aes(xmin = position, xmax = position + 1, ymin = 1, ymax = 2),
                            alpha = hires_components[["n_2_alpha"]],
                            fill = color_green)
    rect_blue <- geom_rect(data = hires_components,
                           aes(xmin = position, xmax = position + 1, ymin = 2, ymax = 3),
                           alpha = hires_components[["n_3_alpha"]],
                           fill = color_blue)
    rect_edge <- geom_rect(data = edgy_classes,
                           aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 3),
                           fill = edgy_classes[["color"]])
    rect_na <- geom_rect(data = no_coverage,
                         aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 3),
                         fill = color_grey)

  }

  components_plot <- ggplot() +
    rect_red +
    rect_green +
    rect_blue +
    rect_edge +
    rect_na +
    theme_bw(base_size = 18) +
    labs(title = "Assigned class components on sequence",
         x = "Position",
         y = "") +
    theme(axis.ticks.y = element_blank(),
          axis.text.y = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank()) +
    coord_cartesian(x = c(0, protein_length+1))

  girafe(ggobj = components_plot,
         width_svg = 10,
         height_svg = 4)
}


