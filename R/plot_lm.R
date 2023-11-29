#' @importFrom ggplot2 stat_smooth
#'
#' @export plot_lm

plot_lm <- function(fit_dat,
                    class_name = NA,
                    interactive = T){

  sequence <- unique(fit_dat[["Sequence"]])
  start <- unique(fit_dat[["Start"]])
  end <- unique(fit_dat[["End"]])

  if(length(sequence) > 1){
    stop("More than one sequence in supplied data!")
  }

  if(interactive){
    sel_points <- geom_point(aes(x = Exposure, y = deut_uptake,
                                 tooltip = glue("Sequence: {sequence}
                                                Exposure: {Exposure}
                                                DU = {formatC(deut_uptake, 2) Da}
                                                Err DU = {formatC(err_deut_uptake, 2) Da}")),
                             shape = 1, size = 3)
  } else {
    sel_points <- geom_point(aes(x = Exposure, y = deut_uptake), shape = 1, size = 3)
  }

  ggplot(fit_dat) +
    sel_points +
    geom_linerange(data = fit_dat, aes(x = Exposure, ymin = deut_uptake - err_deut_uptake, ymax = deut_uptake + err_deut_uptake)) +
    ylim(c(0, ceiling(max(fit_dat[["deut_uptake"]] + 1)))) +
    scale_x_log10(limits = c(NA, 10000)) +
    stat_smooth(method = "lm") +
    theme_gray(base_size = 18) +
    labs(title = paste0(sequence, " (", start, "-", end, ") edge case ", class_name),
         x = "Exposure [min]",
         y = "Deuterium uptake [Da]")

}

