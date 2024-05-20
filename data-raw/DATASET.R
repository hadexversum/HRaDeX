## code to prepare `DATASET` dataset goes here

gamma_dat <- HaDeX::read_hdx("C:/Users/User/Downloads/GAMMAalpha_cut.csv.csv")
alpha_dat <- HaDeX::read_hdx("C:/Users/User/Desktop/article_hradex/ALPHA G i BG.csv")

usethis::use_data(alpha_dat, overwrite = TRUE)
usethis::use_data(gamma_dat, overwrite = TRUE)
