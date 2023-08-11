#'
#' @importFrom ggplot2 coord_cartesian
#'
#' @export

plot_hires <- function(hires_params){

  ggplot(hires_params) +
    geom_rect(aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1), fill = hires_params[["color"]]) +
    geom_rect(data = subset(hires_params, is.na(n_1)),
              aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1), fill = "#B8B8B8") +
    labs(title = "Assigned class on sequence",
         x = "Position",
         y = "") +
    theme_bw() +
    theme(axis.ticks.y = element_blank(),
          axis.text.y = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank()) +
    coord_cartesian(x = c(0, max(hires_params[["position"]])+1))

}

#'
#'
#'
#'
#' @export
plot_hires_components <- function(hires_params,
                                  white = T,
                                  fractional = F){

  protein_length = max(hires_params[["position"]])

  edgy_classes <- hires_params %>%
    filter(!is.na(class_name))

  no_coverage <- hires_params %>%
    filter(is.na(class_name), is.na(n_1))

  color_grey = rep("#B8B8B8", nrow(no_coverage))

  if(white){

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

    ggplot() +
      geom_rect(data = hires_components, aes(xmin = position, xmax = position + 1,
                                             ymin = 0, ymax = 1), alpha = hires_components[["n_1_alpha"]], fill = color_red) +
      geom_rect(data = hires_components, aes(xmin = position, xmax = position + 1,
                                             ymin = 1, ymax = 2), alpha = hires_components[["n_2_alpha"]], fill = color_green) +
      geom_rect(data = hires_components, aes(xmin = position, xmax = position + 1,
                                             ymin = 2, ymax = 3), alpha = hires_components[["n_3_alpha"]], fill = color_blue) +
      geom_rect(data = edgy_classes, aes(xmin = position, xmax = position + 1,
                                         ymin = 0, ymax = 3), fill = edgy_classes[["color"]]) +
      geom_rect(data = no_coverage, aes(xmin = position, xmax = position + 1,
                                        ymin = 0, ymax = 3), fill = color_grey) +
      theme_bw() +
      labs(title = "Assigned class components on sequence",
           x = "Position",
           y = "") +
      theme(axis.ticks.y = element_blank(),
            axis.text.y = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank()) +
      coord_cartesian(x = c(0, protein_length+1))

  } else {

    hires_components <- hires_params %>%
      filter(is.na(class_name), !is.na(n_1)) %>%
      mutate(n = n_1 + n_2 + n_3,
             n_1_color = rgb(n_1/n, 0, 0),
             n_2_color = rgb(0, n_2/n, 0),
             n_3_color = rgb(0, 0, n_3/n))

    ggplot() +
      geom_rect(data = hires_components, aes(xmin = position, xmax = position + 1,
                                             ymin = 0, ymax = 1), fill = hires_components[["n_1_color"]]) +
      geom_rect(data = hires_components, aes(xmin = position, xmax = position + 1,
                                             ymin = 1, ymax = 2), fill = hires_components[["n_2_color"]]) +
      geom_rect(data = hires_components, aes(xmin = position, xmax = position + 1,
                                             ymin = 2, ymax = 3), fill = hires_components[["n_3_color"]]) +
      geom_rect(data = edgy_classes, aes(xmin = position, xmax = position + 1,
                                         ymin = 0, ymax = 3), fill = edgy_classes[["color"]]) +
      geom_rect(data = no_coverage, aes(xmin = position, xmax = position + 1,
                                        ymin = 0, ymax = 3), fill = color_grey) +
      theme_bw() +
      labs(title = "Assigned class components on sequence",
           x = "Position",
           y = "") +
      theme(axis.ticks.y = element_blank(),
            axis.text.y = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank()) +
      coord_cartesian(x = c(0, protein_length+1))


  }


}
