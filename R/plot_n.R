#' Plots n values
#'
#' @param list_params list of fit parameters
#' @param fractional ...
#' @param interactive ...
#'
#' @description Plots the n values from fit parameters. When operating on fractional
#' values, the n value should be close to 1 to ensure model legitimacy. When operating
#' on values in daltons, the upper limit for the n value i max possible uptake calculated
#' from the sequence, although rarely reached due to back-exchange.
#'
#' @return a ggplot2 object. Need of convertion to girafe for interactive mode.
#'
#' @seealso create_fit_results
#'
#' @examples
#' fit_k_params <- get_example_fit_k_params()
#' control <- get_example_control()
#' kin_dat <- prepare_kin_dat(alpha_dat)
#' fit_values <- create_fit_dataset(kin_dat, control, fit_k_params)
#' plot_n(fit_values)
#'
#' @export
plot_n <- function(list_params,
                   fractional = FALSE,
                   interactive = FALSE){

  if(fractional){

    if(interactive){
      sel_points <- geom_point_interactive(aes(x = id, y = n,
                                               tooltip = glue("Sequence: {sequence}
                                                              Position: {start}-{end}
                                                              n_1 = {formatC(n_1, 2)}
                                                              n_2 = {formatC(n_2, 2)}
                                                              n_3 = {formatC(n_3, 2)}")))
    } else {
      sel_points <- geom_point(aes(x = id, y = n))
    }

    list_params %>%
      mutate(n = n_1 + n_2 + n_3) %>%
      filter(is.na(class_name)) %>%
      ggplot() +
      sel_points +
      labs(title = "n without class name") +
      theme_gray(base_size = 18) +
      geom_hline(yintercept = 1.25, linetype = 2) +
      ylim(c(0, NA))

  } else {

    if(interactive){
      sel_points <- geom_point_interactive(aes(x = id, y = n,
                                               tooltip = glue("Sequence: {sequence}
                                                              Position: {start}-{end}
                                                              n_1 = {formatC(n_1, 2)}
                                                              n_2 = {formatC(n_2, 2)}
                                                              n_3 = {formatC(n_3, 2)}")))
    } else {
      sel_points <- geom_point(aes(x = id, y = n))
    }

    list_params %>%
      filter(is.na(class_name)) %>%
      mutate(n = (n_1 + n_2 + n_3) / max_uptake) %>%
      ggplot() +
      sel_points +
      labs(title = "n without class name",
           y = "n/max_uptake") +
      theme_gray(base_size = 18) +
      geom_hline(yintercept = 1, linetype = 2) +
      ylim(c(0, 1.25))
  }

}
