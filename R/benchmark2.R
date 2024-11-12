library(patchwork)
library(ggplot2)
library(dplyr)
library(HRaDeX)
library(pbapply)
library(tidyr)

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





produce_hr <- function(dat) {
  kin_dat <- prepare_kin_dat(dat, state = "Alpha_KSCN")

  fit_k_params_2 <- data.frame(
    start = c(k_1 = 2, k_2 = 0.2, k_3 = 0.02),
    lower = c(k_1 = 1, k_2 = 0.1, k_3 = 0.0001),
    upper = c(k_1 = 30, k_2 = 1, k_3 = 0.1))

  control <- get_example_control()
  fit_values_all <- create_fit_dataset(kin_dat, control = control,
                                       fit_k_params = fit_k_params_2,
                                       fractional = TRUE)

  hr_dat <- rbind(create_uc_from_hires_dataset(kin_dat,
                                               fit_values_all,
                                               hires_method = "weighted") %>%
                    mutate(type = "weighted average"),
                  hr_dat <- create_uc_from_hires_dataset(kin_dat,
                                                         fit_values_all,
                                                         hires_method = "shortest") %>%
                    mutate(type = "shortest peptide"))

  mutate(hr_dat, hr_diff2 = hr_diff^2) %>%
    group_by(ID, Sequence, Start, End, State, type) %>%
    summarize(mean_err = sqrt(mean(hr_diff2)))
}

possible_timepoints <- c(0.167, 1, 5, 25, 150)


all_tp_hrs <- pblapply(possible_timepoints, function(ith_timepoint)
  produce_hr(filter(alpha_dat, Exposure != ith_timepoint))
)

all_timepoints <- produce_hr(alpha_dat)

bind_rows(lapply(1L:length(possible_timepoints), function(ith_id) {
  ungroup(all_tp_hrs[[ith_id]]) %>%
    group_by(type) %>%
    mutate(less_05 = mean_err < 0.05) %>%
    summarise(avg = mean(mean_err),
              avg_less_05 = mean(less_05)) %>%
    mutate(without_exposure = as.character(possible_timepoints[ith_id]))
}) %>%
  bind_rows(),
ungroup(all_timepoints) %>%
  group_by(type) %>%
  mutate(less_05 = mean_err < 0.05) %>%
  summarise(avg = mean(mean_err),
            avg_less_05 = mean(less_05)) %>%
  mutate(without_exposure = "All time points")) %>%
  mutate(without_exposure = factor(without_exposure, levels = c("All time points", possible_timepoints)),
         lab = round(avg, 4)) %>%
  ggplot(aes(x = without_exposure, y = avg, label = lab)) +
  geom_col(position = position_dodge(width = 0.9)) +
  geom_label(aes(y = avg/2), size = 2.9, fill = "white", show.legend = FALSE) +
  scale_x_discrete("Removed time points") +
  scale_y_continuous("RMSE") +
  #scale_fill_manual("Type", values = c("#c51b7d", "#4d9221")) +
  #scale_color_manual("Type", values = c("#c51b7d", "#4d9221")) +
  ggtitle("Benchmark result",
          "Without a single time point") +
  facet_wrap(~ type) +
  theme_bw(base_size = 8) +
  theme(legend.position = "bottom")

ggsave("all-timepoints.png")


set.seed(15390)

all_pep_fracs <- sort(rep(c(0.05, 0.1, 0.2, 0.3, 0.4, 0.5), 10))

all_peptide_hrs <- pblapply(all_pep_fracs, function(ith_frac) {
  chosen_peptides <- sample(unique(alpha_dat[["Sequence"]]), size = round(ith_frac * length(unique(alpha_dat[["Sequence"]])), 0))
  produce_hr(filter(alpha_dat, !(Sequence %in% chosen_peptides)))
})


bind_rows(lapply(1L:length(all_pep_fracs), function(ith_id) {
  ungroup(all_peptide_hrs[[ith_id]]) %>%
    group_by(type) %>%
    mutate(less_05 = mean_err < 0.05) %>%
    summarise(avg = mean(mean_err),
              avg_less_05 = mean(less_05)) %>%
    mutate(pep_frac = as.character(1 - all_pep_fracs[ith_id]))
}) %>%
  bind_rows(),
ungroup(all_timepoints) %>%
  group_by(type) %>%
  mutate(less_05 = mean_err < 0.05) %>%
  summarise(avg = mean(mean_err),
            avg_less_05 = mean(less_05)) %>%
  mutate(pep_frac = "all peptides")) %>%
  group_by(type, pep_frac) %>%
  mutate(pep_frac = factor(pep_frac, levels = c("all peptides", unique(1 - all_pep_fracs))),
         lab = round(avg, 2)) %>%
  ggplot(aes(x = pep_frac, y = avg, color = type, label = lab)) +
  geom_point() +
  theme_bw()



mean_err_dat %>%
  ungroup() %>%
  group_by(type) %>%
  summarise(err = mean(mean_err))

ggplot(mean_err_dat, aes(x = mean_err, fill = type)) +
  geom_histogram() +
  facet_wrap(~ type)


set.seed(716080)

all_peptide_subsets <- pblapply(rep(0.3, 300), function(ith_frac) {
  chosen_peptides <- sample(unique(alpha_dat[["Sequence"]]), size = round(ith_frac * length(unique(alpha_dat[["Sequence"]])), 0))
  filter(alpha_dat, !(Sequence %in% chosen_peptides))
})

coverage95 <- round(sapply(all_peptide_subsets, HaDeX::get_protein_coverage), 0) == 0.95
sum(coverage95)

all_coverage_hrs <- pblapply(all_peptide_subsets[coverage95], function(ith_dat) {
  produce_hr(ith_dat)
})

lapply(all_coverage_hrs, function(ith_dat) {
  ungroup(ith_dat) %>%
    group_by(type) %>%
    mutate(less_05 = mean_err < 0.05) %>%
    summarise(avg = mean(mean_err))
}) %>%
  bind_rows() %>%
  mutate(id = sort(rep(1L:(nrow(.)/2), 2))) %>%
  pivot_wider(names_from = type, values_from = avg) %>%
  ggplot(aes(x = `shortest peptide`, y = `weighted average`)) +
  geom_point() +
  scale_x_continuous("RMSE (shortest peptide)") +
  scale_y_continuous("RMSE (weighted average)") +
  ggtitle("Benchmark results",
          "Randomly sampled peptides at 95% coverage") +
  theme_bw()

ggsave("difference-digestion-patterns.png")

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
  geom_rect(color = "black", size = 1) +
  scale_x_continuous("Position") +
  scale_fill_gradient("RMSE", low = "white", high = "red") +
  guides(
    linetype = guide_legend("Type of aggregation", override.aes = aes(fill = "grey")),
    #fill = guide_legend(override.aes = aes(linetype = "solid"))
  ) +
  theme_bw(base_size = 18) +
  theme(legend.position = "bottom",
        legend.key.width = unit(1.5, "cm"),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank())



p1 <- mean_err_dat %>%
  ggplot(aes(x = ID, y = mean_err)) +
  geom_point() +
  geom_line(linetype = "dashed") +
  scale_x_continuous("Peptide ID") +
  scale_y_continuous("RMSE") +
  facet_wrap(~ type, ncol = 1) +
  theme_bw(base_size = 18)



png("benchmark.png", width = 680*4, height = 680*0.9*4, res = 180)
p1/p2 +
  plot_annotation(tag_levels = "A") &
  theme(plot.tag = element_text(size = 26))
dev.off()


