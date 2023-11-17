if (!interactive()) {
  dat <- data.frame (read.csv (paste0 ("./scalepool/", quest_name),
    header = FALSE))
  } else {
  dat <- data.frame (read.csv ('./scalepool/testScale.csv', header = FALSE))
}

names(dat)[1] <- "prompt"
scaleJSON <- jsonlite::toJSON (dat, pretty = TRUE)
write(scaleJSON, "./server/www/scale.json")
