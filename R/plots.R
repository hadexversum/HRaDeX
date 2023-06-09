#' @importFrom ggplot2 ggplot geom_tile theme labs
#' @export
plot_class_heatmap <- function(fixed_params){

  ggplot(fixed_params, aes(x = id, y = 1)) +
    geom_tile(fill = fixed_params[["color"]]) +
    theme(legend.position = "none",
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank()) +
    labs(y = "",
         title = "class components")


}

#' @importFrom ggplot2 geom_line ylim
#' @export
plot_start_params <- function(fit_k_params){

  x = seq(1, 1500, 1)

  ggplot()+
    geom_line(aes(x = x , y = 0.33*(1-exp(-fit_k_params["k_1", "start"]*x)) ), color = "red") +
    geom_line(aes(x = x , y = 0.33*(1-exp(-fit_k_params["k_2", "start"]*x)) ), color = "green") +
    geom_line(aes(x = x , y = 0.33*(1-exp(-fit_k_params["k_3", "start"]*x)) ), color = "blue") +
    geom_line(aes(x = x, y = 0.33*(1-exp(-fit_k_params["k_1", "start"]*x)) + 0.33*(1-exp(-fit_k_params["k_2", "start"]*x)) + 0.33*(1-exp(-fit_k_params["k_3", "start"]*x)))) +
    ylim(c(0, 1)) +
    labs(x = "Exposure",
         y = "Start for fractional deuterium uptake")

}

#' @importFrom ggplot2 scale_x_log10 scale_y_log10 geom_hline geom_point geom_vline
#' @importFrom dplyr case_when
#' @export
plot_3_exp_map_v2 <- function(fixed_params){

  fixed_params %>%
    filter(is.na(class_name)) %>%
    mutate(dom_exp = case_when(
      n_3 > n_1 & n_3 > n_2 ~ k_3,
      n_2 > n_1 & n_2 > n_3 ~ k_2,
      n_1 > n_2 & n_1 > n_3 ~ k_1,
      T ~ -1
    )) %>%
    mutate(sec_dom_exp = case_when(
      n_2 < n_1 & n_2 > n_3 ~ k_2,
      n_3 < n_1 & n_3 > n_2 ~ k_3,
      n_1 < n_2 & n_1 > n_3 ~ k_1,
      n_3 < n_2 & n_3 > n_1 ~ k_3,
      n_1 < n_3 & n_1 > n_2 ~ k_1,
      n_2 < n_3 & n_2 > n_1 ~ k_2,
      T ~ -1
    )) %>%
    ggplot(aes(x = dom_exp, y = sec_dom_exp)) +
    geom_point() +
    labs(title = "three types of n(1-exp(-kt))",
         x = "k for dom n",
         y = "k for 2 dom n") +
    scale_x_log10() +
    scale_y_log10() +
    geom_hline(yintercept = 0.1, color = "red", linetype = "dashed") +
    geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
    geom_hline(yintercept = 1, color = "red", linetype = "dashed") +
    geom_vline(xintercept = 0.1, color = "red", linetype = "dashed") +
    geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
    geom_vline(xintercept = 1, color = "red", linetype = "dashed")

}

#' @importFrom ggplot2 xlim theme_void geom_text
#' @export
get_params_summary_image <- function(fixed_params){

  n_total <- nrow(fixed_params)

  n_three <- fixed_params %>%
    filter(fitted == 3 & is.na(class_name)) %>%
    nrow(.)

  n_one <- fixed_params %>%
    filter(fitted == 1 & is.na(class_name)) %>%
    nrow(.)

  n_class_name <- fixed_params %>%
    filter(!is.na(class_name)) %>%
    nrow(.)

  ggplot(data.frame(n_total, n_three)) +
    xlim(c(0, 1)) +
    ylim(c(-0.5, 0.75)) +
    geom_text(x = 0.5, y = 0.55, label = paste0("total:   ", n_total)) +
    geom_text(x = 0.5, y = 0.4, label = paste0("fitted three:   " , n_three )) +
    geom_text(x = 0.5, y = 0.25, label = paste0("fitted one:   " , n_one)) +
    geom_text(x = 0.5, y = 0.1, label = paste0("plaszczak/szybciak:   " , n_class_name)) +
    theme_void()
}


#' @importFrom ggplot2 geom_rect aes element_blank
#' @export
plot_cov_class <- function(fixed_params){


  ## levels
  levels <- rep(NA, (nrow(fixed_params)))
  levels[1] <- 1
  start <- fixed_params[["start"]]
  end <- fixed_params[["end"]]

  for(i in 1:(nrow(fixed_params) - 1)) {
    for(level in 1:max(levels, na.rm = TRUE)) {
      if(all(start[i + 1] > end[1:i][levels == level] | end[i + 1] < start[1:i][levels == level], na.rm = TRUE)) {
        levels[i + 1] <- level
        break
      } else {
        if(level == max(levels, na.rm = TRUE)) {
          levels[i + 1] <- max(levels, na.rm = TRUE) + 1
        }
      }
    }
  }

  fixed_params[["ID"]] <- levels

  fixed_params <- fixed_params %>%
    mutate(alpha = case_when( n_1 + n_2 + n_3 > 1.25 ~ 0.5, T ~  1))
  ## end of levels

  ggplot(data = fixed_params,
         mapping = aes(xmin = start, xmax = end + 1,
                       ymin = ID, ymax = ID - 1)) +
    geom_rect(fill = fixed_params[["color"]],
              alpha = fixed_params[["alpha"]]) +
    theme(legend.position = "bottom",
          axis.ticks.y = element_blank(),
          axis.text.y = element_blank()) +
    labs(title = "class components on coverage",
         x = "Position") +
    theme_bw()

}

#' @importFrom ggplot2 facet_wrap geom_histogram
#' @export
plot_r2_hist <- function(fixed_params){

  fixed_params %>%
    filter(is.na(class_name)) %>%
    ggplot() +
    geom_histogram(aes(x = r2)) +
    labs(fill = "exp") +
    facet_wrap(~ fitted, ncol = 1)
}

#' @export
plot_n <- function(fixed_params){

  fixed_params %>%
    mutate(n = n_1 + n_2 + n_3,
           diff = abs(1 - n)) %>%
    filter(is.na(class_name)) %>%
    ggplot() +
    geom_point(aes(x = id, y = diff)) +
    labs(title = "abs(1-n) without class name")

}
