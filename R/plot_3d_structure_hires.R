#' @importFrom r3dmol r3dmol m_rotate
#'
#' @export

plot_3d_structure_hires <- function(hires_params,
                                    pdb_file_path,
                                    spin = T){

  color_code <- hires_params[, c("position", "color")]
  color_code[is.na(color_code["color"]), "color"] <- "#D3D3D3"
  color_vector <- paste0("\"", paste0(color_code[["color"]], collapse = "\",\""), "\"")

  structure_obj <- r3dmol(
    viewer_spec = m_viewer_spec(
      cartoonQuality = 10,
      lowerZoomLimit = 50,
      upperZoomLimit = 350
    ),
    id = "hradex_structure",
    elementId = "hradex_structure",
    width = 400,
    height = 400,
    backgroundColor = "0xeeeeee") %>%
    m_add_model(data = pdb_file_path,
                format = "pdb") %>%
    m_set_style(
      style = m_style_cartoon(
        colorfunc = paste0("
        function(atom) {
          const color = [", color_vector, "];
          return color[atom.resi];
        }")
      )) %>%
    m_zoom_to() %>%
    m_rotate(angle = 90, axis = "y")

  if(spin) structure_obj <- structure_obj %>% m_spin()

  return(structure_obj)
}
