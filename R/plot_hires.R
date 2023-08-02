#'
#' @importFrom ggplot2 coord_cartesian
#'
#' @export

plot_hires <- function(hires_params){

  ggplot(hires_params, aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1)) +
    geom_rect(fill = hires_params[["color"]]) +
    labs(title = "Assigned class on sequence",
         x = "Position",
         y = "") +
    theme_bw() +
    theme(axis.ticks.y = element_blank(),
          axis.text.y = element_blank()) +
    coord_cartesian(x = c(0, max(hires_params[["position"]])+1))

}

#'
#'
#'
#'
#' @export
plot_hires_components <- function(hires_params,
                                   fractional = F){

  hires_tmp <- hires_params %>%
    filter(!is.na(n_1)) %>%
    mutate(n = n_1 + n_2 + n_3) %>%
    mutate(n_1_tmp = n_1 / n,
           n_2_tmp = n_2 / n,
           n_3_tmp = n_3 / n) %>%
    filter(is.na(class_name)) %>%
    mutate(n_1_tmp_color = rgb(n_1_tmp, 0, 0),
           n_2_tmp_color = rgb(0, n_2_tmp, 0),
           n_3_tmp_color = rgb(0, 0, n_3_tmp))

  class_tmp <- hires_params %>%
    filter(!is.na(class_name))

  ggplot() +
    geom_rect(data = hires_tmp, aes(xmin = position, xmax = position + 1,
                                    ymin = 0, ymax = 1), fill = hires_tmp[["n_1_tmp_color"]]) +
    geom_rect(data = hires_tmp, aes(xmin = position, xmax = position + 1,
                                    ymin = 1, ymax = 2), fill = hires_tmp[["n_2_tmp_color"]]) +
    geom_rect(data = hires_tmp, aes(xmin = position, xmax = position + 1,
                                    ymin = 2, ymax = 3), fill = hires_tmp[["n_3_tmp_color"]]) +
    geom_rect(data = class_tmp, aes(xmin = position, xmax = position + 1,
                                    ymin = 0, ymax = 3), fill = class_tmp[["color"]]) +
    theme_bw() +
    labs(title = "Assigned class components on sequence",
         x = "Position",
         y = "") +
    theme(axis.ticks.y = element_blank(),
          axis.text.y = element_blank()) +
    coord_cartesian(x = c(0, max(hires_params[["position"]])+1))


}
