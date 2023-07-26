#'
#' @importFrom ggplot2 coord_cartesian
#'
#' @export

plot_hires <- function(hires_params){

  ggplot(hires_params, aes(xmin = position, xmax = position + 1, ymin = 0, ymax = 1)) +
    geom_rect(fill = hires_params[["color"]]) +
    labs(title = "class components on sequence",
         x = "Position",
         y = "") +
    theme_bw() +
    theme(axis.ticks.y = element_blank(),
          axis.text.y = element_blank()) +
    coord_cartesian(x = c(0, max(hires_params[["position"]])+1))

}
