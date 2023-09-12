#'
#' @export

calculate_hires <- function(fit_values,
                            method = c("shortest", "weiss"),
                            fractional = F){

  length = max(fit_values[["end"]])

  Protein = fit_values[["Protein"]][1]
  State = fit_values[["State"]][1]

  hires_params <- lapply(seq(1:length), function(pos){

    if(fractional){
      tmp_params <- fit_values %>%
        filter(start <= pos & pos <= end & n_1 + n_2 + n_3 < 1.25) %>%
        arrange(nchar(sequence), class_name) %>%
        .[1, ]
    } else {
      tmp_params <- fit_values %>%
        filter(start <= pos & pos <= end & n_1 + n_2 + n_3 - max_uptake <= 0) %>%
        arrange(nchar(sequence), class_name) %>%
        .[1, ]
    }

    if(nrow(tmp_params) == 0){

      data.frame(Protein = Protein,
                 State = State,
                 position = pos,
                 n_1 = NA,
                 n_2 = NA,
                 n_3 = NA,
                 class_name = NA,
                 color = NA)
    } else {

      data.frame(Protein = Protein,
                 State = State,
                 position = pos,
                 n_1 = tmp_params[["n_1"]],
                 n_2 = tmp_params[["n_2"]],
                 n_3 = tmp_params[["n_3"]],
                 class_name = tmp_params[["class_name"]],
                 color = tmp_params[["color"]])
    }
  }) %>% bind_rows()

  attr(hires_params, "method") <- "shortest"

  return(hires_params)

}
