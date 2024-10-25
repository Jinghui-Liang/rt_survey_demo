if (file.exists ("/.dockerenv")) {
  questPath <- paste0("/var/scalepool/", quest_name)
  outputDir <- "/var/www/html/"
} else {
  if (interactive()) {
    questPath <- "../scalepool/fullScale.csv"
  } else {
    questPath <- paste0("./scalepool/", quest_name)
  }
  outputDir <- "./server/www/"
}

dat <- tibble::as_tibble (read.csv (questPath,
				    header = TRUE,
				    na.strings = "",
				    fill = FALSE
				    ))

## split out questionnaire part
quest <- dat[, c("question", "q_choices", "q_required")] |> 
  dplyr::filter(!is.na(question)) |> tibble::as_tibble()
colnames(quest)[colnames(quest) == "question"] <- "prompt"
colnames(quest)[colnames(quest) == "q_choices"] <- "choices"

if (any(quest$q_required != "y" & quest$q_required != "n")) {
  print (quest$q_required)
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
    stop ('Column "q_choices" not properly defined.')
  }
}

scaleJSON <- jsonlite::toJSON(quest_js, pretty = TRUE)

					# split out demographic part
demo <- dat[, c("demo_var", "d_question", "d_choices", "d_required")] |> 
  dplyr::filter(demo_var != "NA")
colnames(demo)[colnames(demo) == "d_question"] <- "prompt"
colnames(demo)[colnames(demo) == "d_choices"] <- "choices"

demo_strvar <- demo |> 
  dplyr::filter (is.na(demo$choices)) |> 
  dplyr::mutate (choices = list (NA))

demo_catvar <- demo |> 
  dplyr::filter (!is.na(choices)) |> 
  dplyr::mutate (choices = purrr::map(choices,
				      \(.x) unlist (strsplit(.x, split = "/"))))
demo_js <- dplyr::bind_rows(demo_strvar, demo_catvar)
demoJSON <- jsonlite::toJSON(demo_js, pretty = TRUE)


write(scaleJSON, paste0(outputDir, "scale.json"))
write(demoJSON, paste0(outputDir, "demo.json"))
