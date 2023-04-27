#'
#'
#'
#' @export

fit_1_exp <- function(kin_dat,
                      sequence,
                      start, end,
                      control,
                      fit_k_params,
                      trace = F){


  fit_dat <- filter(kin_dat, Sequence == sequence, Start == start, End == end)

  ## shouldnt be checked before and skipped fitting process??

  class_name <- detect_class(fit_dat)

  n_1 <- -1
  k_1 <- -1
  r2_1 <- 9999

  fit_params <- rbind(get_1_k_params(fit_k_params), get_1_n_params())

  tryCatch({
    mod <- minpack.lm::nlsLM(frac_deut_uptake ~ n_1*(1-exp(-k_1*Exposure))
                             data = fit_dat,
                             start = deframe(rownames_to_column(fit_params["start"])),
                             lower = deframe(rownames_to_column(fit_params["lower"])),
                             upper = deframe(rownames_to_column(fit_params["upper"])),
                             control = control,
                             trace = trace)

    r2_3 <-  round(sum(residuals(mod)^2), 4)
    n_1 <- coef(mod)["n_1"]
    k_1 <- coef(mod)["k_1"]
  }, error = function(e){
    print("sorry, error in 1 exp")
  })


  ## fix params fnc applied

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
             r2 = r2_3,
             fit = 1
  )

}
