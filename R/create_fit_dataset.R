#' @importFrom dplyr bind_rows
#' @export
create_fit_dataset <- function(kin_dat,
                               fit_k_params,
                               control = list(maxiter = 1000,  scale = "levenberg"),
                               trace = F,
                               fractional = F,
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
                    edge_times = edge_times)
  }) %>% bind_rows() %>% mutate(id = 1:nrow(.)) %>% remove_rownames(.) %>%
    select(id, everything())

}
