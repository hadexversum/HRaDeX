#' Create fits for all the peptides
#'
#' @importFrom dplyr bind_rows
#'
#' @param kin_dat ...
#' @param fit_k_params ...
#' @param control ...
#' @param trace ...
#' @param fractional ...
#' @param workflow ...
#'
#' @description This is a wrapper function for get_fit_results, but for multiple peptides at
#' the same time. First, it creates a peptide list from the supplied deuterium uptake data, and
#' calls the fitting function for each, to create full dataset.
#'
#' @return a data.frame object.
#'
#' @seealso get_fit_results
#'
#' @examples
#' kin_dat <- prepare_kin_dat(alpha_dat)
#' fit_k_params <- get_example_fit_k_params()
#' head(create_fit_dataset(kin_dat, fit_k_params))
#'
#' @export
create_fit_dataset <- function(kin_dat,
                               fit_k_params,
                               control = list(maxiter = 1000,  scale = "levenberg"),
                               trace = FALSE,
                               fractional = FALSE,
                               omit_t_100 = FALSE,
                               workflow = 321){

  peptide_list <- kin_dat %>%
    select(Sequence, Start, End) %>%
    unique(.)

  edge_times <- c(min(kin_dat[["Exposure"]]), max(kin_dat[["Exposure"]]))

  apply(peptide_list, 1, function(peptide){

    filter(kin_dat, Sequence == peptide[[1]],
                    Start == as.numeric(peptide[[2]]),
                    End == as.numeric(peptide[[3]])) %>%
    get_fit_results(fit_dat = .,
                    fit_k_params = fit_k_params,
                    control = control,
                    trace = trace,
                    workflow = workflow,
                    fractional = fractional,
                    omit_t_100 = omit_t_100,
                    edge_times = edge_times)
  }) %>% bind_rows() %>% mutate(id = 1:nrow(.)) %>% remove_rownames(.) %>%
    select(id, everything())

}
