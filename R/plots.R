#' Plots heatmap with classification parameters
#'
#' @importFrom ggplot2 ggplot geom_tile theme labs
#'
#' @param fixed_params fit params after modification
#'
#' @description Not in use.
#' TODO
#'
#' @return a ggplot2 object.
#'
#' @export

plot_class_heatmap <- function(fixed_params){

  ggplot(fixed_params, aes(x = id, y = 1)) +
    geom_tile(fill = fixed_params[["color"]]) +
    theme(legend.position = "none",
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank()) +
    labs(y = "",
         title = "class components")


}

#' Plots initial fit parameters
#'
#' @importFrom ggplot2 geom_line ylim geom_ribbon
#'
#' @param fit_k_params data.frame with k values for exchange groups
#'
#' @description Plots a visualization of selected excahnge group limits,
#' with initial parameters for the fit. It is helpful for additional self-control
#' of chosen limits.
#'
#' @return a ggplot2 object.
#'
#' @examples
#' fit_k_params <- get_example_fit_k_params()
#' plot_start_params(fit_k_params)
#'
#' @export
plot_start_params <- function(fit_k_params){

  x = seq(0, 1500, 0.025)

  ggplot() +
    geom_line(aes(x = x, y = 0.33*(1-exp(-fit_k_params[1, "start"]*x))), color = "red") +
    geom_ribbon(aes(x = x, ymin=0.33*(1-exp(-fit_k_params[1, "lower"]*x)), ymax=0.33*(1-exp(-fit_k_params[1, "upper"]*x))), fill = "red", alpha = 0.1) +
    geom_line(aes(x = x, y = 0.33*(1-exp(-fit_k_params[2, "start"]*x))), color = "green") +
    geom_ribbon(aes(x = x, ymin=0.33*(1-exp(-fit_k_params[2, "lower"]*x)), ymax=0.33*(1-exp(-fit_k_params[2, "upper"]*x))), fill = "green", alpha = 0.1) +
    geom_line(aes(x = x, y = 0.33*(1-exp(-fit_k_params[3, "start"]*x))), color = "blue") +
    geom_ribbon(aes(x = x, ymin=0.33*(1-exp(-fit_k_params[3, "lower"]*x)), ymax=0.33*(1-exp(-fit_k_params[3, "upper"]*x))), fill = "blue", alpha = 0.1)+
    ylim(c(0, .35)) +
    scale_x_log10() +
    theme_bw(base_size = 18) +
    labs(x = "Exposure",
         y = "Initial exchange values with bounds")
  }



#' Plot summary image
#'
#' @importFrom ggplot2 xlim theme_void geom_text
#'
#' @description Not in use.
#'
#' @export
get_params_summary_image <- function(fixed_params){

  n_total <- nrow(fixed_params)

  n_three <- fixed_params %>%
    filter(fitted == 3 & is.na(class_name)) %>%
    nrow(.)

  n_one <- fixed_params %>%
    filter(fitted == 1 & is.na(class_name)) %>%
    nrow(.)

  n_class_name <- fixed_params %>%
    filter(!is.na(class_name)) %>%
    nrow(.)

  ggplot(data.frame(n_total, n_three)) +
    xlim(c(0, 1)) +
    ylim(c(-0.5, 0.75)) +
    geom_text(x = 0.5, y = 0.55, label = paste0("total:   ", n_total)) +
    geom_text(x = 0.5, y = 0.4, label = paste0("fitted three:   " , n_three )) +
    geom_text(x = 0.5, y = 0.25, label = paste0("fitted one:   " , n_one)) +
    geom_text(x = 0.5, y = 0.1, label = paste0("plaszczak/szybciak:   " , n_class_name)) +
    theme_void()
}







