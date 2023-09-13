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
    labs(title = "Assigned class on sequence",
         x = "Position",
         y = "") +
    theme_bw() +
    scale_y_continuous(breaks = c(0.5, 1.5), labels = c(state_1, state_2)) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank()) +
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

  two_state_dataset %>%
    filter(!is.na(color.x)) %>%
    filter(!is.na(color.y)) %>%
  ggplot() +
    geom_point(aes(x = position, y = dist)) +
    labs(title = "Distance between assigned colors",
         x = "Position",
         y = "Distance")

}
