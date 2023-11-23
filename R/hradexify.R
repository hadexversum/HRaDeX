#' HRaDeX customized ggplot theme
#'
#' @description This function HRaDeXifies plot. It adds HRaDeX logo
#' and ggplot theme.
#'
#' @importFrom magick image_read
#' @importFrom ggplot2 element_text annotation_custom
#'
#' @param plt ggplot object. Plot to HRaDeXify.
#'
#' @details Function adds the logo of HRaDeX package in the left down
#' corner of the plot and the HRaDeX theme.
#' This function is adapted from the HaDeX package.
#'
#' @return a \code{\link{ggplot2}} object.
#'
#' @export hradexify

hradexify <- function(plt) {


  # check
  img <- image_read(system.file(package = "HRaDeX",
                                "HRaDeX/man/figures/logo.png"))

  img <- image_read()
  suppressMessages({
    plt +
      annotation_custom(grid::rasterGrob(img, interpolate = TRUE,
                                         height = 0.05,
                                         x = 0.99, y = 0.01,
                                         hjust = 1, vjust = 0))

  })
}

