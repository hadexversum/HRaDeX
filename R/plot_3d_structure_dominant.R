#' Plot dominant class on 3D structure
#'
#' @examples
#' pdb_file_path <- paste0(system.file(package = "HRaDeX"), "/data/Model_eEF1Balpha.pdb")
#' fit_k_params <- get_example_fit_k_params()
#' control <- get_example_control()
#' kin_dat <- prepare_kin_dat(alpha_dat)
#' fit_values <- create_fit_dataset(kin_dat = kin_dat, control = control, fit_k_params = fit_k_params, fractional = TRUE)
#' hires_params <- calculate_hires(fit_values, method = "weighted", fractional = TRUE)
#' plot_3d_structure_dominant(hires_params = hires_params, pdb_file_path = pdb_file_path)
#'
#'@export

plot_3d_structure_dominant <- function(hires_params,
                                       pdb_file_path){


 hires_params_dom <- get_dominant_class(hires_params)

 color_code <- hires_params_dom[, c("position", "dom_color")]
 color_code[is.na(color_code["dom_color"]), "dom_color"] <- "#D3D3D3"
 color_vector <- paste0("\"", paste0(color_code[["dom_color"]], collapse = "\",\""), "\"")

 structure_obj <- r3dmol::r3dmol(
   viewer_spec = r3dmol::m_viewer_spec(
     cartoonQuality = 10,
     lowerZoomLimit = 50,
     upperZoomLimit = 350
   ),
   id = "hradex_structure",
   elementId = "hradex_structure",
   backgroundColor = "#FFFFFF") %>%
   r3dmol::m_add_model(data = pdb_file_path,
                       format = "pdb") %>%
   r3dmol::m_set_style(
     style = r3dmol::m_style_cartoon(color = "#D3D3D3")) %>%
   r3dmol::m_set_style(
     style = r3dmol::m_style_cartoon(
       colorfunc = paste0("
        function(atom) {
          const color = [", color_vector, "];
          return color[atom.resi];
        }")
     )) %>%
   r3dmol::m_zoom_to() %>%
   r3dmol::m_rotate(angle = 90, axis = "y") %>%
   r3dmol::m_button_spin()

 return(structure_obj)

}
