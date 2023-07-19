#' @importFrom gridExtra grid.arrange
#' @importFrom ggplot2 stat_function geom_line annotate theme_bw
#' @export
plot_uc_fit <- function(fit_dat,
                        fit_values,
                        include_uc = T,
                        duplex = T,
                        triplex = F){

  plot_title <- paste0(fit_values[["sequence"]], " (", fit_values[["start"]], "-", fit_values[["end"]], ") ")

  if(include_uc){

    uc_plot <- ggplot(fit_dat, aes(x = Exposure, y = deut_uptake)) +
      geom_point() +
      geom_line(linetype = 2) +
      ylim(c(0, NA)) +
      labs(title = paste0(plot_title, " without fit"),
           x = "Exposure [min]",
           y = "Deuterium uptake [Da]")
  }

  if(!is.na(fit_values[["class_name"]])) {

   uc_plot_sc <-  ggplot() +
     geom_point(data = fit_dat, aes(x = Exposure, y = frac_deut_uptake)) +
     labs(title = paste0(plot_title, fit_values[["class_name"]],  " exchange scaled in log"),
          y = "Fractional DU [%]",
          x = "Exposure [min]") +
     scale_x_log10() +
     ylim(c(0, 1.25))

   if(include_uc) { return(grid.arrange(uc_plot, uc_plot_sc, nrow = 1)) }

   return(uc_plot_sc)

  }

  n_1 <- fit_values[["n_1"]]
  k_1 <- fit_values[["k_1"]]
  n_2 <- fit_values[["n_2"]]
  k_2 <- fit_values[["k_2"]]
  n_3 <- fit_values[["n_3"]]
  k_3 <- fit_values[["k_3"]]

  uc_fit_plot <- ggplot() +
    geom_point(data = fit_dat, aes(x = Exposure, y = frac_deut_uptake)) +
    labs(title = paste0(plot_title, " scaled"),
         y = "Fractional DU [%]",
         x = "Exposure [min]") +
    stat_function(fun=function(x){n_1*(1-exp(-k_1*x)) + n_2*(1-exp(-k_2*x)) + n_3*(1-exp(-k_3*x))}) +
    annotate(geom = "text", x = 1000, y = 0.2, label = paste0("R2: ", round(fit_values[["r2"]], 4))) +
    ylim(c(0, 1.25))

  if(triplex){

    uc_fit_plot_log <- ggplot() +
      geom_point(data = fit_dat, aes(x = Exposure, y = frac_deut_uptake)) +
      labs(title = paste0(plot_title, " in log scale"),
           y = "Fractional DU [%]",
           x = "Exposure [min]") +
      stat_function(fun=function(x){n_1*(1-exp(-k_1*x)) + n_2*(1-exp(-k_2*x)) + n_3*(1-exp(-k_3*x))}) +
      ylim(c(0, 1.25)) +
      scale_x_log10()

    fit_components_plot <- ggplot() +
      stat_function(fun = function(x){n_1*(1-exp(-k_1*x))}, color = "red") +
      stat_function(fun = function(x){n_2*(1-exp(-k_2*x))}, color = "green") +
      stat_function(fun = function(x){n_3*(1-exp(-k_3*x))}, color = "blue") +
      xlim(c(0, 1500)) +
      ylim(c(0, 1.25)) +
      labs(title = "Fit components",
           x = "Exposure [min]",
           y = "Fractional DU [%]")

    if(include_uc){
      return(grid.arrange(uc_plot, uc_fit_plot, uc_fit_plot_log, fit_components_plot, nrow = 1))
    } else {
      return(grid.arrange(uc_fit_plot, uc_fit_plot_log, fit_components_plot, nrow = 1))

    }

  } else if(duplex){

    uc_fit_plot_log_components <- ggplot() +
      geom_point(data = fit_dat, aes(x = Exposure, y = frac_deut_uptake)) +
      labs(title = paste0(plot_title, " scaled in log with fit components"),
           y = "Fractional DU [%]",
           x = "Exposure [min]") +
      stat_function(fun=function(x){n_1*(1-exp(-k_1*x)) + n_2*(1-exp(-k_2*x)) + n_3*(1-exp(-k_3*x))}) +
      ylim(c(0, 1.25)) +
      stat_function(fun = function(x){n_1*(1-exp(-k_1*x))}, color = "red") +
      stat_function(fun = function(x){n_2*(1-exp(-k_2*x))}, color = "green") +
      stat_function(fun = function(x){n_3*(1-exp(-k_3*x))}, color = "blue") +
      geom_hline(yintercept = 1, linetype = "dotted", alpha = 0.3) +
      scale_x_log10(limits = c(NA, 5000))

    return(grid.arrange(uc_plot, uc_fit_plot_log_components, nrow = 1))


  } else {

    if(include_uc) {return(grid.arrange(uc_plot, uc_fit_plot, nrow = 1)) }
    else { return(uc_fit_plot)}

  }

}
