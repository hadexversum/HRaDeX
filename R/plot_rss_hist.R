#' @importFrom ggplot2 facet_wrap geom_histogram
#' @importFrom ggiraph geom_histogram_interactive
#'
#' @export
plot_rss_hist <- function(fit_values,
                          interactive = F){

  if(interactive){
    sel_histogram <-  geom_histogram_interactive(aes(x = rss,
                                                     tooltip = glue("Sequence: {sequence}
                                                                    Position: {start}-{end}
                                                                    RSS: {formatC(rss, 2)}")))
  } else {
    sel_histogram <-  geom_histogram(aes(x = rss))
  }

  fit_values %>%
    filter(is.na(class_name)) %>%
    ggplot() +
    sel_histogram +
    labs(fill = "exp") +
    theme_gray(base_size = 18) +
    facet_wrap(~ fitted, ncol = 1)
}
