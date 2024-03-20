#' @export

run_hradex <- function(){

  if(!require(HRaDeXGUI)) devtools::install_github("https://github.com/hadexversum/HRaDeXGUI/")

  HRaDeXGUI::run_app()

}

#' @export
run_compahradex <- function(){

  if(!require(compahradex)) devtools::install_github("https://github.com/hadexversum/compahradex/")

  compahradex::run_app()

}
