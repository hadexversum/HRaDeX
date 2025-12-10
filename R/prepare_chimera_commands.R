#' Prepare coloring commands for ChimeraX
#'
#' @params hires_params hires classification parameters
#' prepared by calculate_hires function
#' @params dominant indicator if only the dominant
#' class colour should be exported
#' @param state biological state
#' @param chain chain for which the coloring
#' commands are created
#'
#' @description
#' This function prepares the coloring commands for ChimeraX.
#' If you wish only to create coloring commands and downlaod them as
#' a text file, see \link{\code{export_chimera_commands}} function.
#'
#' @examples
#' fit_k_params <- get_example_fit_k_params()
#' control <- get_example_control()
#' kin_dat <- prepare_kin_dat(alpha_dat)
#' fit_values <- create_fit_dataset(kin_dat = kin_dat, control = control, fit_k_params = fit_k_params, fractional = TRUE)
#' hires_params <- calculate_hires(fit_values, method = "weighted", fractional = TRUE)
#'
#' prepare_chimera_commands(hires_params, chains = c("A", "G"))
#' prepare_chimera_commands(hires_params, chain = "G", dominant = TRUE)
#'
#' @export

prepare_chimera_commands <- function(hires_params,
                                     dominant = FALSE,
                                     state = hires_params[["State"]][1],
                                     chains = c("A")){

  protein_name <- unique(hires_params[["Protein"]])
  protein_state <- unique(hires_params[["State"]])

  txt_commands <- ""

  lapply(chains, function(chain){
    txt_commands <<- (paste0(txt_commands, "color /", chain, ":", hires_params[["position"]], " ", hires_params[["color"]], " "))
  })

  return(txt_commands)
}

