#'
#'
#' @export calculate_color_distance

calculate_color_distance <- function(color_1,
                                     color_2){

  rgb_1 =  col2rgb(color_1)/255
  rgb_2 =  col2rgb(color_2)/255

  dist_2 = (rgb_1["red", ] - rgb_2["red", ])^2 + (rgb_1["blue", ] - rgb_2["blue", ])^2 + (rgb_1["green", ] - rgb_2["green", ])^2
  dist = sqrt(dist_2)
  return(dist)

}
