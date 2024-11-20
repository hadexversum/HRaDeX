#' Create fits for the whole peptide pool
#'
#' @importFrom dplyr bind_rows
#'
#' @param kin_dat calculated uptake data for
#' one biological state, result of e.q.
#' \code{\link{prepare_kin_dat}}
#' @param fit_k_params boundaries for exchange
#' groups, example in prepare_kin_dat
#' @param control control options for the fitting process,
#' example in \code{\link{get_example_control}}
#' @param trace logical, indicator if fitting trace is to
#' be displayed
#' @param fractional logical, indicator if normalized values
#' are used in the fitting process
#' @param workflow workflow type, options: 321, 31, 21, indicating
#' the types of functions used in fitting process
#'
#' @description
#' This function calls the fitting function \code{\link{get_fit_results}}
#' for each peptide in supplied kin_dat creating the dataset for whole
#' peptide pool.
#'
#' @return a data.frame object.
#'
#' @seealso
#' \code{\link{get_fit_results}}
#' \code{\link{prepare_kin_dat}}
#' \code{\link{get_example_fit_k_params}}
#' \code{\link{get_example_control}}
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
