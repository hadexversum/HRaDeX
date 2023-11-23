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

#' @importFrom ggplot2 geom_line ylim geom_ribbon
#' @export
plot_start_params <- function(fit_k_params){

  x = seq(0, 1500, 0.025)

  ggplot() +
    geom_line(aes(x = x, y = 0.33*(1-exp(-fit_k_params[1, "start"]*x))), color = "red") +
    geom_ribbon(aes(x = x, ymin=0.33*(1-exp(-fit_k_params[1, "lower"]*x)), ymax=0.33*(1-exp(-fit_k_params[1, "upper"]*x))), fill = "red", alpha = 0.1) +
    geom_line(aes(x = x, y = 0.33*(1-exp(-fit_k_params[2, "start"]*x))), color = "green") +
    geom_ribbon(aes(x = x, ymin=0.33*(1-exp(-fit_k_params[2, "lower"]*x)), ymax=0.33*(1-exp(-fit_k_params[2, "upper"]*x))), fill = "green", alpha = 0.1) +
    geom_line(aes(x = x, y = 0.33*(1-exp(-fit_k_params[3, "start"]*x))), color = "blue") +
    geom_ribbon(aes(x = x, ymin=0.33*(1-exp(-fit_k_params[3, "lower"]*x)), ymax=0.33*(1-exp(-fit_k_params[3, "upper"]*x))), fill = "blue", alpha = 0.1)+
    ylim(c(0, .35)) +
    scale_x_log10() +
    theme_bw(base_size = 18) +
    labs(x = "Exposure",
         y = "Initial exchange values with bounds")
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
    theme_gray(base_size = 18) +
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




#' @importFrom ggplot2 facet_wrap geom_histogram
#' @export
plot_rss_hist <- function(fixed_params){

  fixed_params %>%
    filter(is.na(class_name)) %>%
    ggplot() +
    geom_histogram(aes(x = rss)) +
    labs(fill = "exp") +
    theme_gray(base_size = 18) +
    facet_wrap(~ fitted, ncol = 1)
}

#' @export
plot_n <- function(list_params,
                   fractional = F){

  if(fractional){

    list_params %>%
      mutate(n = n_1 + n_2 + n_3) %>%
      filter(is.na(class_name)) %>%
      ggplot() +
      geom_point(aes(x = id, y = n)) +
      labs(title = "n without class name") +
      theme_gray(base_size = 18) +
      geom_hline(yintercept = 1.25, linetype = 2) +
      ylim(c(0, NA))

  } else {

    list_params %>%
      filter(is.na(class_name)) %>%
      mutate(n = (n_1 + n_2 + n_3) / max_uptake) %>%
      ggplot() +
      geom_point(aes(x = id, y = n)) +
      labs(title = "n without class name",
           y = "n/max_uptake") +
      theme_gray(base_size = 18) +
      geom_hline(yintercept = 1, linetype = 2) +
      ylim(c(0, 1.25))
  }

}
