#'
#'
#'
#' @export

fit_3_exp <- function(kin_dat,
                      state,
                      sequence,
                      start, end,
                      control,
                      start_fit,
                      lower, upper){

  class_name <- detect_class(fit_dat)

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
             class_name = class_name
  )
}
