#' Plots estimated k
#'
#' @param hires_params data.frame with hires results, calculate using
#' calculate_hires.
#' @param interactive ...
#'
#' @description Plots the estimated k for residues. Estimated k for each are calculated
#' from classification results, treating the n (population) as the probability of getting
#' corresponding rate of exchange. The aggregation of results is described in the vignette.
#'
#' @return a girafe object.
#'
#' @seealso calculate_hires
#'
#' @examples
#' kin_dat <- prepare_kin_dat(alpha_dat)
#' fit_k_params <- get_example_fit_k_params()
#' control <- get_example_control()
#' fit_values <- create_fit_dataset(kin_dat, fit_k_params, control)
#' hires_params <- calculate_hires(fit_values)
#' plot_estimated_k(hires_params)
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
