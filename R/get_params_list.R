#' @importFrom dplyr bind_rows case_when arrange
#' @export
get_params_list <- function(kin_dat,
                            peptide_list,
                            control, start_1,lower_1, upper_1, start_3,lower_3, upper_3){

  params <- apply(peptide_list, 1, function(peptide){

    fit_two_methods(kin_dat,
                    sequence = peptide[[1]],
                    start = as.numeric(peptide[[2]]),
                    end = as.numeric(peptide[[3]]),
                    state = kin_dat[["State"]][1],
                    control = control,
                    start_3 = start_3,
                    lower_3 = lower_3,
                    upper_3 = upper_3,
                    start_1 = start_1,
                    lower_1 = lower_1,
                    upper_1 = upper_1)

  }) %>% bind_rows()

  params %>%
    mutate(fitted = case_when(
      r2_3 > r2_1 ~ 1,
      r2_1 > r2_3 ~ 3
    )) %>%
    mutate(r2 = case_when(
      fitted == 1 ~ r2_1,
      fitted == 3 ~ r2_3,
      T ~ -1
    ))
}

#' @noRd
fit_two_methods <- function(kin_dat, ## temporarly we are using aggregated values
                            sequence = kin_dat[["Sequence"]][1],
                            start = kin_dat[["Start"]][1],
                            end = kin_dat[["End"]][1],
                            state = kin_dat[["State"]][1],
                            control = list(maxiter = 1000,  scale = "levenberg"),
                            start_3 = c(n_1 = 0.3, k_1 = 0.5, n_2 = 0.3, k_2 = 0.3, n_3 = 0.3, k_3 = 0.01),
                            lower_3 = c(n_1 = 0, k_1 = 1, n_2 = 0, k_2 = 0.1, n_3 = 0, k_3 = 0),
                            upper_3 = c(n_1 = 2, k_1 = 30, n_2 = 2, k_2 = 1.5, n_3 = 2, k_3 = 0.5),
                            start_1 = c(n = 0.5, k = 0.8),
                            lower_1 = c(n = 0, k = 0),
                            upper_1 = c(n = 2, k = 30)
){

  fit_dat <- kin_dat %>%
    filter(Sequence == sequence,
           Start == start,
           End == end)

  class_name <- detect_class(fit_dat)

  # kin_plot <- ggplot(fit_dat) +
  #   geom_point(aes(x = Exposure, y = frac_deut_uptake)) +
  #   # geom_line(aes(x = Exposure, y = frac_deut_uptake)) +
  #   geom_text(x = 1000, y = 0.18, label = class_name) +
  #   ylim(c(0, NA)) +
  #   labs(title = paste(sequence, start, end, state))

  ## fit 3 exp

  n_1 <- -1
  k_1 <- -1
  n_2 <- -1
  k_2 <- -1
  n_3 <- -1
  k_3 <- -1
  r2_3 <- 9999

  tryCatch({
    mod <- minpack.lm::nlsLM( # frac_deut_uptake ~ n_1*(1-exp(-k_1*Exposure)) + n_2*(1-exp(-k_2*Exposure)) + n_3*(1-exp(-k_3*Exposure)),
      frac_deut_uptake ~ 1 - n_1*exp(-k_1*Exposure) - n_2*exp(-k_2*Exposure) - n_3*exp(-k_3*Exposure),
      data = fit_dat,
      start = start_3,
      lower = lower_3,
      upper = upper_3,
      control = control,
      trace = T)

    r2_3 <-  round(sum(residuals(mod)^2), 4)
    n_1 <- coef(mod)["n_1"]
    k_1 <- coef(mod)["k_1"]
    n_2 <- coef(mod)["n_2"]
    k_2 <- coef(mod)["k_2"]
    n_3 <- coef(mod)["n_3"]
    k_3 <- coef(mod)["k_3"]
  }, error = function(e){
    print("sorry, error in 3 exp")
  })

  ## fit 1 exp

  n <- -1
  k <- -1
  r2_1 <- 9999

  tryCatch({
    mod <- minpack.lm::nlsLM(frac_deut_uptake ~ n*(1-exp(-k*Exposure)),
                             data = fit_dat,
                             start = start_1,
                             lower = lower_1,
                             upper = upper_1,
                             control = control,
                             trace = T)

    r2_1 <-  round(sum(residuals(mod)^2), 4)
    n <- coef(mod)["n"]
    k <- coef(mod)["k"]
  }, error = function(e){
    print("sorry, error in 1 exp")
  })


  data.frame(sequence = sequence,
             state = state,
             start = start,
             end = end,
             n_1 = n_1,
             k_1 = k_1,
             n_2 = n_2,
             k_2 = k_2,
             n_3 = n_3,
             k_3 = k_3,
             r2_3 = r2_3,
             class_name = class_name,
             n = n,
             k = k,
             r2_1 = r2_1
  )

}

#' @noRd
detect_class <-  function(fit_dat){

  class_name <- NA

  du_100 <- fit_dat %>%
    filter(Exposure == max(fit_dat[["Exposure"]])) %>%
    select(deut_uptake) %>% unlist() %>% mean()

  du_1 <- fit_dat %>%
    filter(Exposure == min(fit_dat[["Exposure"]])) %>%
    select(deut_uptake) %>% unlist() %>% mean()

  max_uptake <- unique(fit_dat[["MaxUptake"]])

  if(du_100*0.8 < du_1) class_name <- "szybciak"

  if(du_100 < 1) class_name <- "plaszczak"

  class_name

}

#' @export
fix_params_list <- function(params_list, lower_3, upper_3){

  k_fast = c(lower_3[["k_1"]], upper_3[["k_1"]])
  k_medium = c(lower_3[["k_2"]], upper_3[["k_2"]])
  k_slow = c(lower_3[["k_3"]], upper_3[["k_3"]])

  params_list %>%
    mutate(k_1 = case_when(fitted == 1 & is.na(class_name) & k > k_fast[1] ~ k,
                           fitted == 1 & is.na(class_name) ~ 0,
                           class_name == "plaszczak" ~ 0,
                           class_name == "szybciak" ~ k_fast[2],
                           T ~ k_1),
           n_1 = case_when(fitted == 1 & is.na(class_name) & k > k_fast[1] ~ n,
                           fitted == 1 & is.na(class_name) ~ 0,
                           class_name == "plaszczak" ~ 0,
                           class_name == "szybciak" ~ 1,
                           T ~ n_1),
           k_2 = case_when(fitted == 1 & is.na(class_name) & k > k_medium[1] & k < k_medium[2] & n_1 == 0 ~ k,
                           fitted == 1 & is.na(class_name) ~ 0,
                           class_name == "plaszczak" ~ 0,
                           class_name == "szybciak" ~ 0,
                           T ~ k_2),
           n_2 = case_when(fitted == 1 & is.na(class_name) & k > k_medium[1] & k < k_medium[2] & n_1 == 0 ~ n,
                           fitted == 1 & is.na(class_name) ~ 0,
                           class_name == "plaszczak" ~ 0,
                           class_name == "szybciak" ~ 0,
                           T ~ n_2),
           k_3 = case_when(fitted == 1 & is.na(class_name) & k > k_slow[1] & k < k_slow[2] & n_2 == 0 ~ k,
                           fitted == 1 & is.na(class_name) ~ 0,
                           class_name == "plaszczak" ~ 0,
                           class_name == "szybciak" ~ 0,
                           T ~ k_3),
           n_3 = case_when(fitted == 1 & is.na(class_name) & k > k_slow[1] & k < k_slow[2] & n_2 == 0 ~ n,
                           fitted == 1 & is.na(class_name) ~ 0,
                           class_name == "plaszczak" ~ 0,
                           class_name == "szybciak" ~ 0,
                           T ~ n_3)) %>%
    select(-r2_3, -r2_1, -n, -k, class_name) %>%
    arrange(start, end) %>%
    mutate(id = 1:nrow(.),
           n = n_1 + n_2 + n_3,
           n_1_sc = ifelse(is.nan(n_1/n), 0, n_1/n),
           n_2_sc = ifelse(is.nan(n_2/n), 0, n_2/n),
           n_3_sc = ifelse(is.nan(n_3/n), 0, n_3/n)) %>%
    mutate(color = factor(as.character(rgb(n_1_sc, n_2_sc, n_3_sc))))
  # mutate(color = case_when( class_name == "szybciak" ~ "#FFFFFF",
  #                           T ~ rgb(n_1_sc, n_2_sc, n_3_sc)) ) %>%
  # mutate(color = factor(as.character(color)))


}
