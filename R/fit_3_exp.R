#'
#' @importFrom tibble deframe rownames_to_column remove_rownames
#' @importFrom dplyr %>% filter select arrange
#'
#' @export

fit_3_exp <- function(fit_dat,
                      control,
                      fit_k_params,
                      fractional = T,
                      trace = F){

  if(length(unique(fit_dat[["Sequence"]])) > 1){
    stop("More than one sequence in supplied data!")
  }

  n_1 = k_1 = n_2 = k_2 = n_3 = k_3 = -1
  rss <- 99999
  bic <- 99999
  fitted <- NA
  rgb_color <- NA

  max_uptake <- fit_dat[["MaxUptake"]][1]

  if(fractional){
    fit_params <- rbind(fit_k_params, get_3_n_params())
  } else {
    fit_params <- rbind(fit_k_params, get_3_n_params(MaxUptake = max_uptake))
  }

  tryCatch({

    if(fractional){

      mod <- minpack.lm::nlsLM(frac_deut_uptake ~ n_1*(1-exp(-k_1*Exposure)) + n_2*(1-exp(-k_2*Exposure)) + n_3*(1-exp(-k_3*Exposure)),
                               data = fit_dat,
                               start = deframe(rownames_to_column(fit_params["start"])),
                               lower = deframe(rownames_to_column(fit_params["lower"])),
                               upper = deframe(rownames_to_column(fit_params["upper"])),
                               control = control,
                               trace = trace)
    } else {

      mod <- minpack.lm::nlsLM(deut_uptake ~ n_1*(1-exp(-k_1*Exposure)) + n_2*(1-exp(-k_2*Exposure)) + n_3*(1-exp(-k_3*Exposure)),
                               data = fit_dat,
                               start = deframe(rownames_to_column(fit_params["start"])),
                               lower = deframe(rownames_to_column(fit_params["lower"])),
                               upper = deframe(rownames_to_column(fit_params["upper"])),
                               control = control,
                               trace = trace)

    }


    rss <-  sum(residuals(mod)^2)
    bic <- stats::AIC(mod, k = log(nrow(fit_dat)))
    n_1 <- coef(mod)["n_1"]
    k_1 <- coef(mod)["k_1"]
    n_2 <- coef(mod)["n_2"]
    k_2 <- coef(mod)["k_2"]
    n_3 <- coef(mod)["n_3"]
    k_3 <- coef(mod)["k_3"]
    n <- n_1 + n_2 + n_3
    rgb_color <- rgb(n_1/n, n_2/n, n_3/n)
    fitted <- 3
  }, error = function(e){
    print("sorry, error in 3 exp fit")
  })


  data.frame(sequence = fit_dat[["Sequence"]][1],
             start = fit_dat[["Start"]][1],
             end = fit_dat[["End"]][1],
             max_uptake = max_uptake,
             n_1 = n_1,
             k_1 = k_1,
             n_2 = n_2,
             k_2 = k_2,
             n_3 = n_3,
             k_3 = k_3,
             rss = rss,
             bic = bic,
             class_name = NA,
             fitted = fitted,
             color = rgb_color
  )
}
