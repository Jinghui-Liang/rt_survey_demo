# WHEN THIS IS DONE, COPY TO `make_scale.R` AND DELETE THIS

if (interactive()) {
  dat <- tibble::as_tibble (read.csv (
    '../scalepool/fullScale.csv',
    header = TRUE,
    na.strings = ""
  ))
} else {
  print ("under development")
}

# split out questionnaire part
quest <- dat[, c("question", "q_choices", "q_required")]
colnames(quest)[colnames(quest) == "question"] <- "prompt"
colnames(quest)[colnames(quest) == "q_choices"] <- "choices"

if (!all(quest$q_required %in% c('y', 'n'))) {
  stop ("Column q_required not properly defined.")
}

if (!is.na(quest$choices[1])) {
  if (sum (is.na(quest$choices)) == 0) {
    quest_js <- quest |>
      dplyr::mutate (choices = purrr::map(quest$choices,
                                   \(.x) unlist (strsplit(.x, split = "/"))))
  } else if (sum (is.na(quest$choices)) == length (quest$choices) - 1) {
    quest_js <- quest |> 
      dplyr::mutate (choices = strsplit(quest$choices[1], split = "/"))
  } else {
    stop ('Column "q_hoices" not properly defined.')
  }
}

scaleJSON <- jsonlite::toJSON(quest_js, pretty = TRUE)

demo <- dat[, c("demo_info", "d_choices", "d_required")] |> 
  dplyr::filter(demo_info != "NA")






