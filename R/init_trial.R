args <- commandArgs(TRUE)

if (length (args) == 0) {
  stop ("The length of the questionnaire is needed, while the size of randomized order is optional.")
}

q.length <- as.numeric (args [1])

if (is.na (args [2])) {
  rd.size <- q.length
} else {
  rd.size <- as.numeric (args [2])
}

source ("R/generate_order.R")

con <- DBI::dbConnect(
                RMariaDB::MariaDB(),
                host = '127.0.0.1',
                port = '3306',
                user = 'root',
                password = 'example',
                dbname = 'rt_survey_test'
)

## Before making sure the randomized orders will be exactly the same under a specific seed, only run once.

DBI::dbWriteTable (con, paste0 ("order_list_", q.length), o.record, overwrite = TRUE)
DBI::dbWriteTable (con, paste0 ("frequency_counter_", q.length), f.record, overwrite = TRUE)
DBI::dbWriteTable (con, paste0 ("order_match_", q.length), match.record, overwrite = TRUE)

query <- paste ("ALTER TABLE", paste0 ("order_match_", q.length), "MODIFY order_label VARCHAR(999)", sep = " ")

rs <- DBI::dbSendStatement (con, query)
DBI::dbClearResult (rs)

query <- paste ("ALTER TABLE", paste0 ("order_match_", q.length), "MODIFY p_id VARCHAR(999)", sep = " ")

rs <- DBI::dbSendStatement (con, query)
DBI::dbClearResult (rs)

DBI::dbDisconnect (con)
