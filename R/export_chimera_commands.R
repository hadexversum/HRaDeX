#' Export coloring commands for ChimeraX
#'
#' @examples
#' fit_k_params <- get_example_fit_k_params()
#' control <- get_example_control()
#' kin_dat <- prepare_kin_dat(alpha_dat)
#' fit_values <- create_fit_dataset(kin_dat = kin_dat, control = control, fit_k_params = fit_k_params, fractional = TRUE)
#' hires_params <- calculate_hires(fit_values, method = "weighted", fractional = TRUE)
#'
#' export_chimera_commands(hires_params, chain = "G")
#' export_chimera_commands(hires_params, chain = "G", dominant = TRUE)
#'
#' @export
#'
export_chimera_commands <- function(hires_params,
                                    dominant = FALSE,
                                    state = hires_params[["State"]][1],
                                    chain = "A"){

  protein_name <- unique(hires_params[["Protein"]])
  protein_state <- unique(hires_params[["State"]])

  if(dominant){

    hires_params_dom <- get_dominant_class(hires_params)

    txt <- (paste0("color /", chain, ":", hires_params_dom[["position"]], " ", hires_params_dom[["dom_color"]]))

  } else {

    txt <- (paste0("color /", chain, ":", hires_params[["position"]], " ", hires_params[["color"]]))

  }

  writeLines(txt, paste0(protein_name, "-", protein_state, ".txt"))

  }
