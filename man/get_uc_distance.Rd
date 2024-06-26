% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/two_states.R
\name{get_uc_distance}
\alias{get_uc_distance}
\title{Calculates the uc distance for uptake curve}
\usage{
get_uc_distance(fit_dat_1, fit_dat_2)
}
\arguments{
\item{fit_dat_1}{data.frame with uc data for peptide in first state}

\item{fit_dat_2}{data.frame with uc data for peptide in second state}
}
\value{
a one-row data.frame
}
\description{
Calculates the uc distance between uptake curves for one peptide in two
biological states. The possible methods of caluclation is described in the
vignette TODO.
This function supports comparison of two different peptides provided that the
values \code{Start}, \code{End}, \code{MaxUptake} and \code{Exposure} are the same.
}
\examples{
kin_dat_1 <- prepare_kin_dat(alpha_dat, state = unique(alpha_dat[["State"]])[1])
kin_dat_2 <- prepare_kin_dat(alpha_dat, state = unique(alpha_dat[["State"]])[2])
fit_dat_1 <- kin_dat_1[kin_dat_1[["ID"]] == 1, ]
fit_dat_2 <- kin_dat_2[kin_dat_2[["ID"]] == 1, ]
get_uc_distance(fit_dat_1, fit_dat_2)

}
\seealso{
create_uc_distance_dataset
}
