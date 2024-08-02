#'


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

#'
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

  return(res)
}

#'
recreate_uc <- function(fit_dat, ## uc filtered dat
                        fit_values_all, ## fit unfiltered
                        fractional = T,
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

  uc_plot <- ggplot(fit_dat) +
    geom_point(aes(x = Exposure, y = frac_deut_uptake)) +
    geom_errorbar(aes(ymin = frac_deut_uptake - err_frac_deut_uptake,
                      ymax = frac_deut_uptake + err_frac_deut_uptake,
                      x = Exposure)) +
    geom_line(aes(x = Exposure, y = frac_deut_uptake)) +
    ylim(c(0, 1.2)) +
    scale_x_log10() +
    labs(title = paste0(peptide_sequence, " ", peptide_start, "-", peptide_end, ", ", hires_method))

  uc_plot +
    stat_function(fun = function(x){peptide_hr[['n_1']]*(1-exp(-peptide_hr[['k_1']]*x)) + peptide_hr[['n_2']]*(1-exp(-peptide_hr[['k_2']]*x)) + peptide_hr[['n_3']]*(1-exp(-peptide_hr[['k_3']]*x))
    }, color = "blue") +
    stat_function(fun = function(x){fit_values[['n_1']]*(1-exp(-fit_values[['k_1']]*x)) + fit_values[['n_2']]*(1-exp(-fit_values[['k_2']]*x)) + fit_values[['n_3']]*(1-exp(-fit_values[['k_3']]*x))
    }, color = "red")

}

##############
# #
# dat <- omit_amino(alpha_dat, 1)
# kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
# kin_dat <- prepare_kin_dat(dat, state = "Alpha_KSCN")
#
#
# fit_k_params <- get_example_fit_k_params()
# control <- get_example_control()
# fit_values_all <- create_fit_dataset(kin_dat, control = control,
#                                      fit_k_params = fit_k_params,
#                                      fractional = T)
#
#
# fit_values <- fit_values_all[fit_values_all[["id"]]==1, ]
# fit_dat <- kin_dat[kin_dat[["ID"]]==1, ]
#
# library(gridExtra)
# # comparison of methods
#
# plt_shrtst_list <- lapply(1:106, function(i){
#   fit_dat <-  kin_dat[kin_dat[["ID"]]==i, ]
#   recreate_uc(fit_dat, fit_values_all, hires_method = "shortest")
# })
#
# plt_wghtd_list <- lapply(1:106, function(i){
#   fit_dat <-  kin_dat[kin_dat[["ID"]]==i, ]
#   recreate_uc(fit_dat, fit_values_all, hires_method = "weighted")
# })
#
# plt <- rep(1, 212)
# for(i in 1:106){
#   plt[2*i - 1] <- plt_shrtst_list[i]
#   plt[2*i] <- plt_wghtd_list[i]
# }
# mg_all <- marrangeGrob(plt, nrow = 2, ncol = 2)
# ggsave("all_omitted.pdf", mg_all, units="mm", height = 210, width = 297)
#
#
# ##
#
# hr_dat <- create_uc_from_hires_dataset(kin_dat,
#                                        fit_values_all,
#                                        hires_method = "weighted")
#
#
# hr_dat %>%
#   group_by(ID, Sequence, Start, End, State)%>%
#   summarize(sum_diff = sum(abs(hr_diff))) %>%
#   arrange(desc(sum_diff))
#
# ids <- hr_dat %>%
#   group_by(ID, Sequence, Start, End, State)%>%
#   summarize(sum_diff = sum(hr_diff)) %>%
#   arrange(desc(sum_diff)) %>%
#   head(10) %>%
#   ungroup() %>%
#   select(ID) %>% .[[1]]
#
# ## ID = 75
# recreate_uc(fit_dat = filter(kin_dat, ID == 75),
#             fit_values_all,
#             hires_method = "weighted")
#
# filter(fit_values_all, id == 75) %>%
#   mutate(n = n_1 + n_2 + n_3)
#
# pep_57 <- peptide_hr %>%
#   summarise(n_1 = mean(n_1),
#             k_1 = mean(k_1),
#             n_2 = mean(n_2),
#             k_2 = mean(k_2),
#             n_3 = mean(n_3),
#             k_3 = mean(k_3))
#
#
# dat_75 <- hr_dat %>%
#   filter(ID == 75)
#
# fit_values_75 <- filter(fit_values_all, id == 75)
#
# ggplot(dat_75) +
#   geom_point(aes(x = Exposure, y = frac_deut_uptake), color = "aquamarine") +
#   geom_line(aes(x = Exposure, y = frac_deut_uptake), color = "aquamarine") +
#   geom_point(aes(x = Exposure, y = hr_frac_deut_uptake), color = "orange") +
#   geom_line(aes(x = Exposure, y = hr_frac_deut_uptake), color = "orange") +
#   stat_function(fun = function(x){pep_57[['n_1']]*(1-exp(-pep_57[['k_1']]*x)) + pep_57[['n_2']]*(1-exp(-pep_57[['k_2']]*x)) + pep_57[['n_3']]*(1-exp(-pep_57[['k_3']]*x))}, color = "orange") +
#   stat_function(fun = function(x){pep_57[['n_1']]*(1-exp(-pep_57[['k_1']]*x))}, color = "red") +
#   stat_function(fun = function(x){pep_57[['n_2']]*(1-exp(-pep_57[['k_2']]*x))}, color = "green") +
#   stat_function(fun = function(x){pep_57[['n_3']]*(1-exp(-pep_57[['k_3']]*x))}, color = "blue") +
#   ylim(c(0, 1.2)) +
#   scale_x_log10()
#
# fit_values
#
# fit_values_all %>%
#   filter(id %in% ids[[1]]) %>%
#   select(sequence, n_1, k_1, n_2, k_2, n_3, k_3)

