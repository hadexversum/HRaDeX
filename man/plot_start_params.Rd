% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plots.R
\name{plot_start_params}
\alias{plot_start_params}
\title{Plots initial fit parameters}
\usage{
plot_start_params(fit_k_params)
}
\arguments{
\item{fit_k_params}{data.frame with k values for exchange groups}
}
\value{
a ggplot2 object.
}
\description{
Plots a visualization of selected excahnge group limits,
with initial parameters for the fit. It is helpful for additional self-control
of chosen limits.
}
\examples{
fit_k_params <- get_example_fit_k_params()
plot_start_params(fit_k_params)

}
