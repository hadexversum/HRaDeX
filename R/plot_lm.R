#' Plots uc with linear fit
#'
#' @importFrom ggplot2 stat_smooth
#'
#' @param fit_dat deuterium uptake data for selected peptide.
#' @param class_name class name assigned to selected peptide.
#' @param interactive ...
#'
#' @description Plots uptake curve for a peptide with linear fit.
#' Used in GUI to present uptake curves for edge cases, where the
#' three-exponential model cannot be fitted.
#'
#' @return a ggplot2 object. For interactive mode, conversion to girafe is needed.
#'
#' @seealso
#'
#' @examples
#' kin_dat <- prepare_kin_dat(alpha_dat)
#' fit_dat <- kin_dat[kin_dat[["ID"]]==1, ]
#' plot_lm(fit_dat, class_name = unique(fit_dat[["class_name"]]))
#'
#' @export plot_lm

plot_lm <- function(fit_dat,
                    class_name = NA,
                    interactive = TRUE){

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

