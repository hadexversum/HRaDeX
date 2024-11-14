#' @importFrom dplyr reframe
#'
#' @examples
#' kin_dat <- HRaDeX::prepare_kin_dat(alpha_dat,
#'                                    state = "Alpha_KSCN",
#'                                    time_0 = 0,
#'                                    time_100 = 1440)
#' fit_values <- create_fit_dataset(kin_dat,
#'                                  fit_k_params = get_example_fit_k_params())
#' calculate_hires(fit_values, method = "shortest")
#' @export

calculate_hires <- function(fit_values,
                            method = c("shortest", "weighted"),
                            protein_length = max(fit_values[["end"]]),
                            fractional = F){

  Protein = fit_values[["Protein"]][1]
  State = fit_values[["State"]][1]

  residues <- get_residue_positions(fit_values)

  hires_params_ <- NULL

  if (method == "shortest"){

    hires_params_ <- lapply(seq(1:protein_length), function(pos){

      if(fractional){

        tmp_params <- fit_values %>%
          filter(start <= pos & pos <= end & n_1 + n_2 + n_3 < 1.25)

      } else {

        tmp_params <- fit_values %>%
          filter(start <= pos & pos <= end & n_1 + n_2 + n_3 - max_uptake <= 0)


      }

      tmp_params <- tmp_params %>%
        filter(!class_name %in% c("invalid", "invalid_uc")) %>%
        arrange(nchar(sequence), class_name) %>%
        .[1, ]

      if(nrow(tmp_params) == 0){

        data.frame(Protein = Protein,
                   State = State,
                   position = pos,
                   n_1 = NA,
                   k_1 = NA,
                   n_2 = NA,
                   k_2 = NA,
                   n_3 = NA,
                   k_3 = NA,
                   k_est = NA,
                   class_name = NA,
                   color = NA)
      } else {

        data.frame(Protein = Protein,
                   State = State,
                   position = pos,
                   n_1 = tmp_params[["n_1"]],
                   k_1 = tmp_params[["k_1"]],
                   n_2 = tmp_params[["n_2"]],
                   k_2 = tmp_params[["k_2"]],
                   n_3 = tmp_params[["n_3"]],
                   k_3 = tmp_params[["k_3"]],
                   k_est = tmp_params[["k_est"]],
                   class_name = tmp_params[["class_name"]],
                   color = tmp_params[["color"]])
      }

    }) %>% bind_rows()

  }

  if(method == "weighted"){

    hires_params_ <- lapply(seq(1:protein_length), function(pos){

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
                   k_1 = NA,
                   n_2 = NA,
                   k_2 = NA,
                   n_3 = NA,
                   k_3 = NA,
                   k_est = NA,
                   class_name = NA,
                   color = NA)
      } else {

        if(any(!is.na(tmp_params["class_name"]))){

          class_example <- tmp_params[!is.na(tmp_params[["class_name"]]), ][1, ]

          res <- data.frame(Protein = Protein,
                     State = State,
                     position = pos,
                     n_1 = class_example[["n_1"]],
                     k_1 = class_example[["k_1"]],
                     n_2 = class_example[["n_2"]],
                     k_2 = class_example[["k_3"]],
                     n_3 = class_example[["n_3"]],
                     k_3 = class_example[["k_3"]],
                     k_est = class_example[["k_est"]],
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
                    k_1 = weighted.mean(k_1, weight),
                    n_2 = weighted.mean(n_2, weight),
                    k_2 = weighted.mean(k_2, weight),
                    n_3 = weighted.mean(n_3, weight),
                    k_3 = weighted.mean(k_3, weight),
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

  hires_params <- merge(hires_params_, residues, by = "position", all.x = TRUE)

  hires_params_p <- hires_params %>%
    filter(aa == "P") %>%
    mutate(n_1 = 0,
           k_1 = 0,
           n_2 = 0,
           k_2 = 0,
           n_3 = 0,
           k_3 = 0,
           k_est = 0,
           class_name = "none",
           color = "#000000")

  hires_params <- filter(hires_params, aa!="P" | is.na(aa)) %>%
    rbind(hires_params_p) %>%
    arrange(position)

  attr(hires_params, "method") <- method

  return(hires_params)



}
