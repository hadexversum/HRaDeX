#' Wrapper for interactivity
#'
#' @importFrom ggiraph girafe opts_hover opts_sizing opts_hover_inv
#'
#' @description Currently not in use.
#'
#' @export plot_interactive

plot_interactive <- function(plot_function, ...){

  girafe(ggobj = plot_function(interactive = T, ...),
         options = list(
           opts_hover(css = ''),
           opts_sizing(rescale = TRUE),
           opts_hover_inv(css = "opacity:0.1;")
         ))

}


