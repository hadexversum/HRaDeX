#'
#'
#'
#' @export

fit_3_exp <- function(kin_dat,
                      sequence,
                      start, end,
                      control,
                      fit_k_params,
                      trace = F){

  ## should kin_dat be filtered here of before? probably. TODO

  fit_dat <- filter(kin_dat, Sequence == sequence, Start == start, End == end)

  class_name <- detect_class(fit_dat)

  n_1 <- -1
  k_1 <- -1
  n_2 <- -1
  k_2 <- -1
  n_3 <- -1
  k_3 <- -1
  r2_3 <- 9999

  fit_params <- rbind(fit_k_params, get_3_n_params())

  tryCatch({
    mod <- minpack.lm::nlsLM(frac_deut_uptake ~ n_1*(1-exp(-k_1*Exposure)) + n_2*(1-exp(-k_2*Exposure)) + n_3*(1-exp(-k_3*Exposure)),
      data = fit_dat,
      start = deframe(rownames_to_column(fit_params["start"])),
      lower = deframe(rownames_to_column(fit_params["lower"])),
      upper = deframe(rownames_to_column(fit_params["upper"])),
      control = control,
      trace = trace)

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
             class_name = class_name,
             n_1 = n_1,
             k_1 = k_1,
             n_2 = n_2,
             k_2 = k_2,
             n_3 = n_3,
             k_3 = k_3,
             r2_3 = r2_3,
             fit = 3
  )
}
