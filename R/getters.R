# example fit_params

# fit_k_params <- data.frame(
#   start = c(k_1 = 2, k_2 = 0.1, k_3 = 0.01),
#   lower = c(k_1 = 1, k_2 = 0.1, k_3 = 0),
#   upper = c(k_1 = 30, k_2 = 1, k_3 = 0.1)
# )

get_1_k_params <- function(fit_k_params){

  data.frame(
    start = c(k_1 = sort(fit_k_params[["start"]])[2]),
    lower = c(k_1 = min(fit_k_params[["lower"]])),
    upper = c(k_1 = max(fit_k_params[["upper"]]))
  )

}

get_2_k_params <- function(fit_k_params){

  list(data.frame(
    start = c(k_1 = fit_k_params["k_1", "start"], k_2 = fit_k_params["k_2", "start"]),
    lower = c(k_1 = fit_k_params["k_1", "lower"], k_2 = fit_k_params["k_2", "lower"]),
    upper = c(k_1 = fit_k_params["k_1", "upper"], k_2 = fit_k_params["k_2", "upper"])
  ), data.frame(
    start = c(k_1 = fit_k_params["k_1", "start"], k_2 = fit_k_params["k_3", "start"]),
    lower = c(k_1 = fit_k_params["k_1", "lower"], k_2 = fit_k_params["k_3", "lower"]),
    upper = c(k_1 = fit_k_params["k_1", "upper"], k_2 = fit_k_params["k_3", "upper"])
  ), data.frame(
    start = c(k_1 = fit_k_params["k_2", "start"], k_2 = fit_k_params["k_3", "start"]),
    lower = c(k_1 = fit_k_params["k_2", "lower"], k_2 = fit_k_params["k_3", "lower"]),
    upper = c(k_1 = fit_k_params["k_2", "upper"], k_2 = fit_k_params["k_3", "upper"])
  ))

}

get_3_n_params <- function(){

  data.frame(
    start = c(n_1 = 0.33, n_2 = 0.33, n_3 = 0.33),
    lower = c(n_1 = 0, n_2 = 0, n_3 = 0),
    upper = c(n_1 = 1, n_2 = 1, n_3 = 1)
  )

}

get_2_n_params <- function(){

  data.frame(
    start = c(n_1 = 0.5, n_2 = 0.5),
    lower = c(n_1 = 0, n_2 = 0),
    upper = c(n_1 = 1, n_2 = 1)
  )
}

get_1_n_params <- function(){

  data.frame(
    start = c(n_1 = 1),
    lower = c(n_1 = 0),
    upper = c(n_1 = 1)
  )

}

