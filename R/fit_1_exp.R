#'
#'
#'
#' @export

fit_1_exp <- function(kin_dat,
                      state,
                      sequence,
                      start, end,
                      control,
                      start_fit,
                      lower, upper){

  class_name <- detect_class(fit_dat)

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
             class_name = class_name,
             n = n,
             k = k,
             r2_1 = r2_1
  )

}
