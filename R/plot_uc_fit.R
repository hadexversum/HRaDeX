#' @importFrom gridExtra grid.arrange
#' @importFrom ggplot2 stat_function
#' @export
plot_uc_fit <- function(fit_dat,
                        fit_values,
                        triplex = F){

  plot_title <- paste0(fit_values[["sequence"]], " (", fit_values[["start"]], "-", fit_values[["end"]], ") ")

  if(!is.na(fit_values[["class_name"]])) {

   plot_title <- paste0(plot_title, fit_values[["class_name"]])

   uc_plot <-  ggplot() +
     geom_point(data = fit_dat, aes(x = Exposure, y = frac_deut_uptake)) +
     labs(title = plot_title,
          y = "Fractional DU",
          x = "Exposure [min]") +
   ylim(c(0, 1.1))

   return(uc_plot)

  }

  n_1 <- fit_values[["n_1"]]
  k_1 <- fit_values[["k_1"]]
  n_2 <- fit_values[["n_2"]]
  k_2 <- fit_values[["k_2"]]
  n_3 <- fit_values[["n_3"]]
  k_3 <- fit_values[["k_3"]]

  uc_fit_plot <- ggplot() +
    geom_point(data = fit_dat, aes(x = Exposure, y = frac_deut_uptake)) +
    labs(title = plot_title,
         y = "Fractional DU [%]",
         x = "Exposure [min]") +
    stat_function(fun=function(x){n_1*(1-exp(-k_1*x)) + n_2*(1-exp(-k_2*x)) + n_3*(1-exp(-k_3*x))}) +
    ylim(c(0, 1.1))

  if(triplex){

    uc_fit_plot_log <- ggplot() +
      geom_point(data = fit_dat, aes(x = Exposure, y = frac_deut_uptake)) +
      labs(title = plot_title,
           y = "Fractional DU [%]",
           x = "Exposure [min]") +
      stat_function(fun=function(x){n_1*(1-exp(-k_1*x)) + n_2*(1-exp(-k_2*x)) + n_3*(1-exp(-k_3*x))}) +
      ylim(c(0, 1.1)) +
      scale_x_log10()

    fit_components_plot <- ggplot() +
      stat_function(fun = function(x){n_1*(1-exp(-k_1*x))}, color = "red") +
      stat_function(fun = function(x){n_2*(1-exp(-k_2*x))}, color = "green") +
      stat_function(fun = function(x){n_3*(1-exp(-k_3*x))}, color = "blue") +
      xlim(c(0, 1500)) +
      ylim(c(0, 1.1)) +
      labs(title = "Fit components",
           x = "Exposure [min]",
           y = "Fractional DU [%]")

    return(grid.arrange(uc_fit_plot, uc_fit_plot_log, fit_components_plot, nrow = 1))

  } else {

    return(uc_fit_plot)

  }

}
