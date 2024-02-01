#' @export

move_dataset <-  function(dat,
                          move = 0){
  dat %>%
    mutate(Start = Start + move,
           End = End + move) %>%
    filter(Start > 0)

}
