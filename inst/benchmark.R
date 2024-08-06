library(patchwork)

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
dat <- omit_amino(alpha_dat, 1)
kin_dat <- prepare_kin_dat(alpha_dat, state = "Alpha_KSCN")
kin_dat <- prepare_kin_dat(dat, state = "Alpha_KSCN")


fit_k_params <- get_example_fit_k_params()
control <- get_example_control()
fit_values_all <- create_fit_dataset(kin_dat, control = control,
                                     fit_k_params = fit_k_params,
                                     fractional = TRUE)

hr_dat <- rbind(create_uc_from_hires_dataset(kin_dat,
                                             fit_values_all,
                                             hires_method = "weighted") %>%
                  mutate(type = "weighted"),
                hr_dat <- create_uc_from_hires_dataset(kin_dat,
                                                       fit_values_all,
                                                       hires_method = "shortest") %>%
                  mutate(type = "shortest"))

mean_err_dat <- mutate(hr_dat, hr_diff2 = hr_diff^2) %>%
  group_by(ID, Sequence, Start, End, State, type) %>%
  summarize(mean_err = sqrt(mean(hr_diff2)))

mean_err_dat %>%
  ungroup() %>%
  group_by(type) %>%
  mutate(less_05 = mean_err < 0.05) %>%
  summarise(1 - mean(less_05))


ggplot(mean_err_dat, aes(x = mean_err, fill = type)) +
  geom_histogram() +
  facet_wrap(~ type)


smash <- function(fit_values, what = "ID", start = "start", end = "end") {
  levels <- rep(NA, nrow(fit_values))
  levels[1] <- 1
  start <- fit_values[[start]]
  end <- fit_values[[end]]

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
  fit_values
}

p2 <- mean_err_dat %>%
  group_by(type) %>%
  smash("ID", "Start", "End") %>%
  mutate(ID = ifelse(type == "weighted", ID - 1.5, ID + 0.5)) %>%
  ggplot(data = .,
         mapping = aes(xmin = Start, xmax = End + 1,
                       ymin = ID, ymax = ID - 0.75, fill = mean_err, linetype = type)) +
  geom_rect(color = "black") +
  scale_x_continuous("Position") +
  scale_fill_gradient("Mean error", low = "white", high = "red") +
  guides(
    linetype = guide_legend("Type of aggregation", override.aes = aes(fill = "grey")),
    #fill = guide_legend(override.aes = aes(linetype = "solid"))
  ) +
  theme_bw() +
  theme(legend.position = "bottom",
        legend.key.width = unit(1, "cm"),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank())

plot_cov_class


p1 <- mean_err_dat %>%
  ggplot(aes(x = ID, y = mean_err)) +
  geom_point() +
  geom_line(linetype = "dashed") +
  scale_x_continuous("Peptide ID") +
  scale_y_continuous("Mean error") +
  facet_wrap(~ type, ncol = 1) +
  theme_bw()



png("benchmark.png", width = 680, height = 680*1.1)
p1/p2 +
  plot_annotation(tag_levels = "A") &
  theme(plot.tag = element_text(size = 24))
dev.off()


