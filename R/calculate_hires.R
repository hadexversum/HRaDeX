#'
#' @export

calculate_hires <- function(fit_values,
                            method = c("shortest", "weiss")){

  length = max(fit_values[["end"]])

  hires_params <- lapply(seq(1:length), function(pos){

    tmp_params <- fit_values %>%
      filter(start <= pos & pos <= end & n_1 + n_2 + n_3 < 1.25) %>%
      arrange(class_name, nchar(sequence)) %>%
      .[1, ]

    if(nrow(tmp_params) == 0){

      data.frame(position = pos,
                 n_1 = NA,
                 n_2 = NA,
                 n_3 = NA,
                 class_name = NA,
                 color = NA)

    } else {

      data.frame(position = pos,
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



