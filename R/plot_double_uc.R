## wrapper for GUI
## for previous plot function for regular uc and fitted uc

#' @export

plot_double_uc <- function(fit_dat,
                           fit_values,
                           replicate = F,
                           fractional = T){

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
