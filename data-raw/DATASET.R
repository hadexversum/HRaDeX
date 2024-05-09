## code to prepare `DATASET` dataset goes here

alpha_dat <- HaDeX::read_hdx("C:/Users/User/Downloads/GAMMAalpha_cut.csv.csv")

usethis::use_data(alpha_dat, overwrite = TRUE)
