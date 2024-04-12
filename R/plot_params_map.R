#' Plots map of params
#'
#' @importFrom ggplot2 scale_x_log10 scale_y_log10 geom_hline geom_point geom_vline
#' @importFrom dplyr case_when
#'
#' @param fit_values ...
#' @param interactive ...
#'
#' @description Currently not in use.
#'
#' @export
plot_params_map <- function(fit_values,
                            interactive = F){

  if(interactive){
    sel_points <- geom_point_interactive(aes(x = dom_exp, y = sec_dom_exp,
                                             tooltip = glue("Sequence: {sequence}
                                                            Position: {start}-{end}
                                                            n_1 = {formatC(n_1, 2)}
                                                            n_2 = {formatC(n_2, 2)}
                                                            n_3 = {formatC(n_3, 2)}")))
  } else {
    sel_points <- geom_point(aes(x = dom_exp, y = sec_dom_exp))
  }

  fit_values %>%
    filter(is.na(class_name)) %>%
    mutate(dom_exp = case_when(
      n_3 > n_1 & n_3 > n_2 ~ k_3,
      n_2 > n_1 & n_2 > n_3 ~ k_2,
      n_1 > n_2 & n_1 > n_3 ~ k_1,
      T ~ -1
    )) %>%
    mutate(sec_dom_exp = case_when(
      n_2 < n_1 & n_2 > n_3 ~ k_2,
      n_3 < n_1 & n_3 > n_2 ~ k_3,
      n_1 < n_2 & n_1 > n_3 ~ k_1,
      n_3 < n_2 & n_3 > n_1 ~ k_3,
      n_1 < n_3 & n_1 > n_2 ~ k_1,
      n_2 < n_3 & n_2 > n_1 ~ k_2,
      T ~ -1
    )) %>%
    ggplot() +
    sel_points +
    labs(title = "three types of n(1-exp(-kt))",
         x = "k for dom n",
         y = "k for 2 dom n") +
    scale_x_log10() +
    scale_y_log10() +
    theme_gray(base_size = 18) +
    geom_hline(yintercept = 0.1, color = "red", linetype = "dashed") +
    geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
    geom_hline(yintercept = 1, color = "red", linetype = "dashed") +
    geom_vline(xintercept = 0.1, color = "red", linetype = "dashed") +
    geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
    geom_vline(xintercept = 1, color = "red", linetype = "dashed")

}

