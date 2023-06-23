#'
#'
#'
#' @export
fit_2_exp <- function(fit_dat,
                      control,
                      fit_k_params,
                      trace = F){

  if(length(unique(fit_dat[["Sequence"]])) > 1){
    stop("More than one sequence in supplied data!")
  }

  n_1 = k_1 = n_2 = k_2 = -1
  groups = NA

  fit_2_types <- get_2_k_params(fit_k_params)

  print(paste(unique(fit_dat[["Sequence"]])))
  print("2 exp fit")

  fit_2_res <- lapply(fit_2_types, function(fit_2_params){

    fit_params <- rbind(fit_2_params, get_2_n_params())

    n_1 = k_1 = n_2 = k_2 = -1
    groups = NA
    r2 <- 99999

    tryCatch({

      mod <- minpack.lm::nlsLM(frac_deut_uptake ~ n_1*(1-exp(-k_1*Exposure)) + n_2*(1-exp(-k_2*Exposure)),
                               data = fit_dat,
                               start = deframe(rownames_to_column(fit_params["start"])),
                               lower = deframe(rownames_to_column(fit_params["lower"])),
                               upper = deframe(rownames_to_column(fit_params["upper"])),
                               control = control,
                               trace = trace)

      r2 <-  sum(residuals(mod)^2)
      n_1 <- coef(mod)["n_1"]
      k_1 <- coef(mod)["k_1"]
      n_2 <- coef(mod)["n_2"]
      k_2 <- coef(mod)["k_2"]

      groups <- attr(fit_2_params, "groups")
      print(paste(n_1, k_1, n_2, k_2, r2, groups))

    }, error = function(e){
      print(e)
      print("sorry, error in 2 exp")
    })

    data.frame(n_1 = n_1,
               k_1 = k_1,
               n_2 = n_2,
               k_2 = k_2,
               r2 = r2,
               groups = groups)

  }) %>% bind_rows() %>% arrange(r2) %>% .[1, ]

  if(fit_2_res[["n_1"]] == -1 & fit_2_res[["k_1"]] == -1){

    data.frame(sequence = sequence,
               start = start,
               end = end,
               n_1 = -1,
               k_1 = -1,
               n_2 = -1,
               k_2 = -1,
               n_3 = -1,
               k_3 = -1,
               r2 = 99999,
               class_name = NA,
               fitted = NA,
               color = NA)

  } else {

    # fix_2_exp_result(fit_dat,
    #                  fit_2_res = fit_2_res,
    #                  fit_k_params = fit_k_params)

    fix_2_exp_result_v2(fit_dat,
                        fit_2_res = fit_2_res)

  }

}

# fit_2_exp(fit_dat, control, fit_k_params, trace = T)

fix_2_exp_result_v2 <- function(fit_dat,
                                fit_2_res){

  groups <- fit_2_res[["groups"]]
  n_1 = k_1 = n_2 = k_2 = n_3 = k_3 = 0

  if(groups == 12) {
    k_1 = fit_2_res[["k_1"]]
    n_1 = fit_2_res[["n_1"]]
    k_2 = fit_2_res[["k_2"]]
    n_2 = fit_2_res[["n_2"]]
  }

  if(groups == 13){
    k_1 = fit_2_res[["k_1"]]
    n_1 = fit_2_res[["n_1"]]
    k_3 = fit_2_res[["k_2"]]
    n_3 = fit_2_res[["n_2"]]
  }

  if(groups == 23){
    k_2 = fit_2_res[["k_1"]]
    n_2 = fit_2_res[["n_1"]]
    k_3 = fit_2_res[["k_2"]]
    n_3 = fit_2_res[["n_2"]]
  }

  n <- n_1 + n_2 + n_3

  data.frame(sequence = fit_dat[["Sequence"]][1],
             start = fit_dat[["Start"]][1],
             end = fit_dat[["End"]][1],
             n_1 = n_1,
             k_1 = k_1,
             n_2 = n_2,
             k_2 = k_2,
             n_3 = n_3,
             k_3 = k_3,
             r2 = fit_2_res[["r2"]],
             class_name = NA,
             fitted = 2,
             color = rgb(n_1/n, n_2/n, n_3/n)
  )

}

#' @noRd
fix_2_exp_result <- function(fit_dat,
                             fit_2_res,
                             fit_k_params){

  n_1 = k_1 = n_2 = k_2 = n_3 = k_3 = 0

  if(fit_k_params["k_1", "lower"] < fit_2_res[["k_1"]] & fit_2_res[["k_1"]] <= fit_k_params["k_1", "upper"]){
    k_1 = fit_2_res[["k_1"]]
    n_1 = fit_2_res[["n_1"]]
  }

  if(fit_k_params["k_2", "lower"] < fit_2_res[["k_1"]] & fit_2_res[["k_1"]] <= fit_k_params["k_2", "upper"]){
    k_2 = fit_2_res[["k_1"]]
    n_2 = fit_2_res[["n_1"]]
  }

  if(fit_k_params["k_3", "lower"] < fit_2_res[["k_1"]] & fit_2_res[["k_1"]] <= fit_k_params["k_3", "upper"]){
    k_3 = fit_2_res[["k_1"]]
    n_3 = fit_2_res[["n_1"]]
  }

  if(fit_k_params["k_1", "lower"] < fit_2_res[["k_2"]] & fit_2_res[["k_2"]] <= fit_k_params["k_1", "upper"]){
    k_1 = fit_2_res[["k_2"]]
    n_1 = fit_2_res[["n_2"]]
  }

  if(fit_k_params["k_2", "lower"] < fit_2_res[["k_2"]] & fit_2_res[["k_2"]] <= fit_k_params["k_2", "upper"]){
    k_2 = fit_2_res[["k_2"]]
    n_2 = fit_2_res[["n_2"]]
  }

  if(fit_k_params["k_3", "lower"] < fit_2_res[["k_2"]] & fit_2_res[["k_2"]] <= fit_k_params["k_3", "upper"]){
    k_3 = fit_2_res[["k_2"]]
    n_3 = fit_2_res[["n_2"]]
  }

  data.frame(sequence = fit_dat[["Sequence"]][1],
             start = fit_dat[["Start"]][1],
             end = fit_dat[["End"]][1],
             n_1 = n_1,
             k_1 = k_1,
             n_2 = n_2,
             k_2 = k_2,
             n_3 = n_3,
             k_3 = k_3,
             r2 = fit_2_res[["r2"]],
             class_name = NA,
             fitted = 2,
             color = rgb(n_1, n_2, n_3)
  )

}
