#' Plots singular uptake curve
#'
#' @param fit_dat deuterium uptake data for one peptide
#' @param fit_values fit parameters for that one peptide, not used
#' @param include_uc indicator if regular uc should be plotted as well
#' @param replicate indicator if data for replicates should be plotted, or
#' aggregated
#' @param fractional ...
#' @param interactive ...
#'
#' @description Function plots deuterium uptake plot (uc) for one peptide,
#' in a traditional mode.
#' Currently not in use in GUIs.
#'
#' @return a ggplot object. Need a conversion to girafe for interactive mode.
#'
#' @seealso ...
#'
#' @examples TODO
#'
#' @export

plot_singular_uc <- function(fit_dat,
                             fit_values,
                             include_uc = T,
                             replicate = F,
                             fractional = T,
                             interactive = F){

    plot_title <- paste0(unique(fit_dat[["sequence"]]), " (", unique(fit_dat[["start"]]), "-", unique(fit_dat[["end"]]), ") ")

    if(replicate){

      avg_fit_dat <- fit_dat %>%
        group_by(Exposure) %>%
        summarize(avg_deut_uptake = mean(deut_uptake))

      if(interactive){

        sel_points <- geom_point_interactive(aes(x = Exposure, y = deut_uptake,
                                                tooltip = glue("Exposure: {Exposure}
                                                               DU = {formatC(deut_uptake, 2)} Da
                                                               Err DU = {formatC(err_deut_uptake, 2)} Da")),
                                            size = 2)
      } else {
        sel_points <- geom_point(aes(x = Exposure, y = deut_uptake), size = 2)
      }

      final_plot <- ggplot(fit_dat) +
        sel_points +
        geom_line(data = avg_fit_dat, aes(x = Exposure, y = avg_deut_uptake), linetype = 2)  +
        ylim(c(0, NA)) +
        theme_gray(base_size = 18) +
        labs(title = paste0(plot_title, " without fit"),
             x = "Exposure [min]",
             y = "Deuterium uptake [Da]")


    } else {

      if(interactive){

        sel_points <- geom_point_interactive(aes(x = Exposure, y = deut_uptake,
                                                 tooltip = glue("Exposure: {Exposure}
                                                               DU = {formatC(deut_uptake, 2)} Da
                                                               Err DU = {formatC(err_deut_uptake, 2)} Da")),
                                             size = 2)
      } else {
        sel_points <- geom_point(aes(x = Exposure, y = deut_uptake), size = 2)
      }

      final_plot <- ggplot(fit_dat, aes(x = Exposure, y = deut_uptake)) +
        geom_errorbar(data = fit_dat, aes(x = Exposure, ymin = deut_uptake - err_deut_uptake, ymax = deut_uptake + err_deut_uptake)) +
        sel_points+
        geom_line(linetype = 2) +
        ylim(c(0, NA)) +
        theme_gray(base_size = 18) +
        labs(title = paste0(plot_title, " without fit"),
             x = "Exposure [min]",
             y = "Deuterium uptake [Da]")

    }


  return(final_plot)



}


