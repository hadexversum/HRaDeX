% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/two_states.R
\name{create_two_state_dataset}
\alias{create_two_state_dataset}
\title{Creates dataset with merged hires parameters for two states.}
\usage{
create_two_state_dataset(hires_params_1, hires_params_2)
}
\arguments{
\item{hires_params_1}{data.frame with hires parameters for the first state}

\item{hires_params_2}{data.frame with hires parameters for the second state}
}
\value{
data.frame for plotting functions
}
\description{
This function merges the hires parameters for two biological
states, provided the same position values. It also calculates the color
distance and estimed k diffrence for each position.
This function is part of comparative feature.
}
\examples{
fit_k_params <- get_example_fit_k_params()
control <- get_example_control()
kin_dat <- prepare_kin_dat(alpha_dat)
fit_values <- create_fit_dataset(kin_dat, fit_k_params, control)
hires_params <- calculate_hires(fit_values)
# same for the second state, and then:
# create_two_state_dataset(hires_params, hires_params_2)

}
\seealso{
calculate_color_distance calculate_hires
}
