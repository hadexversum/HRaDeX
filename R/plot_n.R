#' @export
plot_n <- function(list_params,
                   fractional = F,
                   interactive = F){

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
