#' @export

plot_k_distance <- function(two_state_dataset,
                            interactive = F){

  protein_length <- max(two_state_dataset[["position"]])

  if(interactive){
    sel_points <- geom_point_interactive(aes(x = position, y = k_diff,
                                             tooltip = glue("Position: {position}
                                                            K diff  = {formatC(k_diff, 2)}")))
  } else {
    sel_points <- geom_point(aes(x = position, y = k_diff))
  }

  plt <- ggplot(two_state_dataset) +
    sel_points +
    labs(title = "Distance between estimated k",
         x = "Position",
         y = "K difference") +
    coord_cartesian(x = c(0, protein_length+1)) +
    theme_bw(base_size = 18)

  girafe(ggobj = plt,
         width_svg = 10,
         height_svg = 4)
}

#' @export

plot_uc_real_dist <- function(uc_distance_dataset,
                              squared = F,
                              fractional = T,
                              interactive = F){

  y_axis_label <- ""

  protein_length <- max(uc_distance_dataset[["End"]])

  if(fractional){

    y_axis_label <- "Frac uptake diff [%]"

    if(squared) {
      uc_distance_dataset <- mutate(uc_distance_dataset,
                                    frac_uptake_dist = frac_uptake_dist^2)

      y_axis_label <- "Frac uptake diff ^2 [%]"
    }

    if(interactive){
      sel_segment <- geom_segment_interactive(aes(x = Start, xend = End, y = frac_uptake_dist, yend = frac_uptake_dist,
                                                  tooltip = glue("Sequence: {Sequence}
                                                                Position: {Start}-{End}
                                                               Diff = {formatC(frac_uptake_dist, 2)}")))
    } else {
      sel_segment <- geom_segment(aes(x = Start, xend = End, y = frac_uptake_dist, yend = frac_uptake_dist))
    }

  } else {

    y_axis_label <- "Uptake diff [Da]"

    if(squared) {
      uc_distance_dataset <- mutate(uc_distance_dataset,
                                    uptake_dist = uptake_dist^2)
      y_axis_label <- "Uptake diff ^2 [Da]"
    }

    if(interactive){
      sel_segment <- geom_segment_interactive(aes(x = Start, xend = End, y = uptake_dist, yend = uptake_dist,
                                                  tooltip = glue("Sequence: {Sequence}
                                                                Position: {Start}-{End}
                                                               Diff = {formatC(uptake_dist, 2)}")))
    } else {
      sel_segment <- geom_segment(aes(x = Start, xend = End, y = uptake_dist, yend = uptake_dist))
    }


  }

  plt <- ggplot(uc_distance_dataset) +
    sel_segment +
    labs(title = "Distances between uptake points",
         x = "Position",
         y = y_axis_label) +
    coord_cartesian(x = c(0, protein_length+1)) +
    theme_bw(base_size = 18)

  girafe(ggobj = plt,
         width_svg = 10,
         height_svg = 4)

}

