
#'
#'
#' @examples
#' kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
#' fit_dat <- kin_dat[kin_dat[["ID"]]==3, ]
#' fit_values_all <- create_fit_dataset(kin_dat, control = get_example_control(),
#'                                      fit_k_params = get_example_fit_k_params(),
#'                                      fractional = TRUE)
#' fit_values <- fit_values_all[fit_values_all[["id"]]==3, ]
#' hires_dat <- calculate_hires(fit_values = fit_values_all, method = "weighted", fractional = TRUE)
#' recreated_dat <- recreate_uc_values(fit_dat, fit_values, hires_dat)
#' ##
#'
#' kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
#' fit_values_all <- create_fit_dataset(kin_dat, control = get_example_control(),
#'                                      fit_k_params = get_example_fit_k_params(),
#'                                      fractional = TRUE)
#' hires_dat <- calculate_hires(fit_values = fit_values_all, method = "weighted", fractional = TRUE)
#' recreated_fit_values <- recreate_fit_values(peptide_sequence = "GFGDLKSPAGL",
#'                                             peptide_start = 1, peptide_end = 11,
#'                                             hires_dat = hires_dat)
#'
#'
#' @export

recreate_uc_values <- function(fit_dat,
                               recreated_fit_values){

  exp_3 <- function(x){
    recreated_fit_values[['n_1']]*(1-exp(-recreated_fit_values[['k_1']]*x)) + recreated_fit_values[['n_2']]*(1-exp(-recreated_fit_values[['k_2']]*x)) + recreated_fit_values[['n_3']]*(1-exp(-recreated_fit_values[['k_3']]*x))
  }

  rec_dat <- fit_dat %>%
    mutate(rec_deut_uptake = exp_3(Exposure))


  return(rec_dat)

}

#' Recreating fit values for peptide from hires values
#'
#' @examples
#' kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
#' fit_values_all <- create_fit_dataset(kin_dat, control = get_example_control(),
#'                                      fit_k_params = get_example_fit_k_params(),
#'                                      fractional = TRUE)
#' hires_dat <- calculate_hires(fit_values = fit_values_all, method = "weighted", fractional = TRUE)
#' recreate_fit_values(peptide_sequence = "GFGDLKSPAGL", peptide_start = 1, peptide_end = 11,
#'                     hires_dat = hires_dat)
#'
#'
#' @export
recreate_fit_values <- function(peptide_sequence, peptide_start, peptide_end, hires_dat){

  data.frame(aa = strsplit(peptide_sequence, "")[[1]],
             position = peptide_start:peptide_end) %>%
    filter(aa == toupper(aa)) %>%
    merge(hires_dat) %>%
    filter(aa!="P") %>%
    summarise(n_1 = mean(n_1),
              k_1 = mean(k_1),
              n_2 = mean(n_2),
              k_2 = mean(k_2),
              n_3 = mean(n_3),
              k_3 = mean(k_3))
}

#' Plot recovered values among experimental ones
#'
#' @examples
#' kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
#' fit_dat <- kin_dat[kin_dat[["ID"]]==3, ]
#' fit_values_all <- create_fit_dataset(kin_dat, control = get_example_control(),
#'                                      fit_k_params = get_example_fit_k_params(),
#'                                      fractional = TRUE)
#' fit_values <- fit_values_all[fit_values_all[["id"]]==3, ]
#' hires_dat <- calculate_hires(fit_values = fit_values_all, method = "weighted", fractional = TRUE)
#' recreated_fit_values <- recreate_fit_values(peptide_sequence = "GFGDLKSPAGL",
#'                                             peptide_start = 1, peptide_end = 11,
#'                                             hires_dat = hires_dat)
#' plot_recreated_uc(fit_dat, fit_values, recreated_fit_values)
#'
#' @export
plot_recreated_uc <- function(fit_dat, ## experimental uptake values for peptide
                              fit_values, ## original fit values
                              recreated_fit_values, ## recreated fit values
                              hires_method = "weighted",
                              fractional = TRUE,
                              interactive = FALSE,
                              if_girafe = FALSE){

  peptide_sequence <- unique(fit_dat[["Sequence"]])
  if(length(peptide_sequence) > 1) stop("More than one peptide!")
  peptide_start <- unique(fit_dat[["Start"]])
  peptide_end <- unique(fit_dat[["End"]])

  if(fractional){label_y <- "Fractional DU"
  } else { label_y <- "Deuterium Uptake [Da]"}

  geom_point_selected <- if(interactive){
    ggiraph::geom_point_interactive(aes(x = Exposure, y = frac_deut_uptake,
                                        tooltip = glue(
                                          "Sequence: {Sequence}
                                           Position: {Start}-{End}
                                           DU: {round(deut_uptake, 2)} [Da]
                                           Err(DU): {round(err_deut_uptake, 2)} [Da]
                                           Frac DU: {round(frac_deut_uptake, 2)} [%]
                                           Err(Frac DU): {round(err_frac_deut_uptake, 2)} [%]"),
                                        shape = "experimental"))

  } else {

    geom_point(aes(x = Exposure, y = frac_deut_uptake, shape = "experimental"))
  }

  uc_plot <- ggplot(fit_dat) +
    geom_point_selected +
    geom_linerange(aes(ymin = frac_deut_uptake - err_frac_deut_uptake,
                       ymax = frac_deut_uptake + err_frac_deut_uptake,
                       x = Exposure)) +
    # geom_line(aes(x = Exposure, y = frac_deut_uptake)) +
    ylim(c(0, 1.2)) +
    scale_x_log10() +
    labs(title = paste0(peptide_sequence, " ", peptide_start, "-", peptide_end, ", method: ", hires_method),
         y = label_y,
         x = "Exposure [min]") +
    stat_function(fun = function(x){recreated_fit_values[['n_1']]*(1-exp(-recreated_fit_values[['k_1']]*x)) + recreated_fit_values[['n_2']]*(1-exp(-recreated_fit_values[['k_2']]*x)) + recreated_fit_values[['n_3']]*(1-exp(-recreated_fit_values[['k_3']]*x))
    }, aes(color = "recovered")) +
    stat_function(fun = function(x){fit_values[['n_1']]*(1-exp(-fit_values[['k_1']]*x)) + fit_values[['n_2']]*(1-exp(-fit_values[['k_2']]*x)) + fit_values[['n_3']]*(1-exp(-fit_values[['k_3']]*x))
    }, aes(color = "fitted")) +
    scale_colour_manual(name = "",
                        values = c("recovered" = "red", "fitted" = "blue"),
                        breaks = c("recovered", "fitted"),
                        drop   = FALSE) +
    scale_shape_manual(name = "",
                       values = c(16)) +
    theme(legend.position = "bottom")

  if(if_girafe){
    girafe(ggobj = uc_plot)
  } else {
    return(uc_plot)
  }


}
