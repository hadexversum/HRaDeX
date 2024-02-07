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
                              interactive = F){

  if(interactive){
    sel_segment <- geom_segment_interactive(aes(x = Start, xend = End, y = frac_uptake_dist, yend = frac_uptake_dist,
                                                tooltip = glue("Sequence: {Sequence}
                                                                Position: {Start}-{End}
                                                               Diff = {formatC(frac_uptake_dist, 2)}")))
  } else {
    sel_segment <- geom_segment(aes(x = Start, xend = End, y = frac_uptake_dist, yend = frac_uptake_dist))
  }

  plt <- ggplot(uc_distance_dataset) +
    sel_segment +
    labs(title = "Distances between uptake points",
         x = "Position",
         y = "Frac uptake diff")+
    theme_bw(base_size = 18)

  girafe(ggobj = plt,
         width_svg = 10,
         height_svg = 4)

}

