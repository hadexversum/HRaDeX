#' @importFrom dplyr reframe
#' @export

calculate_hires <- function(fit_values,
                            method = c("shortest", "weighted"),
                            protein_length = max(fit_values[["end"]]),
                            fractional = F){

  Protein = fit_values[["Protein"]][1]
  State = fit_values[["State"]][1]

  hires_params <- NULL

  if (method == "shortest"){

    hires_params <- lapply(seq(1:protein_length), function(pos){

      if(fractional){

        tmp_params <- fit_values %>%
          filter(start <= pos & pos <= end & n_1 + n_2 + n_3 < 1.25)

      } else {

        tmp_params <- fit_values %>%
          filter(start <= pos & pos <= end & n_1 + n_2 + n_3 - max_uptake <= 0)


      }

      tmp_params <- tmp_params %>%
        arrange(nchar(sequence), class_name) %>%
        .[1, ]

      if(nrow(tmp_params) == 0){

        data.frame(Protein = Protein,
                   State = State,
                   position = pos,
                   n_1 = NA,
                   n_2 = NA,
                   n_3 = NA,
                   k_est = NA,
                   class_name = NA,
                   color = NA)
      } else {

        data.frame(Protein = Protein,
                   State = State,
                   position = pos,
                   n_1 = tmp_params[["n_1"]],
                   n_2 = tmp_params[["n_2"]],
                   n_3 = tmp_params[["n_3"]],
                   k_est = tmp_params[["k_est"]],
                   class_name = tmp_params[["class_name"]],
                   color = tmp_params[["color"]])
      }

    }) %>% bind_rows()

  }

  if(method == "weighted"){

    hires_params <- lapply(seq(1:protein_length), function(pos){

      # print(pos)
      if(fractional){

        tmp_params <- fit_values %>%
          filter(start <= pos & pos <= end & n_1 + n_2 + n_3 < 1.25)


      } else {

        tmp_params <- fit_values %>%
          filter(start <= pos & pos <= end & n_1 + n_2 + n_3 - max_uptake <= 0)


      }


      if(nrow(tmp_params) == 0){

        res <- data.frame(Protein = Protein,
                   State = State,
                   position = pos,
                   n_1 = NA,
                   n_2 = NA,
                   n_3 = NA,
                   k_est = NA,
                   class_name = NA,
                   color = NA)
      } else {

        if(any(!is.na(tmp_params["class_name"]))){

          class_example <- tmp_params[!is.na(tmp_params[["class_name"]]), ][1, ]

          res <- data.frame(Protein = Protein,
                     State = State,
                     position = pos,
                     n_1 = NA,
                     n_2 = NA,
                     n_3 = NA,
                     k_est = NA,
                     class_name = class_example[["class_name"]],
                     color = class_example[["color"]])

        } else {

          res <- tmp_params %>%
            mutate(length = nchar(sequence),
                   weight = 1/max_uptake/sum(1/max_uptake)) %>%
            reframe(Protein = Protein,
                    State = State,
                    position = pos,
                    n_1 = weighted.mean(n_1, weight),
                    n_2 = weighted.mean(n_2, weight),
                    n_3 = weighted.mean(n_3, weight),
                    k_est = weighted.mean(k_est, weight),
                    class_name = NA,
                    n = n_1 + n_2 + n_3,
                    color = rgb(n_1/n, n_2/n, n_3/n)) %>%
            unique(.) %>%
            select(-n)

        }



      }

      res

    }) %>% bind_rows()

   }

  attr(hires_params, "method") <- method

  return(hires_params)



}
