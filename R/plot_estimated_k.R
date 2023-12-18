#'
#'
#' @export

plot_estimated_k <- function(hires_params,
                             interactive = F){

  if(interactive){
    sel_points <- geom_point_interactive(aes(x = position, y = k_est,
                                             tooltip = glue("Position: {position}
                                                            Estimated k: {formatC(k_est, 2)}")))
  } else {
    sel_points <- geom_point(aes(x = position, y = k_est))
  }

  plt <- ggplot(hires_params) +
    sel_points +
    labs(x = "Position",
         y = "Estimated k",
         title = "Estimated k from fit values") +
    theme_bw(base_size = 18) +
    coord_cartesian(x = c(0, max(hires_params[["position"]])+1))

  girafe(ggobj = plt,
         width_svg = 10,
         height_svg = 4)
}
