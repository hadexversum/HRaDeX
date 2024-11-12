#' Plots two uc plots side by side
#'
#' @param fit_dat uptake data for selected peptide.
#' @param fit_values fit values for selected peptide.
#' @param replicate ...
#' @param fractional ...
#'
#' @description This function plots two plots side by side for a peptide. The left
#' plot is uc plot with fitted model with its components. The right plot is singular
#' uc without logarithmic axis for the comparison of shape.
#' Basically, this function calls for other functions and plots the results side by side.
#' This function is aimed for the summary `Plots` panel in HRaDeXGUI and does not have
#' an interactive mode.
#'
#' @return a ggplot object.
#'
#' @seealso plot_fitted_uc plot_singular_uc
#'
#' @examples
#' kin_dat <- prepare_kin_dat(alpha_dat)
#' fit_dat <- kin_dat[kin_dat[["ID"]]==1, ]
#' fit_k_params <- get_example_fit_k_params()
#' control <- get_example_control()
#' fit_values_all <- create_fit_dataset(kin_dat, fit_k_params, control)
#' fit_values <- fit_values_all[fit_values_all[["ID"]]==1, ]
#' plot_double_uc(fit_dat, fit_values)
#'
#' @export

plot_double_uc <- function(fit_dat,
                           fit_values,
                           replicate = FALSE,
                           fractional = TRUE){

   plot_left <- plot_fitted_uc(fit_dat = fit_dat,
                               fit_values = fit_values,
                               replicate = replicate,
                               fractional = fractional)

   plot_right <- plot_singular_uc(fit_dat = fit_dat,
                                  fit_values = fit_values,
                                  replicate = replicate,
                                  fractional = fractional)

  return(grid.arrange(plot_left, plot_right, nrow = 1, widths = c(3, 2)))
}
