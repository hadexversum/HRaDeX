#' @export

get_fit_values_info <- function(fixed_params){

  n_total <- nrow(fixed_params)

  n_three <- fixed_params %>%
    filter(fitted == 3 & is.na(class_name)) %>%
    nrow(.)

  n_two <- fixed_params %>%
    filter(fitted == 2 & is.na(class_name)) %>%
    nrow(.)

  n_one <- fixed_params %>%
    filter(fitted == 1 & is.na(class_name)) %>%
    nrow(.)

  n_class_name <- fixed_params %>%
    filter(!is.na(class_name)) %>%
    nrow(.)

  paste0("Number of peptides: ", n_total, "\n",
         "Extreme cases: ", n_class_name, "\n",
         "Fitted three exponents: ", n_three, "\n",
         "Fitted two exponents: ", n_two, "\n",
         "Fitted one exponent: ", n_one, "\n")
}
