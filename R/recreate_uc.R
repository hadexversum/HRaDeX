#'@export


calculate_uc_from_hires_peptide <- function(fit_dat, ## uc filtered dat
                                            fit_values_all, ## fit unfiltered
                                            fractional = T,
                                            hires_method = c("shortest", "weighted")){

  # hires_method <- "weighted"

  peptide_sequence <- unique(fit_dat[["Sequence"]])
  if(length(peptide_sequence) > 1) stop("More than one peptide!")
  peptide_start <- unique(fit_dat[["Start"]])
  peptide_end <- unique(fit_dat[["End"]])

  hires <- calculate_hires(fit_values_all, method = hires_method, fractional = T)

  fit_values <- filter(fit_values_all,
                       sequence == peptide_sequence,
                       start == peptide_start,
                       end == peptide_end)

  peptide_hr <- filter(hires,
                       position >= peptide_start,
                       position <= peptide_end,
                       aa!='P') %>%
    summarise(n_1 = mean(n_1),
              k_1 = mean(k_1),
              n_2 = mean(n_2),
              k_2 = mean(k_2),
              n_3 = mean(n_3),
              k_3 = mean(k_3))

  exp_3 <- function(x){
    peptide_hr[['n_1']]*(1-exp(-peptide_hr[['k_1']]*x)) + peptide_hr[['n_2']]*(1-exp(-peptide_hr[['k_2']]*x)) + peptide_hr[['n_3']]*(1-exp(-peptide_hr[['k_3']]*x))
  }

  res <- fit_dat %>%
    mutate(hr_frac_deut_uptake = exp_3(Exposure),
           hr_diff = frac_deut_uptake - hr_frac_deut_uptake)

  return(res)
}

#' @examples
#' kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
#' fit_values_all <- create_fit_dataset(kin_dat, control = get_example_control(),
#'                                      fit_k_params = get_example_fit_k_params(),
#'                                      fractional = T)
#' create_uc_from_hires_dataset(kin_dat, fit_values_all, hires_method = "shortest")
#'
#' @export
create_uc_from_hires_dataset <- function(kin_dat,
                                         fit_values_all,
                                         fractional = T,
                                         hires_method = c("shortest", "weighted")){

  peptide_list <- unique(select(kin_dat, ID, Sequence, Start, End))

  res <- lapply(1:nrow(fit_values_all), function(i){

    fit_dat <- kin_dat[kin_dat[["ID"]]==i, ]

    calculate_uc_from_hires_peptide(fit_dat,
                                    fit_values_all,
                                    fractional = T,
                                    hires_method = hires_method)

  }) %>% bind_rows()

  res <- select(res,
                ID, Protein, State, Sequence, Start, End, MaxUptake, Exposure, frac_deut_uptake, err_frac_deut_uptake, hr_frac_deut_uptake, hr_diff)

  attr(res, "hires_method") <- hires_method
  return(res)
}

#'
#' @param fit_dat experimental uptake data filter for chosen peptide
#' @param fit_values_all fit parameters for whole peptide pool
#' @param fractional indicator if the fractional deuterium uptake is used
#' @param hires_method method of aggregation
#'
#' @examples
#' kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
#' fit_dat <- kin_dat[kin_dat[["ID"]]==3, ]
#' fit_values_all <- create_fit_dataset(kin_dat, control = get_example_control(),
#'                                      fit_k_params = get_example_fit_k_params(),
#'                                      fractional = T)
#' recreate_uc(fit_dat, fit_values_all, hires_method = "shortest")
#'
#' @export
recreate_uc <- function(fit_dat, ## uc filtered dat
                        fit_values_all, ## fit unfiltered
                        fractional = TRUE,
                        hires_method = c("shortest", "weighted")){

  peptide_sequence <- unique(fit_dat[["Sequence"]])
  if(length(peptide_sequence) > 1) stop("More than one peptide!")
  peptide_start <- unique(fit_dat[["Start"]])
  peptide_end <- unique(fit_dat[["End"]])

  hires <- calculate_hires(fit_values_all, method = hires_method, fractional = T)

  fit_values <- filter(fit_values_all,
                       sequence == peptide_sequence,
                       start == peptide_start,
                       end == peptide_end)

  peptide_hr <- filter(hires,
                       position >= peptide_start,
                       position <= peptide_end,
                       aa!='P') %>%
    summarise(n_1 = mean(n_1),
              k_1 = mean(k_1),
              n_2 = mean(n_2),
              k_2 = mean(k_2),
              n_3 = mean(n_3),
              k_3 = mean(k_3))

  if(fractional){label_y <- "Fractional DU [%]"
  } else { label_y <- "Deuterium Uptake [Da]"}

  uc_plot <- ggplot(fit_dat) +
    geom_point(aes(x = Exposure, y = frac_deut_uptake, shape = "experimental")) +
    geom_linerange(aes(ymin = frac_deut_uptake - err_frac_deut_uptake,
                      ymax = frac_deut_uptake + err_frac_deut_uptake,
                      x = Exposure)) +
    # geom_line(aes(x = Exposure, y = frac_deut_uptake)) +
    ylim(c(0, 1.2)) +
    scale_x_log10() +
    labs(title = paste0(peptide_sequence, " ", peptide_start, "-", peptide_end, ", method: ", hires_method),
         y = label_y,
         x = "Exposure [min]")

  uc_plot +
    stat_function(fun = function(x){peptide_hr[['n_1']]*(1-exp(-peptide_hr[['k_1']]*x)) + peptide_hr[['n_2']]*(1-exp(-peptide_hr[['k_2']]*x)) + peptide_hr[['n_3']]*(1-exp(-peptide_hr[['k_3']]*x))
    }, aes(color = "reconstructed")) +
    stat_function(fun = function(x){fit_values[['n_1']]*(1-exp(-fit_values[['k_1']]*x)) + fit_values[['n_2']]*(1-exp(-fit_values[['k_2']]*x)) + fit_values[['n_3']]*(1-exp(-fit_values[['k_3']]*x))
    }, aes(color = "fitted")) +
    scale_colour_manual(name = "",
                        values = c("blue", "red")) +
    scale_shape_manual(name = "",
                       values = c(16)) +
    theme(legend.position = "bottom")
}



#' @examples
#' rec_uc_dat <- create_uc_from_hires_dataset(kin_dat,
#'                                        fit_values_all,
#'                                        hires_method = "shortest")
#' calculate_reconstructed_uc_rmse(rec_uc_dat)
#'
#' @export
calculate_reconstructed_uc_rmse <- function(rec_uc_dat,
                                           sort = c("ID", "rmse")){


  res <- rec_uc_dat %>%
    mutate(hr_diff2 = hr_diff^2) %>%
    group_by(ID, Sequence, Start, End, State) %>%
    summarize(rmse = sqrt(mean(hr_diff2))) %>%
    ungroup()

  if(sort == "mse") res <- arrange(desc(rmse))

  attr(res, "mean_rmse") <- mean(res[["rmse"]])
  attr(res, "hires_method") <- attr(rec_uc_dat, "hires_method")
  return(res)
}

#' @examples
#' rec_uc_rmse_dat <- calculate_reconstructed_uc_rmse(rec_uc_dat)
#' plot_reconstructed_uc_coverage(rec_uc_rmse_dat, style = "butterfly")
#'
#' @export
plot_reconstructed_uc_coverage <- function(rec_uc_rmse_dat,
                                           style = c("coverage", "butterfly")){

  if(style == "coverage"){

    ## levels
    levels <- rep(NA, (nrow(rec_uc_rmse_dat)))
    levels[1] <- 1
    start <- rec_uc_rmse_dat[["Start"]]
    end <- rec_uc_rmse_dat[["End"]]

    for(i in 1:(nrow(rec_uc_rmse_dat) - 1)) {
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

    rec_uc_rmse_dat[["ID"]] <- levels

    plt <- ggplot(data = rec_uc_rmse_dat,
           mapping = aes(xmin = Start, xmax = End + 1,
                         ymin = ID, ymax = ID - 1)) +
      geom_rect(aes(fill = rmse)) +
      labs(title = "",
           x = "Position",
           y = "") +
      theme(legend.position = "bottom",
            axis.ticks.y = element_blank(),
            axis.text.y = element_blank())


  } else if (style == "butterfly"){

    plt <- ggplot(rec_uc_rmse_dat, aes(x = ID, y = rmse)) +
      geom_point() +
      geom_line(linetype = 2, linewidth = 0.01)
      ylim(c(0, NA)) +
      labs(x = "Peptide ID",
           title = paste0("mean RMSE ", round(attr(rec_uc_rmse_dat, "mean_rmse"), 3),", hires method: ", attr(rec_uc_rmse_dat, "hires_method")))

  }

  return(plt)


}
