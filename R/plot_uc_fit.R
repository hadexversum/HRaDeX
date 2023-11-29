#' @importFrom gridExtra grid.arrange
#' @importFrom ggplot2 stat_function geom_line annotate theme_bw geom_errorbar geom_linerange
#' @importFrom dplyr summarize group_by
#' @importFrom ggiraph geom_point_interactive geom_line_interactive
#'
#' @export
plot_fitted_uc <- function(fit_dat,
                           fit_values,
                           replicate = F,
                           fractional = T,
                           interactive = F){

  n_1 <- fit_values[["n_1"]]
  k_1 <- fit_values[["k_1"]]
  n_2 <- fit_values[["n_2"]]
  k_2 <- fit_values[["k_2"]]
  n_3 <- fit_values[["n_3"]]
  k_3 <- fit_values[["k_3"]]

  if(fractional){

    if(interactive){

      sel_points <- geom_point(aes(x = Exposure, y = frac_deut_uptake,
                                   tooltip = glue("Exposure: {Exposure}
                                                  FDU = {formatC(frac_deut_uptake, 2)}
                                                  Err FDU = {formatC(err_frac_deut_uptake, 2)}")),
                               shape = 1, size = 3)

    } else {
      sel_points <- geom_point(aes(x = Exposure, y = frac_deut_uptake), shape = 1, size = 3)
    }

    uc_fit_plot_log_components <- ggplot(data = fit_dat) +
      sel_points +
      labs(title = paste0(plot_title, " scaled in log with fit components"),
           y = "Fractional DU [%]",
           x = "Exposure [min]") +
      stat_function(fun=function(x){n_1*(1-exp(-k_1*x)) + n_2*(1-exp(-k_2*x)) + n_3*(1-exp(-k_3*x))}) +
      ylim(c(0, 1.25)) +
      theme_gray(base_size = 18) +
      stat_function(fun = function(x){n_1*(1-exp(-k_1*x))}, color = "red") +
      stat_function(fun = function(x){n_2*(1-exp(-k_2*x))}, color = "green") +
      stat_function(fun = function(x){n_3*(1-exp(-k_3*x))}, color = "blue") +
      geom_hline(yintercept = 1, linetype = 2, alpha = 0.3) +
      scale_x_log10(limits = c(NA, 10000))

    if(!replicate){
      uc_fit_plot_log_components <- uc_fit_plot_log_components +
        geom_linerange(data = fit_dat, aes(x = Exposure, ymin = frac_deut_uptake - err_frac_deut_uptake, ymax = frac_deut_uptake + err_frac_deut_uptake))
    }

  } else {

    max_uptake <- fit_dat[["MaxUptake"]][1]

    uc_fit_plot_log_components <- ggplot() +
      geom_point(data = fit_dat, aes(x = Exposure, y = deut_uptake), shape = 1, size = 3) +
      labs(title = paste0(plot_title, " scaled in log with fit components"),
           y = "Fractional DU [Da]",
           x = "Exposure [min]") +
      stat_function(fun=function(x){n_1*(1-exp(-k_1*x)) + n_2*(1-exp(-k_2*x)) + n_3*(1-exp(-k_3*x))}) +
      ylim(c(0, max_uptake + 1)) +
      theme_gray(base_size = 18) +
      stat_function(fun = function(x){n_1*(1-exp(-k_1*x))}, color = "red") +
      stat_function(fun = function(x){n_2*(1-exp(-k_2*x))}, color = "green") +
      stat_function(fun = function(x){n_3*(1-exp(-k_3*x))}, color = "blue") +
      geom_hline(yintercept = max_uptake, linetype = 2, alpha = 0.3) +
      scale_x_log10(limits = c(NA, 10000))

    if(!replicate){
      uc_fit_plot_log_components <- uc_fit_plot_log_components +
        geom_linerange(data = fit_dat, aes(x = Exposure, ymin = deut_uptake - err_deut_uptake, ymax = deut_uptake + err_deut_uptake))
    }

  }

    return(grid.arrange(uc_fit_plot_log_components, uc_plot, nrow = 1, widths = c(3, 2)))

}
