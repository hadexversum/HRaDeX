#' Histogram of fit rss values
#'
#' @importFrom ggplot2 facet_wrap geom_histogram
#' @importFrom ggiraph geom_histogram_interactive
#'
#' @param fit_values data.frame with fit values
#' @param interactive ...
#'
#' @description Histogram of rss values for selected models for each peptide.
#' Divided with respect to the number of model parameters. Plot to judge the goodness
#' of the models.
#'
#' @return a ggplot2 object. Needs converstion to girafe for the interactive mode.
#'
#' @seealso ...
#'
#' @examples
#' TODO
#'
#' @export
plot_rss_hist <- function(fit_values,
                          interactive = FALSE){

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
