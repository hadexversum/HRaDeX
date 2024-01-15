#' @import r3dmol
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
    width = 1000,
    height = 1000,
    id = "hradex_structure",
    elementId = "hradex_structure",
    backgroundColor = "0xeeeeee") %>%
    r3dmol::m_add_model(data = pdb_file_path,
                format = "pdb") %>%
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
