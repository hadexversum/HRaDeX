#' Plots blank 3D structure
#'
#' @import r3dmol
#'
#' @param pdb_file_path ...
#'
#' @description Plots blank 3D strucutre of the protein. This function is the base line
#' for the presentation of the differences in compahradex.
#'
#' @return a r3dmol object.
#'
#' @seealso plot_3d_structure_hires
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
    backgroundColor = "#FFFFFF") %>%
    r3dmol::m_add_model(data = pdb_file_path,
                        format = "pdb") %>%
    r3dmol::m_set_style(
      style = r3dmol::m_style_cartoon(color = "white")) %>%
    r3dmol::m_zoom_to()

  return(structure_obj)
}


#' Prepares differential data
#'
#' @param params values to be presented.
#' @param value which value should be presented.
#' @param threshold threshold for the values.
#'
#' @description Function prepares the results in a format that can be used
#' for 3D presentation. It transforms the peptide data into resiudal data, with regard
#' to the original values above the threshold.
#'
#' @return a data.frame object.
#'
#' @seealso plot_3d_structure_blank
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
