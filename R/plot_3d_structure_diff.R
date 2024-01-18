#' @import r3dmol
#'
#' @export

plot_3d_structure_blank <- function(pdb_file_path){

  structure_obj <- r3dmol::r3dmol(
    viewer_spec = r3dmol::m_viewer_spec(
      cartoonQuality = 10,
      lowerZoomLimit = 50,
      upperZoomLimit = 350
    ),
    id = "blank_structure",
    elementId = "blank_structure",
    backgroundColor = "0xeeeeee") %>%
    r3dmol::m_add_model(data = pdb_file_path,
                        format = "pdb") %>%
    r3dmol::m_set_style(
      style = r3dmol::m_style_cartoon(color = "white")) %>%
    r3dmol::m_zoom_to()

  return(structure_obj)
}


#'
#'
#' @export

prepare_diff_data <- function(params,
                              value,
                              threshold){

  show_params <- params[params[[value]] > threshold, ]

  if("position" %in% names(show_params))
    return(show_params[["position"]])

  if("Start" %in% names(show_params)){

    show_params %>%
      mutate(pos = list(Start:End)) %>%
      dplyr::ungroup(.) %>%
      select(pos) %>%
      .[[1]] %>%
      unlist(.) %>%
      unique(.)

    }

}
