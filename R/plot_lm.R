#' @importFrom ggplot2 stat_smooth
#'
#' @export plot_lm

plot_lm <- function(fit_dat,
                    class_name = NA){

  sequence <- unique(fit_dat[["Sequence"]])
  start <- unique(fit_dat[["Start"]])
  end <- unique(fit_dat[["End"]])

  if(length(sequence) > 1){
    stop("More than one sequence in supplied data!")
  }

  # mod <- lm(deut_uptake~Exposure, data = fit_dat)

  ggplot(fit_dat, aes(x = Exposure, y = deut_uptake)) +
    geom_point(shape = 1, size = 3) +
    geom_linerange(data = fit_dat, aes(x = Exposure, ymin = deut_uptake - err_deut_uptake, ymax = deut_uptake + err_deut_uptake)) +
    ylim(c(0, ceiling(max(fit_dat[["deut_uptake"]] + 1)))) +
    scale_x_log10(limits = c(NA, 10000)) +
    stat_smooth(method = "lm") +
    theme_gray(base_size = 18) +
    labs(title = paste0(sequence, " (", start, "-", end, ") edge case ", class_name),
         x = "Exposure [min]",
         y = "Deuterium uptake [Da]")

}

#
# plot_lm_2 <- function(fit_dat){
#
#   sequence <- unique(fit_dat[["Sequence"]])
#   start <- unique(fit_dat[["Start"]])
#   end <- unique(fit_dat[["End"]])
#
#   if(length(sequence) > 1){
#     stop("More than one sequence in supplied data!")
#   }
#
#   mod <- lm(deut_uptake~Exposure, data = fit_dat)
#
#   ggplot(fit_dat, aes(x = Exposure, y = deut_uptake)) +
#     geom_point() +
#     ylim(c(0, ceiling(max(fit_dat[["deut_uptake"]] + 1)))) +
#     stat_smooth(method = "lm") +
#     ggpubr::stat_regline_equation(label.x.npc = "center") +
#     labs(title = paste0(sequence, " (", start, "-", end, ") edge case"),
#          x = "Exposure [min]",
#          y = "Deuterium uptake [Da]")
#
# }
#
#
#
# library(patchwork)
# plot_lm_2(fit_dat) /
# plot_lm(fit_dat)
