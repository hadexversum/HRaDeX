#' Presents classification results on 3D structure
#'
#' @import r3dmol
#'
#' @param hires_params ...
#' @param pdb_file_path ...
#'
#' @description Plots the color classification on supplied 3d structure.
#'
#' @return a r3dmol object.
#'
#' @seealso calculate_hires
#'
#' @examples
#' pdb_file_path <- ...
#' fit_k_params <- get_example_fit_k_params()
#' control <- get_example_control()
#' kin_dat <- prepare_kin_dat(dat)
#' fit_values <- create_fit_dataset(alpha, control, fit_k_params)
#' hires_params <- calculate_hires(fit_values)
#' plot_3d_structure_hires(hires_params, pdb_file_path)
#'
#' @export

plot_3d_structure_hires <- function(hires_params,
                                    pdb_file_path){

  color_code <- hires_params[, c("position", "color")]
  color_code[is.na(color_code["color"]), "color"] <- "#D3D3D3"
  color_vector <- paste0("\"", paste0(color_code[["color"]], collapse = "\",\""), "\"")

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
