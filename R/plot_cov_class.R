#' @importFrom ggplot2 geom_rect aes element_blank
#' @export
plot_cov_class <- function(fit_values,
                           fractional = T,
                           interactive = F){


  ## levels
  levels <- rep(NA, (nrow(fit_values)))
  levels[1] <- 1
  start <- fit_values[["start"]]
  end <- fit_values[["end"]]

  for(i in 1:(nrow(fit_values) - 1)) {
    for(level in 1:max(levels, na.rm = TRUE)) {
      if(all(start[i + 1] > end[1:i][levels == level] | end[i + 1] < start[1:i][levels == level], na.rm = TRUE)) {
        levels[i + 1] <- level
        break
      } else {
        if(level == max(levels, na.rm = TRUE)) {
          levels[i + 1] <- max(levels, na.rm = TRUE) + 1
        }
      }
    }
  }

  fit_values[["ID"]] <- levels

  if(fractional){

    fit_values <- fit_values %>%
      mutate(alpha = case_when( n_1 + n_2 + n_3 > 1.25 ~ 0.5, T ~  1))

  } else {

    fit_values <- fit_values %>%
      mutate(alpha = case_when( n_1 + n_2 + n_3 - max_uptake >= 0 ~ 0.5, T ~  1))

  }
  ## end of levels

  if(interactive) {
    rect <- geom_rect_interactive(fill = fit_values[["color"]],
                                  alpha = fit_values[["alpha"]],
                                  aes(tooltip = glue("Sequence: {sequence}
                                                      Position: {start}-{end}
                                                      n_1 = {formatC(n_1/(n_1+n_2+n_3), 2)}
                                                      n_2 = {formatC(n_2/(n_1+n_2+n_3), 2)}
                                                      n_3 = {formatC(n_3/(n_1+n_2+n_3), 2)} ")))

  } else {
    rect <- geom_rect(fill = fit_values[["color"]],
                      alpha = fit_values[["alpha"]])
  }

  class_cov_plot <- ggplot(data = fit_values,
         mapping = aes(xmin = start, xmax = end + 1,
                       ymin = ID, ymax = ID - 1)) +
    rect +
    labs(title = "Assigned class on coverage",
         x = "Position",
         y = "") +
    theme_bw(base_size = 18) +
    theme(axis.ticks.y = element_blank(),
          axis.text.y = element_blank()) +
    coord_cartesian(x = c(0, max(fit_values[["end"]])+1))

  girafe(ggobj = class_cov_plot,
         width_svg = 10,
         height_svg = 4)
}
