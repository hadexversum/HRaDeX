#' Get get dominant class and color from hires data
#'
#' @examples
#' fit_k_params <- get_example_fit_k_params()
#' control <- get_example_control()
#' kin_dat <- prepare_kin_dat(alpha_dat)
#' fit_values <- create_fit_dataset(kin_dat = kin_dat, control = control, fit_k_params = fit_k_params, fractional = TRUE)
#' hires_params <- calculate_hires(fit_values, method = "weighted", fractional = TRUE)
#' hires_params_dom <- get_dominant_class(hires_params)
#'
#' @export

get_dominant_class <- function(hires_params){

  hires_params_dom <- hires_params %>%
    mutate(dom_class = case_when(
      n_1 > n_2 & n_1 > n_3 ~ 1,
      n_2 > n_1 & n_2 > n_3 ~ 2,
      n_3 > n_1 & n_3 > n_2 ~ 3,
      class_name == "none" ~ 0,
      TRUE ~ NA
    )) %>%
    mutate(
      dom_color = case_when(
        dom_class == 1 ~ "#FF0000",
        dom_class == 2 ~ "#00FF00",
        dom_class == 3 ~ "#0000FF",
        dom_class == 0 ~ "#000000"
      )
    )

  return(hires_params_dom)

  }
