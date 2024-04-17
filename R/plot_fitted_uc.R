#' Plots uptake curve with fit components
#'
#' @importFrom gridExtra grid.arrange
#' @importFrom ggplot2 stat_function geom_line annotate theme_bw geom_errorbar geom_linerange
#' @importFrom dplyr summarize group_by
#' @importFrom ggiraph geom_point_interactive geom_line_interactive
#'
#' @param fit_dat uptake data for selected peptide.
#' @param fit_values fit values for selected peptide.
#' @param replicate indicator if the replicate data is plotted, or aggregated.
#' @param fractional ...
#' @param interactive ...
#'
#' @description FUnction plots the uptake values for one, selected peptide. Alongside the
#' fitted model is plotted in black, with its components (fast - red, medium - green,
#' slow - blue). In case when peptide is classified as a edge case, the linear model is used.
#'
#' @return a ggplot object. Need converstion to girafe for interactivity.
#'
#' @seealso plot_lm
#'
#' @examples
#' HaDeX::read_hdx(...)
#' kin_dat <- prepare_kin_dat(dat, state = state_1)
#' fit_dat <- kin_dat[kin_dat[["id"]]==1, ]
#' fit_k_params <- get_example_fit_k_params()
#' control <- get_example_control()
#' fit_values_all <- create_fit_dataset(kin_dat, control, fit_k_params)
#' fit_values <- fit_values_all[fit_values_all[["id"]]==1, ]
#' plot_fitted_uc(fit_dat, fit_values)
#'
#' @export
plot_fitted_uc <- function(fit_dat,
                           fit_values,
                           replicate = F,
                           fractional = T,
                           interactive = F){

  plot_title <- paste0(fit_values[["sequence"]], " (", fit_values[["start"]], "-", fit_values[["end"]], ") ")

  n_1 <- fit_values[["n_1"]]
  k_1 <- fit_values[["k_1"]]
  n_2 <- fit_values[["n_2"]]
  k_2 <- fit_values[["k_2"]]
  n_3 <- fit_values[["n_3"]]
  k_3 <- fit_values[["k_3"]]


  if(!is.na(fit_values[["class_name"]])) {

    final_plot <-  plot_lm(fit_dat, class_name = unique(fit_values[["class_name"]]), interactive = interactive)
  }

  if(fractional){

    if(interactive){

      sel_points <- geom_point_interactive(aes(x = Exposure, y = frac_deut_uptake,
                                   tooltip = glue("Exposure: {Exposure}
                                                  FDU = {formatC(100*frac_deut_uptake, 2)} %
                                                  Err FDU = {formatC(100*err_frac_deut_uptake, 2)} %")),
                               shape = 1, size = 3)

    } else {
      sel_points <- geom_point(aes(x = Exposure, y = frac_deut_uptake), shape = 1, size = 3)
    }

    final_plot <- ggplot(data = fit_dat) +
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
      final_plot <- final_plot +
        geom_linerange(data = fit_dat, aes(x = Exposure, ymin = frac_deut_uptake - err_frac_deut_uptake, ymax = frac_deut_uptake + err_frac_deut_uptake))
    }

  } else {

    if(interactive){

      sel_points <- geom_point_interactive(data = fit_dat,
                                           aes(x = Exposure, y = deut_uptake,
                                               tooltip = glue("Exposure: {Exposure}
                                                  FDU = {formatC(deut_uptake, 2)} Da
                                                  Err FDU = {formatC(deut_uptake, 2)} Da")),
                                           shape = 1, size = 3)
    } else {
      sel_points <- geom_point(data = fit_dat, aes(x = Exposure, y = deut_uptake), shape = 1, size = 3)
    }

    max_uptake <- fit_dat[["MaxUptake"]][1]

    final_plot <- ggplot() +
      sel_points +
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
      final_plot <- final_plot +
        geom_linerange(data = fit_dat, aes(x = Exposure, ymin = deut_uptake - err_deut_uptake, ymax = deut_uptake + err_deut_uptake))
    }

  }

  return(final_plot)


}
