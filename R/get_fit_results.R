#' @export
get_fit_results <- function(fit_dat,
                            fit_k_params,
                            control = list(maxiter = 1000,  scale = "levenberg"),
                            trace = FALSE,
                            workflow = 31,
                            fractional = TRUE,
                            edge_times = c(min(fit_dat[["Exposure"]]), max(fit_dat[["Exposure"]]))){

  workflow <- match.arg(as.character(workflow), choices = c(31, 21, 321))

  protein <- fit_dat[["Protein"]][1]
  state <- fit_dat[["State"]][1]

  if(length(unique(fit_dat[["Sequence"]])) > 1){
    stop("More than one sequence in supplied data!")
  }

  class_name <- detect_class(fit_dat, edge_times)

  # if extreme case is detected, we stop here
  if(!is.na(class_name)){
    return(fix_class_result(fit_dat,
                            class_name,
                            protein,
                            state,
                            fit_k_params))
  }

  if(workflow == 31){

    fit_3 <- fit_3_exp(fit_dat,
                       control = control,
                       fit_k_params = fit_k_params,
                       trace = trace,
                       fractional = fractional)

    fit_1 <- fit_1_exp(fit_dat,
                       control = control,
                       fit_k_params = fit_k_params,
                       trace = trace,
                       fractional = fractional)

    res <- rbind(fit_3, fit_1) %>%
      arrange(bic) %>%
      .[1, ]
  }

  if(workflow == 21){

    fit_2 <- fit_2_exp(fit_dat,
                       control = control,
                       fit_k_params = fit_k_params,
                       trace = trace,
                       fractional = fractional)

    fit_1 <- fit_1_exp(fit_dat,
                       control = control,
                       fit_k_params = fit_k_params,
                       trace = trace,
                       fractional = fractional)

    res <- rbind(fit_2, fit_1) %>%
      arrange(bic) %>%
      .[1, ]

  }

  if(workflow == 321) {

    fit_3 <- fit_3_exp(fit_dat,
                       control = control,
                       fit_k_params = fit_k_params,
                       trace = trace,
                       fractional = fractional)

    fit_2 <- fit_2_exp(fit_dat,
                       control = control,
                       fit_k_params = fit_k_params,
                       trace = trace,
                       fractional = fractional)

    fit_1 <- fit_1_exp(fit_dat,
                       control = control,
                       fit_k_params = fit_k_params,
                       trace = trace,
                       fractional = fractional)

    res <- rbind(fit_3, fit_2, fit_1) %>%
      arrange(bic) %>%
      .[1, ]

  }

  res[["Protein"]] <- protein
  res[["State"]] <- state

  return(select(res, Protein, State, everything()))

}

# get_fit_results(fit_dat, fit_k_params, workflow = 21)

# fit_k_params <- data.frame(
#   start = c(k_1 = 2, k_2 = 0.1, k_3 = 0.01),
#   lower = c(k_1 = 1, k_2 = 0.1, k_3 = 0),
#   upper = c(k_1 = 30, k_2 = 1, k_3 = 0.1)
# )

# szybciak
# sequence = "DKLKAERERGITID"
# start = 61
# end = 74

# zwyklak
# sequence = "IVVIGHVD"
# start = 10
# end = 17

# fit_dat <- kin_dat %>%
#   filter(Sequence == sequence,
#          Start == start,
#          End == end)

##

#' @export
fix_class_result <- function(fit_dat,
                             class_name,
                             protein,
                             state,
                             fit_k_params){

  if(class_name == "immediate"){
    k_1 = max(fit_k_params[["upper"]])
    n_1 = 1
    k_2 = n_2 = k_3 = n_3 = 0
    color = "#FFFF00"
  }

  if(class_name == "none"){
    k_1 = n_1 = k_2 = n_2 = k_3 = n_3 = 0
    color = "#000000"
  }

  if(class_name == "invalid"){
    k_1 = n_1 = k_2 = n_2 = k_3 = n_3 = NA
    color = "#808080"
  }

  data.frame(Protein = protein,
             State = state,
             sequence = fit_dat[["Sequence"]][1],
             start = fit_dat[["Start"]][1],
             end = fit_dat[["End"]][1],
             max_uptake = fit_dat[["MaxUptake"]][1],
             n_1 = n_1,
             k_1 = k_1,
             n_2 = n_2,
             k_2 = k_2,
             n_3 = n_3,
             k_3 = k_3,
             rss = NA,
             bic = NA,
             class_name = class_name,
             fitted = 0,
             color = color)
}

##

#' @export
detect_class <-  function(fit_dat, edge_times = NULL){

  class_name <- NA

  du_100 <- fit_dat %>%
    filter(Exposure == max(fit_dat[["Exposure"]])) %>%
    select(deut_uptake) %>% unlist() %>% mean()

  du_1 <- fit_dat %>%
    filter(Exposure == min(fit_dat[["Exposure"]])) %>%
    select(deut_uptake) %>% unlist() %>% mean()

  max_uptake <- unique(fit_dat[["MaxUptake"]])

  if(is.nan(du_100)) return("invalid")
  if(is.nan(du_1)) return("invalid")

  if(!is.null(edge_times)) {
    if(sum(unique(fit_dat[["Exposure"]]) %in% edge_times)!=2) return("invalid")
  }

  # if(du_100 < 1) return("none") # before
  # if(du_100*0.8 < du_1) return("immediate") # before

  threshold = 0.1
  if(du_100/ max_uptake < threshold & du_100 < 1) return("none")
  # if((du_100 - du_1)/max_uptake < threshold &  du_1 / du_100 > 1 - threshold) return("immediate")

  class_name

}
