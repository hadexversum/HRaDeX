#' @export

get_fit_values_info <- function(fixed_params){

  n_total <- nrow(fixed_params)

  n_invalid <- fixed_params %>%
    filter(class_name == "invalid") %>%
    nrow(.)

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
         "Invalid peptide data: ", n_invalid, "\n",
         "Extreme cases: ", n_class_name - n_invalid, "\n",
         "Fitted three exponents: ", n_three, "\n",
         "Fitted two exponents: ", n_two, "\n",
         "Fitted one exponent: ", n_one, "\n")
}
