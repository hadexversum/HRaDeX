#'
#'
#'
#' @export

fit_1_exp <- function(fit_dat,
                      control,
                      fit_k_params,
                      fractional = T,
                      trace = F){


  if(length(unique(fit_dat[["Sequence"]])) > 1){
    stop("More than one sequence in supplied data!")
  }

  n_1 = k_1 = -1
  rss <- 99999

  max_uptake <- fit_dat[["MaxUptake"]][1]

  if(fractional){
    fit_params <- rbind(get_1_k_params(fit_k_params), get_1_n_params())
  } else {
    fit_params <- rbind(get_1_k_params(fit_k_params), get_1_n_params(MaxUptake = max_uptake))
  }

  tryCatch({
    if(fractional){

      mod <- minpack.lm::nlsLM(frac_deut_uptake ~ n_1*(1-exp(-k_1*Exposure)),
                               data = fit_dat,
                               start = deframe(rownames_to_column(fit_params["start"])),
                               lower = deframe(rownames_to_column(fit_params["lower"])),
                               upper = deframe(rownames_to_column(fit_params["upper"])),
                               control = control,
                               trace = trace)

    } else {

      mod <- minpack.lm::nlsLM(deut_uptake ~ n_1*(1-exp(-k_1*Exposure)),
                               data = fit_dat,
                               start = deframe(rownames_to_column(fit_params["start"])),
                               lower = deframe(rownames_to_column(fit_params["lower"])),
                               upper = deframe(rownames_to_column(fit_params["upper"])),
                               control = control,
                               trace = trace)
    }


    rss <-  sum(residuals(mod)^2)
    n_1 <- coef(mod)["n_1"]
    k_1 <- coef(mod)["k_1"]
  }, error = function(e){
    print("sorry, error in 1 exp")
  })

  if(n_1 == -1 & k_1 == -1){

    data.frame(sequence = fit_dat[["Sequence"]][1],
               start = fit_dat[["Start"]][1],
               end = fit_dat[["End"]][1],
               max_uptake = max_uptake,
               n_1 = -1,
               k_1 = -1,
               n_2 = -1,
               k_2 = -1,
               n_3 = -1,
               k_3 = -1,
               rss = 99999,
               class_name = NA,
               fitted = NA,
               color = NA )
  } else{

    fix_1_exp_result(fit_dat,
                     n = n_1[[1]],
                     k = k_1[[1]],
                     rss = rss,
                     fit_k_params = fit_k_params,
                     max_uptake = max_uptake)
  }

}

fix_1_exp_result <- function(fit_dat,
                             n,
                             k,
                             rss,
                             fit_k_params,
                             max_uptake){

  n_1 = k_1 = n_2 = k_2 = n_3 = k_3 = 0

  if(fit_k_params["k_1", "lower"] < k & k <= fit_k_params["k_1", "upper"]){
    k_1 = k
    n_1 = n
  }

  if(fit_k_params["k_2", "lower"] < k & k <= fit_k_params["k_2", "upper"]){
    k_2 = k
    n_2 = n
  }

  if(fit_k_params["k_3", "lower"] < k & k <= fit_k_params["k_3", "upper"]){
    k_3 = k
    n_3 = n
  }

  n <- n_1 + n_2 + n_3

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
             class_name = NA,
             fitted = 1,
             color = rgb(n_1/n, n_2/n, n_3/n)
  )

}
